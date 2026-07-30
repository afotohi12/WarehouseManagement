object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'WareHouse '
  ClientHeight = 515
  ClientWidth = 953
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 953
    Height = 60
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 951
    object lblTitle: TLabel
      Left = 1
      Top = 1
      Width = 133
      Height = 15
      Caption = 'Warehouse Management'
    end
    object lblUser: TLabel
      Left = 901
      Top = 1
      Width = 51
      Height = 58
      Align = alRight
      Caption = 'Admin'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 31
    end
    object btnLogout: TSpeedButton
      Left = 744
      Top = 0
      Width = 73
      Height = 54
      Caption = #9211' Logout '#55357#56420
      OnClick = btnLogoutClick
    end
    object lblUserType: TLabel
      Left = 919
      Top = 39
      Width = 3
      Height = 15
    end
  end
  object pnlMenu: TPanel
    Left = 0
    Top = 60
    Width = 220
    Height = 436
    Align = alLeft
    TabOrder = 1
    ExplicitHeight = 428
    object btnDashboard: TSpeedButton
      Left = 1
      Top = 1
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
      Caption = #55356#57312' Dashboard'
      Flat = True
      OnClick = btnDashboardClick
    end
    object btnProducts: TSpeedButton
      Left = 1
      Top = 46
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
      Caption = #55357#56550' Products'
      Flat = True
      OnClick = btnProductsClick
      ExplicitLeft = 197
      ExplicitTop = 32
      ExplicitWidth = 23
    end
    object btnCustomers: TSpeedButton
      Left = 1
      Top = 91
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
      Caption = #55357#56421' Customers'
      Flat = True
      ExplicitLeft = -3
      ExplicitTop = 85
    end
    object btnSuppliers: TSpeedButton
      Left = 1
      Top = 136
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
      Caption = #55357#56986' Suppliers'
      Flat = True
      ExplicitLeft = 197
      ExplicitTop = 48
      ExplicitWidth = 23
    end
    object btnWarehouse: TSpeedButton
      Left = 1
      Top = 181
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
      Caption = #55356#57314' Warehouse'
      Flat = True
      ExplicitLeft = 197
      ExplicitTop = 56
      ExplicitWidth = 23
    end
    object btnInvoices: TSpeedButton
      Left = 1
      Top = 226
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
      Caption = #55358#56830' Invoices'
      Flat = True
      ExplicitLeft = 197
      ExplicitTop = 64
      ExplicitWidth = 23
    end
    object btnReports: TSpeedButton
      Left = 1
      Top = 271
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
      Caption = #55357#56522' Reports'
      Flat = True
      ExplicitLeft = 197
      ExplicitTop = 72
      ExplicitWidth = 23
    end
    object btnUsers: TSpeedButton
      Left = 1
      Top = 316
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
      Caption = #55357#56420' Users'
      Flat = True
      ExplicitLeft = -3
      ExplicitTop = 322
    end
    object btnSettings: TSpeedButton
      Left = 1
      Top = 361
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
      Caption = #9881' Settings'
      Flat = True
      ExplicitLeft = 197
      ExplicitTop = 88
      ExplicitWidth = 23
    end
  end
  object pnlContent: TPanel
    Left = 220
    Top = 60
    Width = 733
    Height = 436
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 731
    ExplicitHeight = 428
    object pnlWorkspace: TPanel
      Left = 1
      Top = 1
      Width = 731
      Height = 434
      Align = alClient
      BevelOuter = bvNone
      Caption = #55356#57312' Dashboard'
      TabOrder = 0
      ExplicitWidth = 729
      ExplicitHeight = 426
      object lblPageTitle: TLabel
        Left = 20
        Top = 20
        Width = 124
        Height = 32
        Caption = 'Dashboard'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 496
    Width = 953
    Height = 19
    Panels = <
      item
        Text = 'Ready'
        Width = 150
      end
      item
        Text = 'Connected'
        Width = 150
      end
      item
        Width = 180
      end>
    ExplicitTop = 501
  end
end
