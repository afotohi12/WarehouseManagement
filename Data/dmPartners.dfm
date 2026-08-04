object TdmPartners: TTdmPartners
  Left = 0
  Top = 0
  Margins.Left = 2
  Margins.Top = 2
  Margins.Right = 2
  Margins.Bottom = 2
  ClientHeight = 284
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = DataModuleCreate
  TextHeight = 12
  object qryPartners: TFDQuery
    SQL.Strings = (
      'SELECT'
      '    PartnerID,'
      '    PartnerCode,'
      '    PartnerName,'
      '    PartnerType,'
      '    Phone,'
      '    Mobile,'
      '    Email,'
      '    City,'
      '    IsCustomer,'
      '    IsSupplier,'
      '    IsBroker,'
      '    IsActive'
      'FROM Partners'
      'ORDER BY PartnerName;')
    Left = 152
    Top = 112
  end
  object qryExec: TFDQuery
    Left = 240
    Top = 112
  end
  object dsPartners: TDataSource
    Left = 160
    Top = 192
  end
end
