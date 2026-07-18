unit uRememberMe;

interface

type
  TRememberMe = class
  public
    class procedure Save(
      const AUserName: string;
      ARemember: Boolean
    );

    class procedure Load(
      out AUserName: string;
      out ARemember: Boolean
    );
  end;

implementation

uses
  System.SysUtils,
  System.IniFiles;

const
  SECTION_LOGIN = 'Login';
  KEY_USERNAME = 'UserName';
  KEY_REMEMBER = 'RememberMe';
  FILE_NAME = 'Config\Config.ini';

class procedure TRememberMe.Save(
  const AUserName: string;
  ARemember: Boolean
);

var
  Ini: TIniFile;

begin

  Ini := TIniFile.Create(FILE_NAME);

  try

    Ini.WriteBool(
      SECTION_LOGIN,
      KEY_REMEMBER,
      ARemember
    );

    if ARemember then
      Ini.WriteString(
        SECTION_LOGIN,
        KEY_USERNAME,
        AUserName
      )
    else
      Ini.DeleteKey(
        SECTION_LOGIN,
        KEY_USERNAME
      );

  finally

    Ini.Free;

  end;

end;

class procedure TRememberMe.Load(
  out AUserName: string;
  out ARemember: Boolean
);

var
  Ini: TIniFile;

begin

  Ini := TIniFile.Create(FILE_NAME);

  try

    ARemember :=
      Ini.ReadBool(
        SECTION_LOGIN,
        KEY_REMEMBER,
        False
      );

    AUserName :=
      Ini.ReadString(
        SECTION_LOGIN,
        KEY_USERNAME,
        ''
      );

  finally

    Ini.Free;

  end;

end;

end.
