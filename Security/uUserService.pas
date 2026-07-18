unit uUserService;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client;

type

  TUserService = class
  public

    class function UserExists(
      AConnection: TFDConnection;
      const AUserName: string
    ): Boolean;

    class function GetUserID(
      AConnection: TFDConnection;
      const AUserName: string
    ): Integer;

    class function GetFullName(
      AConnection: TFDConnection;
      AUserID: Integer
    ): string;

    class procedure CreateUser(
      AConnection: TFDConnection;
      const AUserName: string;
      const APassword: string;
      const AFullName: string;
      const AEmail: string;
      AIsAdmin: Boolean
    );

    class procedure UpdateUser(
      AConnection: TFDConnection;
      AUserID: Integer;
      const AFullName: string;
      const AEmail: string;
      AIsAdmin: Boolean;
      AIsActive: Boolean
    );

    class procedure ChangePassword(
      AConnection: TFDConnection;
      AUserID: Integer;
      const ANewPassword: string
    );

    class procedure ResetPassword(
      AConnection: TFDConnection;
      AUserID: Integer;
      const ANewPassword: string
    );

    class procedure UnlockUser(
      AConnection: TFDConnection;
      AUserID: Integer
    );

    class procedure SetActive(
      AConnection: TFDConnection;
      AUserID: Integer;
      AActive: Boolean
    );

    class procedure DeleteUser(
      AConnection: TFDConnection;
      AUserID: Integer
    );

  end;

implementation

uses
  uPasswordHasher;

  class function TUserService.UserExists(
  AConnection: TFDConnection;
  const AUserName: string
): Boolean;

var
  Q: TFDQuery;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'SELECT COUNT(*) CNT ' +
      'FROM Users ' +
      'WHERE UserName=:UserName';

    Q.ParamByName('UserName').AsString := AUserName;

    Q.Open;

    Result :=
      Q.FieldByName('CNT').AsInteger > 0;

  finally

    Q.Free;

  end;

end;


class function TUserService.GetUserID(
  AConnection: TFDConnection;
  const AUserName: string
): Integer;

var
  Q: TFDQuery;

begin

  Result := 0;

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'SELECT ID ' +
      'FROM Users ' +
      'WHERE UserName=:UserName';

    Q.ParamByName('UserName').AsString := AUserName;

    Q.Open;

    if not Q.Eof then
      Result := Q.FieldByName('ID').AsInteger;

  finally

    Q.Free;

  end;

end;


class function TUserService.GetFullName(
  AConnection: TFDConnection;
  AUserID: Integer
): string;

var
  Q: TFDQuery;

begin

  Result := '';

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'SELECT FullName ' +
      'FROM Users ' +
      'WHERE ID=:ID';

    Q.ParamByName('ID').AsInteger := AUserID;

    Q.Open;

    if not Q.Eof then
      Result := Q.FieldByName('FullName').AsString;

  finally

    Q.Free;

  end;

end;
  class procedure TUserService.CreateUser(
  AConnection: TFDConnection;
  const AUserName: string;
  const APassword: string;
  const AFullName: string;
  const AEmail: string;
  AIsAdmin: Boolean
);

var
  Q: TFDQuery;

begin

  if UserExists(
    AConnection,
    AUserName
  ) then
    raise Exception.Create('User already exists.');

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'INSERT INTO Users (' +
      'UserName,' +
      'PasswordHash,' +
      'FullName,' +
      'Email,' +
      'IsAdmin,' +
      'IsActive,' +
      'CreateDate' +
      ') VALUES (' +
      ':UserName,' +
      ':PasswordHash,' +
      ':FullName,' +
      ':Email,' +
      ':IsAdmin,' +
      '1,' +
      'GETDATE()' +
      ')';

    Q.ParamByName('UserName').AsString :=
      AUserName;

    Q.ParamByName('PasswordHash').AsString :=
      TPasswordHasher.HashPassword(APassword);

    Q.ParamByName('FullName').AsString :=
      AFullName;

    Q.ParamByName('Email').AsString :=
      AEmail;

    Q.ParamByName('IsAdmin').AsBoolean :=
      AIsAdmin;

    Q.ExecSQL;

  finally

    Q.Free;

  end;

