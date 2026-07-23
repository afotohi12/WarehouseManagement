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
      Left = 916
      Top = 1
      Width = 36
      Height = 58
      Align = alRight
      Caption = 'Admin'
      ExplicitHeight = 15
    end
    object btnLogout: TSpeedButton
      Left = 776
      Top = 1
      Width = 49
      Height = 22
      Caption = 'LogOut'
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
      Flat = True
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
      Flat = True
      ExplicitTop = 46
    end
    object btnSuppliers: TSpeedButton
      Left = 1
      Top = 136
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
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
      Flat = True
      ExplicitLeft = 197
      ExplicitTop = 80
      ExplicitWidth = 23
    end
    object btnSettings: TSpeedButton
      Left = 1
      Top = 361
      Width = 218
      Height = 45
      Cursor = crHandPoint
      Align = alTop
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
      end>
    ExplicitTop = 488
    ExplicitWidth = 951
  end
end
