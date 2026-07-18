object TDMDatabase: TTDMDatabase
  OnCreate = DataModuleCreate
  Height = 445
  Width = 629
  PixelsPerInch = 120
  object FDConnectionMain: TFDConnection
    Params.Strings = (
      'Password=root'
      'Server=VICTUS')
    LoginPrompt = False
    Left = 192
    Top = 312
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 336
    Top = 240
  end
end
