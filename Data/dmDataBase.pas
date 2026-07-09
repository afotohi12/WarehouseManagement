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

  TDataModule1 = class(TDataModule)
    FDConnectionMain: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;

    procedure DataModuleCreate(Sender: TObject);

    procedure DataModuleDestroy(Sender: TObject);

  private

    procedure InitializeDatabase;

  public

  end;


var
  DataModule1: TDataModule1;


implementation


{$R *.dfm}


{ TDataModule1 }




procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin

  TConnectionManager.ConfigureForMaster(
    FDConnectionMain
  );


  TConnectionManager.Connect(
    FDConnectionMain
  );

end;




procedure TDataModule1.InitializeDatabase;
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



procedure TDataModule1.DataModuleDestroy(
  Sender: TObject
);
begin

  if Assigned(FDConnectionMain) then

    TConnectionManager.Disconnect(
      FDConnectionMain
    );


end;


end.
