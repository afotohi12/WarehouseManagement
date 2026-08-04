object TfrmPartners: TTfrmPartners
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object edtSearch: TEdit
    Left = 136
    Top = 16
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object dbgPartners: TDBGrid
    Left = 176
    Top = 176
    Width = 320
    Height = 120
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnNew: TButton
    Left = 88
    Top = 360
    Width = 75
    Height = 25
    Caption = 'btnNew'
    TabOrder = 2
    OnClick = btnNewClick
  end
  object btnEdit: TButton
    Left = 182
    Top = 360
    Width = 75
    Height = 25
    Caption = 'btnEdit'
    TabOrder = 3
    OnClick = btnEditClick
  end
  object btnDelete: TButton
    Left = 304
    Top = 360
    Width = 75
    Height = 25
    Caption = 'btnDelete'
    TabOrder = 4
  end
end
