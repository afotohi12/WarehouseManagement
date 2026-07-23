object TfrmDashboard: TTfrmDashboard
  Left = 0
  Top = 0
  Caption = 'Dashboard'
  ClientHeight = 319
  ClientWidth = 542
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pnlProducts: TPanel
    Left = 8
    Top = 8
    Width = 220
    Height = 120
    BevelOuter = bvNone
    Color = clWhite
    Padding.Left = 15
    Padding.Top = 15
    Padding.Right = 15
    Padding.Bottom = 15
    ParentBackground = False
    TabOrder = 0
    object lblProductCount: TLabel
      Left = 80
      Top = 36
      Width = 54
      Height = 45
      Caption = '152'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3355443
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblProductTitle: TLabel
      Left = 0
      Top = 8
      Width = 54
      Height = 17
      Caption = 'Products'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlCustomers: TPanel
    Left = 314
    Top = 8
    Width = 220
    Height = 120
    BevelOuter = bvNone
    Color = clWhite
    Padding.Left = 15
    Padding.Top = 15
    Padding.Right = 15
    Padding.Bottom = 15
    ParentBackground = False
    TabOrder = 1
    object lblCustomerCount: TLabel
      Left = 79
      Top = 13
      Width = 36
      Height = 45
      Caption = '37'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3355443
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCustomerTitle: TLabel
      Left = 16
      Top = 13
      Width = 65
      Height = 17
      Caption = 'Customers'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlInvoices: TPanel
    Left = 8
    Top = 182
    Width = 220
    Height = 120
    BevelOuter = bvNone
    Color = clWhite
    Padding.Left = 15
    Padding.Top = 15
    Padding.Right = 15
    Padding.Bottom = 15
    ParentBackground = False
    TabOrder = 2
    object lblInvoiceCount: TLabel
      Left = 65
      Top = 8
      Width = 36
      Height = 45
      Caption = '18'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3355443
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblInvoiceTitle: TLabel
      Left = 16
      Top = 8
      Width = 50
      Height = 17
      Caption = 'Invoices'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlStock: TPanel
    Left = 312
    Top = 182
    Width = 220
    Height = 120
    BevelOuter = bvNone
    Color = clWhite
    Padding.Left = 15
    Padding.Top = 15
    Padding.Right = 15
    Padding.Bottom = 15
    ParentBackground = False
    TabOrder = 3
    object lblStockCount: TLabel
      Left = 51
      Top = 8
      Width = 72
      Height = 45
      Caption = '2450'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3355443
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStockTitle: TLabel
      Left = 16
      Top = 8
      Width = 33
      Height = 17
      Caption = 'Stock'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
