object frDashboardCard: TfrDashboardCard
  Left = 0
  Top = 0
  Width = 581
  Height = 293
  TabOrder = 0
  object pnlCard: TPanel
    Left = 0
    Top = 0
    Width = 581
    Height = 293
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object lblValue: TLabel
      Left = 85
      Top = 45
      Width = 68
      Height = 40
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '1234'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTitle: TLabel
      Left = 85
      Top = 20
      Width = 51
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Products'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 85
      Top = 85
      Width = 83
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'This Mount 8 %'
    end
    object pnlIcon: TPanel
      Left = 0
      Top = 0
      Width = 45
      Height = 293
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      BevelOuter = bvNone
      Color = clSkyBlue
      ParentBackground = False
      TabOrder = 0
      object imgIcon: TImage
        Left = 8
        Top = 120
        Width = 40
        Height = 40
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Center = True
        Stretch = True
      end
    end
  end
end
