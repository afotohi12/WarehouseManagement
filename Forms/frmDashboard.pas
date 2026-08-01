  unit frmDashboard;

  interface

  uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uBaseForm,
  frDashboardCard;

  type
    TTfrmDashboard = class(TfrmBase)
    frProducts: TfrDashboardCard;
    frStock: TfrDashboardCard;
    frSales: TfrDashboardCard;
    frPurchase: TfrDashboardCard;
    GridPanel1: TGridPanel;
    procedure FormCreate(Sender: TObject);
    private

      { Private declarations }
    public

      { Public declarations }
    end;

  var
    TfrmDashboard: TTfrmDashboard;


  implementation

  {$R *.dfm}

uses uUIHelper;

  procedure TTfrmDashboard.FormCreate(Sender: TObject);
begin
  inherited;
frProducts.Title     := 'Products';
frProducts.Value     := '12,540';
frProducts.Status    := 'Updated today';
frProducts.IconColor := $00FFE8D5;

frStock.Title        := 'Stock Items';
frStock.Value        := '8,650';
frStock.Status       := 'In Warehouse';
frStock.IconColor    := $00D9F7E8;

frSales.Title        := 'Sales Orders';
frSales.Value        := '98';
frSales.Status       := 'Today';
frSales.IconColor    := $00FFE6D9;

frPurchase.Title     := 'Purchase Orders';
frPurchase.Value     := '65';
frPurchase.Status    := 'Pending';
frPurchase.IconColor := $00F2E8FF;
end;

end.
