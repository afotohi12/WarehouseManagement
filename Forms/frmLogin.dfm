object TfrmLogin: TTfrmLogin
  Left = 0
  Top = 0
  Caption = 'Login Form '
  ClientHeight = 239
  ClientWidth = 291
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
    Left = 12
    Top = 42
    Width = 54
    Height = 20
    Caption = 'userName'
  end
  object lblPassword: TLabel
    Left = 14
    Top = 87
    Width = 52
    Height = 15
    Caption = 'passWord'
  end
  object btnLogin: TButton
    Left = 8
    Top = 184
    Width = 121
    Height = 41
    Caption = 'Login'
    Default = True
    TabOrder = 0
    OnClick = btnLoginClick
  end
  object btnExit: TButton
    Left = 162
    Top = 184
    Width = 121
    Height = 41
    Cancel = True
    Caption = 'Exit'
    TabOrder = 1
    OnClick = btnExitClick
  end
  object edtUsername: TEdit
    Left = 107
    Top = 32
    Width = 176
    Height = 36
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 107
    Top = 76
    Width = 176
    Height = 36
    PasswordChar = '*'
    TabOrder = 3
  end
  object chkRememberMe: TCheckBox
    Left = 14
    Top = 135
    Width = 121
    Height = 26
    Caption = 'Remember Me '
    TabOrder = 4
  end
end
