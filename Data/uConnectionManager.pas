unit uConnectionManager;

interface

uses
  System.SysUtils,
  System.IniFiles,
  FireDAC.Comp.Client,
  Vcl.Dialogs;

type
  TConnectionManager = class
  private
    class procedure LoadConfiguration(AConnection: TFDConnection);

    class function GetConfigFileName: string;

    class function EscapeIdentifier(const Value: string): string;

  public

    class procedure Configure(AConnection: TFDConnection);

    class procedure ConfigureForMaster(AConnection: TFDConnection);

    class procedure Connect(AConnection: TFDConnection);

    class procedure Disconnect(AConnection: TFDConnection);

    class procedure SwitchDatabase(AConnection: TFDConnection;
      const ADatabaseName: string);

    class procedure CreateDatabaseIfNotExists(AConnection: TFDConnection);

    class function GetDatabaseName: string;

  end;

implementation

const

  SECTION_DATABASE = 'Database';

  KEY_SERVER = 'Server';
  KEY_DATABASE = 'Database';
  KEY_USERNAME = 'UserName';
  KEY_PASSWORD = 'Password';

  KEY_ENCRYPT = 'Encrypt';

  KEY_TRUST_CERTIFICATE = 'TrustServerCertificate';

  DATABASE_MASTER = 'master';

  { TConnectionManager }

class procedure TConnectionManager.Configure(AConnection: TFDConnection);
begin

  if not Assigned(AConnection) then
    raise Exception.Create('Connection is nil.');

  LoadConfiguration(AConnection);

end;

class procedure TConnectionManager.ConfigureForMaster
  (AConnection: TFDConnection);
begin

  Configure(AConnection);

  AConnection.Params.Values['Database'] := DATABASE_MASTER;

end;

class procedure TConnectionManager.Connect(AConnection: TFDConnection);
begin

  if not Assigned(AConnection) then
    raise Exception.Create('Connection is nil.');

  if not AConnection.Connected then
  begin

    try

      AConnection.Connected := True;

    except

      on E: Exception do

        raise Exception.Create('Cannot connect to SQL Server:' + sLineBreak +
          E.Message);

    end;

  end;

end;

class procedure TConnectionManager.Disconnect(AConnection: TFDConnection);
begin

  if Assigned(AConnection) then

    if AConnection.Connected then

      AConnection.Close;

end;

class procedure TConnectionManager.CreateDatabaseIfNotExists
  (AConnection: TFDConnection);
var
  SQL: string;
  DBName: string;

begin

  DBName := GetDatabaseName;

  SQL := Format('IF DB_ID(''%s'') IS NULL ' + 'BEGIN ' + 'CREATE DATABASE [%s] '
    + 'END', [DBName, EscapeIdentifier(DBName)]);

  AConnection.ExecSQL(SQL);

end;

class procedure TConnectionManager.SwitchDatabase(AConnection: TFDConnection;
  const ADatabaseName: string);
begin

  if Trim(ADatabaseName) = '' then

    raise Exception.Create('Database name is empty.');

  Disconnect(AConnection);

  AConnection.Params.Values['Database'] := ADatabaseName;

  Connect(AConnection);

end;

class function TConnectionManager.GetDatabaseName: string;
var
  Ini: TIniFile;

begin

  Ini := TIniFile.Create(GetConfigFileName);

  try

    Result := Trim(Ini.ReadString(SECTION_DATABASE, KEY_DATABASE, ''));

    if Result = '' then

      raise Exception.Create('Database name not defined.');

  finally

    Ini.Free;

  end;

end;

class function TConnectionManager.GetConfigFileName: string;
begin

  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
    'Config\Config.ini';

end;

class procedure TConnectionManager.LoadConfiguration
  (AConnection: TFDConnection);
var
  Ini: TIniFile;
begin

  if not FileExists(GetConfigFileName) then
    raise Exception.Create('Config.ini not found.');

  Ini := TIniFile.Create(GetConfigFileName);

  try

    AConnection.Close;

    AConnection.Params.Clear;

    AConnection.Params.Add('DriverID=MSSQL');

    AConnection.Params.Add('Server=' + Trim(Ini.ReadString(SECTION_DATABASE,
      KEY_SERVER, '')));

    AConnection.Params.Values['Database'] :=
      Trim(Ini.ReadString(SECTION_DATABASE, KEY_DATABASE, 'master'));

    AConnection.Params.Add('User_Name=' + Trim(Ini.ReadString(SECTION_DATABASE,
      KEY_USERNAME, '')));

    AConnection.Params.Add('Password=' + Trim(Ini.ReadString(SECTION_DATABASE,
      KEY_PASSWORD, '')));

    AConnection.Params.Add('OSAuthent=No');

    AConnection.LoginPrompt := False;

  finally

    Ini.Free;

  end;

end;

class function TConnectionManager.EscapeIdentifier(const Value: string): string;
begin

  Result := StringReplace(Value, ']', ']]', [rfReplaceAll]);

end;

end.
