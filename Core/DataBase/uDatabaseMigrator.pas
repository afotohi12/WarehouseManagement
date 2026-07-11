unit uDatabaseMigrator;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Hash,
  FireDAC.Comp.Client;

type

  TDatabaseMigrator = class
  private

    const
      VERSION_TAG = '/*VERSION:';


    class function GetUpgradeFileName: string;
    class function NormalizeScript(AText: string): string;
    class function LoadUpgradeScript: TStringList;


    class procedure CreateSystemTables(
      AConnection: TFDConnection
    );


    class function GetCurrentVersion(
      AConnection: TFDConnection
    ): Integer;


    class function GetLastScriptVersion(
      ALines: TStringList
    ): Integer;


    class function CreateVersionScript(
      ALines: TStringList;
      AVersion: Integer
    ): TStringList;


    class function CalculateChecksum(
      AText: string
    ): string;


    class procedure SaveVersion(
      AConnection: TFDConnection;
      AVersion: Integer;
      AChecksum: string
    );


    class procedure WriteLog(
      AConnection: TFDConnection;
      AVersion: Integer;
      AChecksum: string;
      ASuccess: Boolean;
      AErrorMessage: string
    );


    class procedure ExecuteScript(
      AConnection: TFDConnection;
      AScript: TStringList
    );


    class procedure ValidateMigrationHistory(
      AConnection: TFDConnection;
      ALines: TStringList
    );


  public

    class procedure Migrate(
      AConnection: TFDConnection
    );

  end;


implementation



class function TDatabaseMigrator.GetUpgradeFileName: string;
begin

  Result :=
    IncludeTrailingPathDelimiter(
      ExtractFilePath(
        ParamStr(0)
      )
    )
    +
    'Database\Scripts\Upgrade.sql';

end;



class function TDatabaseMigrator.LoadUpgradeScript: TStringList;
begin

  Result :=
    TStringList.Create;


  if not FileExists(
    GetUpgradeFileName
  ) then

    raise Exception.CreateFmt(
      'Migration file not found:%s',
      [
        GetUpgradeFileName
      ]
    );


  Result.LoadFromFile(
    GetUpgradeFileName
  );

end;



class procedure TDatabaseMigrator.CreateSystemTables(
  AConnection: TFDConnection
);

begin


  AConnection.ExecSQL(
    'IF OBJECT_ID(''DatabaseVersion'') IS NULL '+
    'BEGIN '+
    'CREATE TABLE DatabaseVersion('+
    'ID INT IDENTITY(1,1) PRIMARY KEY,'+
    'VersionNo INT NOT NULL,'+
    'Checksum VARCHAR(64) NOT NULL,'+
    'ExecuteDate DATETIME NOT NULL DEFAULT GETDATE()) '+
    'END'
  );



  AConnection.ExecSQL(
    'IF OBJECT_ID(''DatabaseMigrationLog'') IS NULL '+
    'BEGIN '+
    'CREATE TABLE DatabaseMigrationLog('+
    'ID INT IDENTITY(1,1) PRIMARY KEY,'+
    'VersionNo INT NOT NULL,'+
    'Checksum VARCHAR(64) NOT NULL,'+
    'StartDate DATETIME NOT NULL,'+
    'EndDate DATETIME NULL,'+
    'Success BIT NOT NULL,'+
    'ErrorMessage NVARCHAR(MAX) NULL) '+
    'END'
  );


end;



class function TDatabaseMigrator.GetCurrentVersion(
  AConnection: TFDConnection
): Integer;

var
  Q: TFDQuery;

begin

  Q :=
    TFDQuery.Create(nil);


  try

    Q.Connection :=
      AConnection;


    Q.SQL.Text :=
      'SELECT ISNULL(MAX(VersionNo),0) AS V '+
      'FROM DatabaseVersion';


    Q.Open;


    Result :=
      Q.FieldByName('V').AsInteger;


  finally

    Q.Free;

  end;

end;



