object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 296
  Width = 580
  PixelsPerInch = 120
  object FDConnection: TFDConnection
    Left = 192
    Top = 184
  end
  object qryProducts: TFDQuery
    Connection = FDConnection
    Left = 304
    Top = 176
  end
  object dsProducts: TDataSource
    Left = 440
    Top = 200
  end
end
