unit dmDataBase;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  Data.DB,
  uConnectionManager,
  uDatabaseInitializer, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.ODBCBase;

type

  TTDMDatabase = class(TDataModule)
    FDConnectionMain: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;

    procedure DataModuleCreate(Sender: TObject);

    procedure DataModuleDestroy(Sender: TObject);

  private

    procedure InitializeDatabase;

  public

  end;


var
  TDMDatabase: TTDMDatabase;


implementation


{$R *.dfm}


{ TDataModule1 }




procedure TTDMDatabase.DataModuleCreate(Sender: TObject);
begin

InitializeDatabase;

end;




procedure TTDMDatabase.InitializeDatabase;
begin

  try


    TConnectionManager.Configure(
      FDConnectionMain
    );


    TConnectionManager.Connect(
      FDConnectionMain
    );


  except

    on E: Exception do

      raise Exception.Create(
        'Initial connection failed:'+
        sLineBreak+
        E.Message
      );

  end;


end;



procedure TTDMDatabase.DataModuleDestroy(
  Sender: TObject
);
begin

  if Assigned(FDConnectionMain) then

    TConnectionManager.Disconnect(
      FDConnectionMain
    );


end;


end.
