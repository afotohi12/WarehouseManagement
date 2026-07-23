  unit frmDashboard;

  interface

  uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

  type
    TTfrmDashboard = class(TForm)
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
    private
      { Private declarations }
    public
      { Public declarations }
    end;

  var
    TfrmDashboard: TTfrmDashboard;


  implementation

  {$R *.dfm}

  end.
