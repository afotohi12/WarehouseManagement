unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,FireDAC.DApt,FireDAC.Phys,FireDAC.Phys.MSSQL,FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Def,FireDAC.Stan.Async,FireDAC.Stan.Param,FireDAC.UI.Intf,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,uFormHost,frmDashboard;

type
  TfrmMain = class(TForm)
    pnlHeader: TPanel;
    pnlMenu: TPanel;
    pnlContent: TPanel;
    StatusBar1: TStatusBar;
    lblTitle: TLabel;
    lblUser: TLabel;
    btnLogout: TSpeedButton;
    btnDashboard: TSpeedButton;
    btnProducts: TSpeedButton;
    btnCustomers: TSpeedButton;
    btnSuppliers: TSpeedButton;
    btnWarehouse: TSpeedButton;
    btnInvoices: TSpeedButton;
    btnReports: TSpeedButton;
    btnUsers: TSpeedButton;
    btnSettings: TSpeedButton;
    pnlWorkspace: TPanel;
    lblPageTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnDashboardClick(Sender: TObject);
private
    FDashboard: TTfrmDashboard;
    procedure ShowDashboard;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}






procedure TfrmMain.btnDashboardClick(Sender: TObject);
begin
  lblPageTitle.Caption := 'Dashboard';
  TFormHost.OpenForm(pnlWorkspace, TTfrmDashboard);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  lblPageTitle.Caption := 'Dashboard';
end;

procedure TfrmMain.ShowDashboard;
begin
  if not Assigned(FDashboard) then
  begin
    FDashboard := TTfrmDashboard.Create(Self);
    FDashboard.Parent := pnlWorkspace;
    FDashboard.Align := alClient;
    FDashboard.BorderStyle := bsNone;
  end;

  FDashboard.Show;
end;

end.
