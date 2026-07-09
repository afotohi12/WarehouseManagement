unit uUserSession;

interface

type

  TUserSession = class
  private

    class var FUserID: Integer;

    class var FUserName: string;


  public


    class procedure Login(
      AUserID: Integer;
      const AUserName: string
    );


    class procedure Logout;


    class function IsLoggedIn: Boolean;



    class property UserID: Integer read FUserID;

    class property UserName: string read FUserName;

  end;


implementation


class procedure TUserSession.Login(
  AUserID: Integer;
  const AUserName: string
);

begin

  FUserID :=
    AUserID;


  FUserName :=
    AUserName;

end;



class procedure TUserSession.Logout;

begin

  FUserID :=
    0;


  FUserName :=
    '';

end;



class function TUserSession.IsLoggedIn: Boolean;

begin

  Result :=
    FUserID > 0;

end;


end.