class function TDatabaseMigrator.GetLastScriptVersion(
  ALines: TStringList
): Integer;

var

  I: Integer;

  S: string;


begin

  Result := 0;


  for I := 0 to ALines.Count-1 do

  begin

    S :=
      Trim(
        ALines[I]
      );


    if Pos(
      VERSION_TAG,
      S
    ) = 1 then

    begin

      S :=
        StringReplace(
          S,
          VERSION_TAG,
          '',
          []
        );


      S :=
        StringReplace(
          S,
          '*/',
          '',
          []
        );


      Result :=
        StrToIntDef(
          Trim(S),
          Result
        );

    end;

  end;

end;



class function TDatabaseMigrator.CreateVersionScript(
  ALines: TStringList;
  AVersion: Integer
): TStringList;

var

  I: Integer;

  Active: Boolean;

  Tag: string;


begin

  Result :=
    TStringList.Create;


  Active :=
    False;


  Tag :=
    VERSION_TAG+
    IntToStr(AVersion)+
    '*/';



  for I := 0 to ALines.Count-1 do

  begin

    if SameText(
      Trim(ALines[I]),
      Tag
    ) then

    begin

      Active :=
        True;

      Continue;

    end;



    if Active and
       (Pos(
        VERSION_TAG,
        Trim(ALines[I])
       ) = 1) then

      Break;



    if Active then

      Result.Add(
        ALines[I]
      );


  end;


end;
class function TDatabaseMigrator.CalculateChecksum(
  AText: string
): string;
begin

  Result :=
    THashSHA2.GetHashString(
      NormalizeScript(AText)
    );
end;



class procedure TDatabaseMigrator.SaveVersion(
  AConnection: TFDConnection;
  AVersion: Integer;
  AChecksum: string
);

var
  Q: TFDQuery;

begin

  Q :=
    TFDQuery.Create(nil);

  try

    Q.Connection :=
      AConnection;


    Q.SQL.Text :=
      'INSERT INTO DatabaseVersion '+
      '(VersionNo,Checksum,ExecuteDate) '+
      'VALUES(:V,:C,GETDATE())';


    Q.ParamByName('V').AsInteger :=
      AVersion;


    Q.ParamByName('C').AsString :=
      AChecksum;


    Q.ExecSQL;


  finally

    Q.Free;

  end;

end;



class procedure TDatabaseMigrator.WriteLog(
  AConnection: TFDConnection;
  AVersion: Integer;
  AChecksum: string;
  ASuccess: Boolean;
  AErrorMessage: string
);

var
  Q: TFDQuery;

begin

  Q :=
    TFDQuery.Create(nil);


  try

    Q.Connection :=
      AConnection;


    Q.SQL.Text :=
      'INSERT INTO DatabaseMigrationLog '+
      '(VersionNo,Checksum,StartDate,EndDate,Success,ErrorMessage) '+
      'VALUES(:V,:C,GETDATE(),GETDATE(),:S,:E)';


    Q.ParamByName('V').AsInteger :=
      AVersion;


    Q.ParamByName('C').AsString :=
      AChecksum;


    Q.ParamByName('S').AsBoolean :=
      ASuccess;


    Q.ParamByName('E').AsString :=
      AErrorMessage;



    Q.ExecSQL;


  finally

    Q.Free;

  end;

end;



class procedure TDatabaseMigrator.ValidateMigrationHistory(
  AConnection: TFDConnection;
  ALines: TStringList
);

var

  Q: TFDQuery;

  Script: TStringList;

  Version: Integer;

  OldChecksum: string;

  NewChecksum: string;


