  unit frmDashboard;

  interface

  uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uBaseForm;

  type
    TTfrmDashboard = class(TfrmBase)
    pnlProducts: TPanel;
    pnlCustomers: TPanel;
    pnlInvoices: TPanel;
    pnlStock: TPanel;
    lblProductCount: TLabel;
    lblProductTitle: TLabel;
    lblCustomerCount: TLabel;
    lblCustomerTitle: TLabel;
    lblInvoiceCount: TLabel;
    lblInvoiceTitle: TLabel;
    lblStockCount: TLabel;
    lblStockTitle: TLabel;
    procedure FormShow(Sender: TObject);
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

  procedure TTfrmDashboard.FormShow(Sender: TObject);
begin
  TUIHelper.RoundPanel(pnlProducts);
  TUIHelper.RoundPanel(pnlCustomers);
  TUIHelper.RoundPanel(pnlInvoices);
  TUIHelper.RoundPanel(pnlStock);
end;

end.
