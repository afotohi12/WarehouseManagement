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

    class function Login(
      AConnection: TFDConnection;
      const AUserName: string;
      const APassword: string
    ): Boolean;
    const MAX_FAILED_LOGIN = 5;
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
  Hash: string;
  IsActive: Boolean;
  IsLocked: Boolean;
  FailedLoginCount: Integer;

begin

  Result := False;


  Q := TFDQuery.Create(nil);

  try

    Q.Connection :=
      AConnection;


    Q.SQL.Text :=
    'SELECT ID, UserName, FullName, PasswordHash, ' +
    'IsActive, IsLocked, FailedLoginCount ' +
    'FROM Users ' +
    'WHERE UserName = :UserName';



    Q.ParamByName('UserName').AsString :=
      AUserName;


    Q.Open;


    if Q.Eof then
      Exit;



    UserID :=
      Q.FieldByName('ID').AsInteger;


    Hash :=
      Q.FieldByName('PasswordHash').AsString;


    IsActive :=
      Q.FieldByName('IsActive').AsBoolean;

    IsLocked := Q.FieldByName('IsLocked').AsBoolean;

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
          AUserName
        );


      Q.Close;

    Q.SQL.Text :=
      'UPDATE Users '+
      'SET FailedLoginCount=0,'+
      'LastLoginDate=GETDATE() '+
      'WHERE ID=:ID';

    Q.ParamByName('ID').AsInteger :=
      UserID;

    Q.ExecSQL;

        Result := True;


      finally

        Q.Free;

  end;

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
        'UPDATE Users '+
        'SET FailedLoginCount=:Count,'+
        'IsLocked=1,'+
        'LockDate=GETDATE() '+
        'WHERE ID=:ID'
    else
      Q.SQL.Text :=
        'UPDATE Users '+
        'SET FailedLoginCount=:Count '+
        'WHERE ID=:ID';

    Q.ParamByName('Count').AsInteger := ACount;
    Q.ParamByName('ID').AsInteger := AUserID;

    Q.ExecSQL;

  finally

    Q.Free;

  end;

end;

end.
