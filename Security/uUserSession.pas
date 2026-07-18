unit uUserSession;

interface

uses
  System.SysUtils;

type
  TUserSession = class
  private
    class var FUserID: Integer;
    class var FUserName: string;
    class var FFullName: string;
    class var FEmail: string;
    class var FIsAdmin: Boolean;
    class var FLoginTime: TDateTime;

  public

    class procedure Login(
      AUserID: Integer;
      const AUserName: string;
      const AFullName: string;
      const AEmail: string;
      AIsAdmin: Boolean
    );

    class procedure Logout;

    class function IsLoggedIn: Boolean;

    class property UserID: Integer read FUserID;
    class property UserName: string read FUserName;
    class property FullName: string read FFullName;
    class property Email: string read FEmail;
    class property IsAdmin: Boolean read FIsAdmin;
    class property LoginTime: TDateTime read FLoginTime;

  end;

implementation

class procedure TUserSession.Login(
  AUserID: Integer;
  const AUserName: string;
  const AFullName: string;
  const AEmail: string;
  AIsAdmin: Boolean
);
begin

  FUserID := AUserID;
  FUserName := AUserName;
  FFullName := AFullName;
  FEmail := AEmail;
  FIsAdmin := AIsAdmin;
  FLoginTime := Now;

end;

class procedure TUserSession.Logout;
begin

  FUserID := 0;
  FUserName := '';
  FFullName := '';
  FEmail := '';
  FIsAdmin := False;
  FLoginTime := 0;

end;

class function TUserSession.IsLoggedIn: Boolean;
begin
  Result := FUserID > 0;
end;

end.
