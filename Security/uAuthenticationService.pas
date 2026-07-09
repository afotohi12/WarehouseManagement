unit uAuthenticationService;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  uPasswordHasher,
  uUserSession;

type

  TAuthenticationService = class
  public

    class function Login(
      AConnection: TFDConnection;
      const AUserName: string;
      const APassword: string
    ): Boolean;

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

begin

  Result := False;


  Q := TFDQuery.Create(nil);

  try

    Q.Connection :=
      AConnection;


    Q.SQL.Text :=
      'SELECT ID, PasswordHash, IsActive '+
      'FROM Users '+
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



    if not IsActive then
      Exit;



    if not TPasswordHasher.VerifyPassword(
      APassword,
      Hash
    ) then
      Exit;



    TUserSession.Login(
      UserID,
      AUserName
    );


    Result := True;


  finally

    Q.Free;

  end;

end;


end.
