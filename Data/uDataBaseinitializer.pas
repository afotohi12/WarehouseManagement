unit uDatabaseInitializer;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  uConnectionManager,
  uUserSeeder,
  uDatabaseMigrator;


type

  TDatabaseInitializer = class
  private

    class function DatabaseExists(
      AConnection: TFDConnection;
      const ADatabaseName: string
    ): Boolean;


    class procedure CreateDatabase(
      AConnection: TFDConnection;
      const ADatabaseName: string
    );

  public

    class procedure Initialize;

  end;


implementation




class function TDatabaseInitializer.DatabaseExists(
  AConnection: TFDConnection;
  const ADatabaseName: string
): Boolean;

var
  Q: TFDQuery;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'SELECT DB_ID(:DBNAME) AS DBID';


    Q.ParamByName('DBNAME').AsString :=
      ADatabaseName;


    Q.Open;


    Result :=
      not Q.FieldByName('DBID').IsNull;


  finally

    Q.Free;

  end;

end;



class procedure TDatabaseInitializer.CreateDatabase(
  AConnection: TFDConnection;
  const ADatabaseName: string
);

var
  Q: TFDQuery;
  SafeName: string;

begin

  SafeName :=
    StringReplace(
      ADatabaseName,
      ']',
      ']]',
      [rfReplaceAll]
    );


  Q := TFDQuery.Create(nil);

  try

    Q.Connection :=
      AConnection;


    Q.SQL.Text :=
      Format(
        'CREATE DATABASE [%s]',
        [SafeName]
      );


    Q.ExecSQL;


  finally

    Q.Free;

  end;

end;



class procedure TDatabaseInitializer.Initialize;

var
  Conn: TFDConnection;
  DBName: string;

begin

  DBName :=
    TConnectionManager.GetDatabaseName;


  Conn :=
    TFDConnection.Create(nil);


  try

    TConnectionManager.ConfigureForMaster(
      Conn
    );


    TConnectionManager.Connect(
      Conn
    );


    if not DatabaseExists(
      Conn,
      DBName
    ) then

      CreateDatabase(
        Conn,
        DBName
      );


    TConnectionManager.SwitchDatabase(
      Conn,
      DBName
    );


    TDatabaseMigrator.Migrate(
      Conn
    );

    TUserSeeder.CreateDefaultUser(
  Conn
);

  finally

    TConnectionManager.Disconnect(
      Conn
    );


    Conn.Free;

  end;

end;


end.
