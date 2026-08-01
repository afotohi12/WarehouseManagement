object TfrmProducts: TTfrmProducts
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Products'
  ClientHeight = 480
  ClientWidth = 640
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 640
    Height = 50
    ButtonHeight = 15
    Caption = 'ToolBar1'
    TabOrder = 0
    object lblSearch: TLabel
      Left = 0
      Top = 0
      Width = 109
      Height = 15
      Caption = #55357#56589' Search products : '
    end
    object edtSearch: TEdit
      Left = 109
      Top = 0
      Width = 121
      Height = 15
      TabOrder = 0
      OnChange = edtSearchChange
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 461
    Width = 640
    Height = 19
    Panels = <>
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 50
    Width = 640
    Height = 363
    Align = alClient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 413
    Width = 640
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object btnNew: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 36
      Caption = #10133' New'
      TabOrder = 0
      OnClick = btnNewClick
    end
    object btnEdit: TButton
      Left = 89
      Top = 6
      Width = 75
      Height = 36
      Caption = #9999' Edit'
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 170
      Top = 6
      Width = 75
      Height = 36
      Caption = #55357#56785' Delete'
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object btnRefresh: TButton
      Left = 251
      Top = 6
      Width = 75
      Height = 36
      Caption = #55357#56580' Refresh'
      TabOrder = 3
      OnClick = btnRefreshClick
    end
  end
end
