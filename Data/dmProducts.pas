unit dmProducts;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    FDConnection: TFDConnection;
    qryProducts: TFDQuery;
    dsProducts: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  procedure LoadProducts;
  public
  procedure RefreshProducts;
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmDataBase;

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  qryProducts.Connection := TDMDatabase.FDConnectionMain;
  dsProducts.DataSet := qryProducts;

  LoadProducts;
end;

procedure TDataModule1.LoadProducts;
begin
  qryProducts.Close;
  qryProducts.SQL.Text :=
    'SELECT * ' +
    'FROM Products ' +
    'ORDER BY ProductName';

  qryProducts.Open;
end;

procedure TDataModule1.RefreshProducts;
begin
  LoadProducts;
end;

end.
