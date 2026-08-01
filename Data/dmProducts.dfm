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
  object qryCategories: TFDQuery
    SQL.Strings = (
      'SELECT'
      '    CategoryID,'
      '    CategoryName'
      'FROM dbo.Categories'
      'WHERE IsActive = 1'
      'ORDER BY CategoryName;')
    Left = 88
    Top = 184
  end
  object qryUnits: TFDQuery
    SQL.Strings = (
      'SELECT'
      '    UnitID,'
      '    UnitName'
      'FROM dbo.Units'
      'WHERE IsActive = 1'
      'ORDER BY UnitName;')
    Left = 224
    Top = 184
  end
  object dsCategories: TDataSource
    DataSet = qryCategories
    Left = 88
    Top = 256
  end
  object dsUnits: TDataSource
    Left = 224
    Top = 256
  end
end