end;


class procedure TUserService.UpdateUser(
  AConnection: TFDConnection;
  AUserID: Integer;
  const AFullName: string;
  const AEmail: string;
  AIsAdmin: Boolean;
  AIsActive: Boolean
);

var
  Q: TFDQuery;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'UPDATE Users SET ' +
      'FullName=:FullName,' +
      'Email=:Email,' +
      'IsAdmin=:IsAdmin,' +
      'IsActive=:IsActive,' +
      'ModifiedDate=GETDATE() ' +
      'WHERE ID=:ID';

    Q.ParamByName('FullName').AsString :=
      AFullName;

    Q.ParamByName('Email').AsString :=
      AEmail;

    Q.ParamByName('IsAdmin').AsBoolean :=
      AIsAdmin;

    Q.ParamByName('IsActive').AsBoolean :=
      AIsActive;

    Q.ParamByName('ID').AsInteger :=
      AUserID;

    Q.ExecSQL;

  finally

    Q.Free;

  end;

end;



class procedure TUserService.ChangePassword(
  AConnection: TFDConnection;
  AUserID: Integer;
  const ANewPassword: string
);

var
  Q: TFDQuery;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'UPDATE Users SET ' +
      'PasswordHash=:PasswordHash,' +
      'PasswordChangedDate=GETDATE(),' +
      'MustChangePassword=0 ' +
      'WHERE ID=:ID';

    Q.ParamByName('PasswordHash').AsString :=
      TPasswordHasher.HashPassword(ANewPassword);

    Q.ParamByName('ID').AsInteger :=
      AUserID;

    Q.ExecSQL;

  finally

    Q.Free;

  end;

end;


class procedure TUserService.ResetPassword(
  AConnection: TFDConnection;
  AUserID: Integer;
  const ANewPassword: string
);

var
  Q: TFDQuery;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'UPDATE Users SET ' +
      'PasswordHash=:PasswordHash,' +
      'MustChangePassword=1,' +
      'PasswordChangedDate=GETDATE() ' +
      'WHERE ID=:ID';

    Q.ParamByName('PasswordHash').AsString :=
      TPasswordHasher.HashPassword(ANewPassword);

    Q.ParamByName('ID').AsInteger :=
      AUserID;

    Q.ExecSQL;

  finally

    Q.Free;

  end;

end;


class procedure TUserService.UnlockUser(
  AConnection: TFDConnection;
  AUserID: Integer
);

var
  Q: TFDQuery;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'UPDATE Users SET ' +
      'IsLocked=0,' +
      'FailedLoginCount=0,' +
      'LockDate=NULL ' +
      'WHERE ID=:ID';

    Q.ParamByName('ID').AsInteger :=
      AUserID;

    Q.ExecSQL;

  finally

    Q.Free;

  end;

end;


class procedure TUserService.SetActive(
  AConnection: TFDConnection;
  AUserID: Integer;
  AActive: Boolean
);

var
  Q: TFDQuery;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'UPDATE Users SET ' +
      'IsActive=:IsActive ' +
      'WHERE ID=:ID';

    Q.ParamByName('IsActive').AsBoolean :=
      AActive;

    Q.ParamByName('ID').AsInteger :=
      AUserID;

    Q.ExecSQL;

  finally

    Q.Free;

  end;

end;


class procedure TUserService.DeleteUser(
  AConnection: TFDConnection;
  AUserID: Integer
);

var
  Q: TFDQuery;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'DELETE FROM Users ' +
      'WHERE ID=:ID';

    Q.ParamByName('ID').AsInteger :=
      AUserID;

    Q.ExecSQL;

  finally

    Q.Free;

  end;

end;

end.

