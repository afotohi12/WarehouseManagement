unit uAuthorization;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  uPermissionService,
  uUserSession;

type

  TAuthorization = class
  public

    class procedure Check(
      AConnection: TFDConnection;
      const APermissionCode: string
    );
  end;

implementation

class procedure TAuthorization.Check(
  AConnection: TFDConnection;
  const APermissionCode: string
);

begin

  if not TPermissionService.HasPermission(
    AConnection,
    TUserSession.UserID,
    APermissionCode
  ) then
    raise Exception.CreateFmt(
      'Access denied. Permission "%s" is required.',
      [APermissionCode]
    );

end;

end.
