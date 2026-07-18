object TfrmLogin: TTfrmLogin
  Left = 0
  Top = 0
  Caption = 'TfrmLogin'
  ClientHeight = 138
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object lblUsername: TLabel
    Left = 8
    Top = 8
    Width = 54
    Height = 15
    Caption = 'userName'
  end
  object lblPassword: TLabel
    Left = 10
    Top = 40
    Width = 52
    Height = 15
    Caption = 'passWord'
  end
  object btnLogin: TButton
    Left = 8
    Top = 72
    Width = 105
    Height = 41
    Caption = 'Login'
    Default = True
    TabOrder = 0
    OnClick = btnLoginClick
  end
  object btnExit: TButton
    Left = 174
    Top = 66
    Width = 114
    Height = 41
    Cancel = True
    Caption = 'Exit'
    TabOrder = 1
    OnClick = btnExitClick
  end
  object edtUsername: TEdit
    Left = 112
    Top = 8
    Width = 176
    Height = 23
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 112
    Top = 37
    Width = 176
    Height = 23
    PasswordChar = '*'
    TabOrder = 3
  end
  object chkRememberMe: TCheckBox
    Left = 8
    Top = 119
    Width = 105
    Height = 17
    Caption = 'Remember Me '
    TabOrder = 4
  end
end
