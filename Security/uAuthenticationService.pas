unit uAuthenticationService;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  uPasswordHasher,
  uUserSession;

type
  TAuthenticationService = class
  private
    class procedure UpdateFailedLogin(
      AConnection: TFDConnection;
      AUserID: Integer;
      ACount: Integer;
      ALock: Boolean
    );

  public
    const MAX_FAILED_LOGIN = 5;

    class function Login(
      AConnection: TFDConnection;
      const AUserName: string;
      const APassword: string
    ): Boolean;

    class procedure Logout;

  end;

implementation

class function TAuthenticationService.Login(
  AConnection: TFDConnection;
  const AUserName: string;
  const APassword: string
): Boolean;

var
  Q: TFDQuery;
  UserID: Integer;
  UserName: string;
  FullName: string;
  Email: string;
  Hash: string;
  IsActive: Boolean;
  IsLocked: Boolean;
  IsAdmin: Boolean;
  FailedLoginCount: Integer;

begin

  Result := False;

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'SELECT ' +
      'ID, ' +
      'UserName, ' +
      'FullName, ' +
      'Email, ' +
      'PasswordHash, ' +
      'IsActive, ' +
      'IsLocked, ' +
      'IsAdmin, ' +
      'FailedLoginCount ' +
      'FROM Users ' +
      'WHERE UserName = :UserName';

    Q.ParamByName('UserName').AsString := AUserName;

    Q.Open;

    if Q.Eof then
      Exit;

    UserID :=
      Q.FieldByName('ID').AsInteger;

    UserName :=
      Q.FieldByName('UserName').AsString;

    FullName :=
      Q.FieldByName('FullName').AsString;

    Email :=
      Q.FieldByName('Email').AsString;

    Hash :=
      Q.FieldByName('PasswordHash').AsString;

    IsActive :=
      Q.FieldByName('IsActive').AsBoolean;

    IsLocked :=
      Q.FieldByName('IsLocked').AsBoolean;

    IsAdmin :=
      Q.FieldByName('IsAdmin').AsBoolean;

    FailedLoginCount :=
      Q.FieldByName('FailedLoginCount').AsInteger;

    if not IsActive then
      Exit;

    if IsLocked then
      Exit;

    if not TPasswordHasher.VerifyPassword(
      APassword,
      Hash
    ) then
    begin

      Inc(FailedLoginCount);

      if FailedLoginCount >= MAX_FAILED_LOGIN then
      begin

        UpdateFailedLogin(
          AConnection,
          UserID,
          FailedLoginCount,
          True
        );

        Exit;

      end;

      UpdateFailedLogin(
        AConnection,
        UserID,
        FailedLoginCount,
        False
      );

      Exit;

    end;

    TUserSession.Login(
      UserID,
      UserName,
      FullName,
      Email,
      IsAdmin
    );

    Q.Close;

    Q.SQL.Text :=
      'UPDATE Users ' +
      'SET ' +
      'FailedLoginCount = 0, ' +
      'LastLoginDate = GETDATE() ' +
      'WHERE ID = :ID';

    Q.ParamByName('ID').AsInteger := UserID;

    Q.ExecSQL;

    Result := True;

  finally

    Q.Free;

  end;

end;

class procedure TAuthenticationService.Logout;
begin
  TUserSession.Logout;
end;

class procedure TAuthenticationService.UpdateFailedLogin(
  AConnection: TFDConnection;
  AUserID: Integer;
  ACount: Integer;
  ALock: Boolean
);

var
  Q: TFDQuery;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    if ALock then
      Q.SQL.Text :=
        'UPDATE Users ' +
        'SET ' +
        'FailedLoginCount = :Count, ' +
        'IsLocked = 1, ' +
        'LockDate = GETDATE() ' +
        'WHERE ID = :ID'
    else
      Q.SQL.Text :=
        'UPDATE Users ' +
        'SET ' +
        'FailedLoginCount = :Count ' +
        'WHERE ID = :ID';

    Q.ParamByName('Count').AsInteger := ACount;
    Q.ParamByName('ID').AsInteger := AUserID;

    Q.ExecSQL;

  finally

    Q.Free;

  end;

end;

end.
