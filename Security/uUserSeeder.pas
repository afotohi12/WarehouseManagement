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


    Q.SQL.Text :=
      'IF NOT EXISTS '+
      '('+
      ' SELECT 1 FROM Users WHERE UserName = :UserName '+
      ') '+
      'BEGIN '+
      ' INSERT INTO Users '+
      '('+
      ' UserName, '+
      ' PasswordHash, '+
      ' FullName, '+
      ' IsActive '+
      ') '+
      ' VALUES '+
      '('+
      ' :UserName, '+
      ' :PasswordHash, '+
      ' :FullName, '+
      ' 1 '+
      ') '+
      'END';


    PasswordHash :=
      TPasswordHasher.HashPassword(
        'admin'
      );


    Q.ParamByName('UserName').AsString :=
      'admin';


    Q.ParamByName('PasswordHash').AsString :=
      PasswordHash;


    Q.ParamByName('FullName').AsString :=
      'System Administrator';


    Q.ExecSQL;


  finally

    Q.Free;

  end;

end;


end.
