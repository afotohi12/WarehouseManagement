unit uPermissionService;

interface

uses
  FireDAC.Comp.Client;

type

  TPermissionService = class
  public

    class function HasPermission(
      AConnection: TFDConnection;
      AUserID: Integer;
      const APermissionCode: string
    ): Boolean;

  end;

implementation

class function TPermissionService.HasPermission(
  AConnection: TFDConnection;
  AUserID: Integer;
  const APermissionCode: string
): Boolean;

var
  Q: TFDQuery;

begin

  Result := False;

  Q := TFDQuery.Create(nil);

  try

    Q.Connection := AConnection;

    Q.SQL.Text :=
      'SELECT COUNT(*) CNT '+
      'FROM UserRoles UR '+
      'INNER JOIN RolePermissions RP ON RP.RoleID=UR.RoleID '+
      'INNER JOIN Permissions P ON P.ID=RP.PermissionID '+
      'WHERE UR.UserID=:UserID '+
      'AND P.Code=:Code';

    Q.ParamByName('UserID').AsInteger :=
      AUserID;

    Q.ParamByName('Code').AsString :=
      APermissionCode;

    Q.Open;

    Result :=
      Q.FieldByName('CNT').AsInteger > 0;

  finally

    Q.Free;

  end;

end;

end.
