object TdmProducts: TTdmProducts
  OnCreate = DataModuleCreate
  Height = 458
  Width = 608
  PixelsPerInch = 120
  object qryProducts: TFDQuery
    Left = 192
    Top = 80
  end
  object qryExec: TFDQuery
    Left = 288
    Top = 80
  end
  object qryLookup: TFDQuery
    Left = 376
    Top = 80
  end
  object dsProducts: TDataSource
    Left = 88
    Top = 80
  end
end
