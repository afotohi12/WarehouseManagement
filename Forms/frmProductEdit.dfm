object TfrmProductEdit: TTfrmProductEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Product'
  ClientHeight = 481
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object lblProductCode: TLabel
    Left = 24
    Top = 40
    Width = 79
    Height = 15
    Caption = 'Product Code :'
  end
  object lblProductName: TLabel
    Left = 24
    Top = 72
    Width = 83
    Height = 15
    Caption = 'Product Name :'
  end
  object lblBarcode: TLabel
    Left = 24
    Top = 104
    Width = 52
    Height = 15
    Caption = 'Barcode  :'
  end
  object lblCategory: TLabel
    Left = 24
    Top = 141
    Width = 54
    Height = 15
    Caption = 'Category :'
  end
  object lblUnit: TLabel
    Left = 24
    Top = 168
    Width = 22
    Height = 15
    Caption = 'Unit'
  end
  object lblPurchasePrice: TLabel
    Left = 24
    Top = 200
    Width = 83
    Height = 15
    Caption = 'Purchase Price :'
  end
  object lblSalePrice: TLabel
    Left = 24
    Top = 248
    Width = 56
    Height = 15
    Caption = 'Sale Price :'
  end
  object lblMinStock: TLabel
    Left = 24
    Top = 280
    Width = 91
    Height = 15
    Caption = 'Minimum Stock :'
  end
  object Label9: TLabel
    Left = 24
    Top = 320
    Width = 39
    Height = 15
    Caption = 'Active :'
  end
  object lblDescription: TLabel
    Left = 24
    Top = 352
    Width = 66
    Height = 15
    Caption = 'Description :'
  end
  object btnSave: TButton
    Left = 320
    Top = 392
    Width = 75
    Height = 25
    Caption = 'SAVE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clChartreuse
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 472
    Top = 392
    Width = 75
    Height = 25
    Caption = 'CANCEL'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object edtProductCode: TEdit
    Left = 154
    Top = 37
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object edtProductName: TEdit
    Left = 154
    Top = 69
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object edtBarcode: TEdit
    Left = 154
    Top = 101
    Width = 121
    Height = 23
    TabOrder = 4
  end
  object chkActive: TCheckBox
    Left = 96
    Top = 320
    Width = 97
    Height = 17
    Caption = 'chkActive'
    TabOrder = 5
  end
  object edtPurchasePrice: TEdit
    Left = 154
    Top = 197
    Width = 121
    Height = 23
    TabOrder = 6
  end
  object edtSalePrice: TEdit
    Left = 154
    Top = 240
    Width = 121
    Height = 23
    TabOrder = 7
  end
  object edtMinStock: TEdit
    Left = 154
    Top = 277
    Width = 121
    Height = 23
    TabOrder = 8
  end
  object memDescription: TMemo
    Left = 96
    Top = 361
    Width = 185
    Height = 89
    Lines.Strings = (
      '')
    TabOrder = 9
  end
  object lkpCategory: TDBLookupComboBox
    Left = 154
    Top = 138
    Width = 121
    Height = 23
    ListSource = TdmProducts.dsCategories
    TabOrder = 10
  end
  object lkpUnit: TDBLookupComboBox
    Left = 154
    Top = 167
    Width = 121
    Height = 23
    TabOrder = 11
  end
end