begin

  Q :=
    TFDQuery.Create(nil);


  try

    Q.Connection :=
      AConnection;


    Q.SQL.Text :=
      'SELECT VersionNo,Checksum '+
      'FROM DatabaseVersion';


    Q.Open;



    while not Q.Eof do

    begin

      Version :=
        Q.FieldByName(
          'VersionNo'
        ).AsInteger;


      OldChecksum :=
        Q.FieldByName(
          'Checksum'
        ).AsString;



      Script :=
        CreateVersionScript(
          ALines,
          Version
        );


      try

        NewChecksum :=
          CalculateChecksum(
            Script.Text
          );


          if OldChecksum <> NewChecksum then
          begin
            raise Exception.CreateFmt(
              'Migration Version %d has been modified.' + sLineBreak +
              'Stored Checksum : %s' + sLineBreak +
              'Current Checksum: %s',
              [
                Version,
                OldChecksum,
                NewChecksum
              ]
            );
          end;


      finally

        Script.Free;

      end;



      Q.Next;

    end;


  finally

    Q.Free;

  end;

end;



class procedure TDatabaseMigrator.ExecuteScript(
  AConnection: TFDConnection;
  AScript: TStringList
);

var

  Q: TFDQuery;

  Batch: TStringList;

  I: Integer;



procedure ExecuteBatch;

begin

  if Trim(Batch.Text)='' then

    Exit;


  Q.SQL.Text :=
    Batch.Text;


  Q.ExecSQL;


  Batch.Clear;


end;


begin


  Q :=
    TFDQuery.Create(nil);


  Batch :=
    TStringList.Create;



  try


    Q.Connection :=
      AConnection;



    for I := 0 to AScript.Count-1 do

    begin

      if SameText(
        Trim(AScript[I]),
        'GO'
      ) then

        ExecuteBatch

      else

        Batch.Add(
          AScript[I]
        );


    end;



    ExecuteBatch;



  finally


    Batch.Free;

    Q.Free;


  end;

end;



class procedure TDatabaseMigrator.Migrate(
  AConnection: TFDConnection
);

var

  Lines: TStringList;

  Script: TStringList;

  CurrentVersion: Integer;

  LastVersion: Integer;

  Version: Integer;

  Checksum: string;


begin


  Lines :=
    nil;


  try


    CreateSystemTables(
      AConnection
    );



    Lines :=
      LoadUpgradeScript;



    ValidateMigrationHistory(
      AConnection,
      Lines
    );



    CurrentVersion :=
      GetCurrentVersion(
        AConnection
      );



    LastVersion :=
      GetLastScriptVersion(
        Lines
      );



    if CurrentVersion >= LastVersion then

      Exit;



    for Version :=
      CurrentVersion + 1
      to LastVersion do

    begin


      Script :=
        CreateVersionScript(
          Lines,
          Version
        );


      try


        if Script.Count = 0 then

          raise Exception.CreateFmt(
            'Version %d script not found.',
            [
              Version
            ]
          );



        Checksum :=
          CalculateChecksum(
            Script.Text
          );



        AConnection.StartTransaction;


        try


          ExecuteScript(
            AConnection,
            Script
          );



          SaveVersion(
            AConnection,
            Version,
            Checksum
          );



          WriteLog(
            AConnection,
            Version,
            Checksum,
            True,
            ''
          );



          AConnection.Commit;



        except


          on E: Exception do

          begin

           if AConnection.InTransaction then
              AConnection.Rollback;

            AConnection.StartTransaction;

            try

              WriteLog(
                AConnection,
                Version,
                Checksum,
                False,
                E.Message
              );

              AConnection.Commit;

              except

                if AConnection.InTransaction then
                  AConnection.Rollback;

              end;

              raise;


          end;


        end;



      finally

        Script.Free;

      end;


    end;



  finally

    Lines.Free;

  end;


end;



class function TDatabaseMigrator.NormalizeScript(
  AText: string
): string;

var
  Lines: TStringList;
  I: Integer;
  S: string;

begin

  Lines := TStringList.Create;

  try

    Lines.Text := AText;

    Result := '';

    for I := 0 to Lines.Count - 1 do
    begin

      S := Trim(Lines[I]);


      if S <> '' then
      begin
        Result :=
          Result +
          S +
          #13#10;
      end;

    end;

  finally

    Lines.Free;

  end;

end;

end.
