object TfrmLogin: TTfrmLogin
  Left = 0
  Top = 0
  Caption = 'TfrmLogin'
  ClientHeight = 224
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lblUsername: TLabel
    Left = 48
    Top = 40
    Width = 54
    Height = 15
    Caption = 'userName'
  end
  object lblPassword: TLabel
    Left = 50
    Top = 72
    Width = 52
    Height = 15
    Caption = 'passWord'
  end
  object btnLogin: TButton
    Left = 80
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 0
  end
  object btnExit: TButton
    Left = 232
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 1
  end
  object edtUsername: TEdit
    Left = 152
    Top = 40
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 152
    Top = 69
    Width = 121
    Height = 23
    PasswordChar = '*'
    TabOrder = 3
  end
end
