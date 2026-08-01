object TfrmDashboard: TTfrmDashboard
  Left = 0
  Top = 0
  Caption = 'Dashboard'
  ClientHeight = 206
  ClientWidth = 907
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 907
    Height = 206
    Align = alTop
    Caption = 'GridPanel1'
    ColumnCollection = <
      item
        Value = 25.000000000000000000
      end
      item
        Value = 25.000000000000000000
      end
      item
        Value = 25.000000000000000000
      end
      item
        Value = 25.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = frProducts
        Row = 0
      end
      item
        Column = 1
        Control = frPurchase
        Row = 0
      end
      item
        Column = 2
        Control = frSales
        Row = 0
      end
      item
        Column = 3
        Control = frStock
        Row = 0
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 896
    ExplicitHeight = 185
    inline frProducts: TfrDashboardCard
      Left = 1
      Top = 1
      Width = 226
      Height = 204
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      Anchors = []
      TabOrder = 0
      ExplicitWidth = 851
      ExplicitHeight = 319
      inherited pnlCard: TPanel
        Width = 226
        Height = 204
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 851
        ExplicitHeight = 319
        inherited lblValue: TLabel
          Width = 51
          Caption = '850'
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 51
        end
        inherited lblTitle: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited lblStatus: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited pnlIcon: TPanel
          Height = 204
          StyleElements = [seFont, seClient, seBorder]
          ExplicitHeight = 319
        end
      end
    end
    inline frPurchase: TfrDashboardCard
      Left = 227
      Top = 1
      Width = 226
      Height = 204
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      Anchors = []
      TabOrder = 1
      ExplicitWidth = 851
      ExplicitHeight = 319
      inherited pnlCard: TPanel
        Width = 226
        Height = 204
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 851
        ExplicitHeight = 319
        inherited lblValue: TLabel
          Caption = '1200'
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited lblTitle: TLabel
          Width = 52
          Caption = 'Purchase'
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 52
        end
        inherited lblStatus: TLabel
          Width = 89
          Caption = 'This Mount 19 %'
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 89
        end
        inherited pnlIcon: TPanel
          Height = 204
          Color = clPurple
          StyleElements = [seFont, seClient, seBorder]
          ExplicitHeight = 319
        end
      end
    end
    inline frSales: TfrDashboardCard
      Left = 453
      Top = 1
      Width = 227
      Height = 204
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      Anchors = []
      TabOrder = 2
      ExplicitWidth = 851
      ExplicitHeight = 319
      inherited pnlCard: TPanel
        Width = 227
        Height = 204
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 851
        ExplicitHeight = 319
        inherited lblValue: TLabel
          Caption = '2564'
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited lblTitle: TLabel
          Width = 30
          Caption = 'Sales'
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 30
        end
        inherited lblStatus: TLabel
          Width = 89
          Caption = 'This Mount 30 %'
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 89
        end
        inherited pnlIcon: TPanel
          Height = 204
          Color = clOrange
          StyleElements = [seFont, seClient, seBorder]
          ExplicitHeight = 319
        end
      end
    end
    inline frStock: TfrDashboardCard
      Left = 680
      Top = 1
      Width = 226
      Height = 204
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      Anchors = []
      TabOrder = 3
      ExplicitWidth = 851
      ExplicitHeight = 319
      inherited pnlCard: TPanel
        Width = 226
        Height = 204
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 851
        ExplicitHeight = 319
        inherited lblValue: TLabel
          Width = 34
          Caption = '98'
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 34
        end
        inherited lblTitle: TLabel
          Width = 53
          Caption = 'Inventory'
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 53
        end
        inherited lblStatus: TLabel
          Width = 89
          Caption = 'This Mount 12 %'
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 89
        end
        inherited pnlIcon: TPanel
          Height = 204
          Color = clGreen
          StyleElements = [seFont, seClient, seBorder]
          ExplicitHeight = 319
        end
      end
    end
  end
end
