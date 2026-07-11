unit uUserSeeder;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  uPasswordHasher;

type

  TUserSeeder = class
  public

    class procedure CreateDefaultUser(
      AConnection: TFDConnection
    );

  end;


implementation


class procedure TUserSeeder.CreateDefaultUser(
  AConnection: TFDConnection
);

var
  Q: TFDQuery;
  PasswordHash: string;

begin

  Q := TFDQuery.Create(nil);

  try

    Q.Connection :=
      AConnection;


    PasswordHash :=
      TPasswordHasher.HashPassword(
        'admin'
      );


    Q.SQL.Text :=
      'IF NOT EXISTS ' +
      '(' +
      ' SELECT 1 FROM Users WHERE UserName = :UserName ' +
      ') ' +
      'BEGIN ' +
      ' INSERT INTO Users ' +
      '(' +
      ' UserName, ' +
      ' PasswordHash, ' +
      ' FirstName, ' +
      ' LastName, ' +
      ' IsActive ' +
      ') ' +
      ' VALUES ' +
      '(' +
      ' :UserName, ' +
      ' :PasswordHash, ' +
      ' :FirstName, ' +
      ' :LastName, ' +
      ' 1 ' +
      ') ' +
      'END ' +

      'ELSE ' +

      'BEGIN ' +
      ' UPDATE Users ' +
      ' SET PasswordHash = :PasswordHash ' +
      ' WHERE UserName = :UserName ' +
      ' AND (PasswordHash IS NULL OR PasswordHash = '''') ' +
      'END';


    Q.ParamByName('UserName').AsString :=
      'admin';


    Q.ParamByName('PasswordHash').AsString :=
      PasswordHash;


    Q.ParamByName('FirstName').AsString :=
      'System';


    Q.ParamByName('LastName').AsString :=
      'Administrator';


    Q.ExecSQL;


  finally

    Q.Free;

  end;

end;


end.
