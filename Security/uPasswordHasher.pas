unit uPasswordHasher;

interface

uses
  System.SysUtils,
  System.Hash;

type

  TPasswordHasher = class
  public

    class function HashPassword(
      const APassword: string
    ): string;


    class function VerifyPassword(
      const APassword: string;
      const AHash: string
    ): Boolean;

  end;


implementation


class function TPasswordHasher.HashPassword(
  const APassword: string
): string;

begin

  Result :=
    THashSHA2.GetHashString(
      APassword
    );

end;



class function TPasswordHasher.VerifyPassword(
  const APassword: string;
  const AHash: string
): Boolean;

begin

  Result :=
    SameText(
      HashPassword(APassword),
      AHash
    );

end;


end.
