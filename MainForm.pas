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
    procedure MenuMouseEnter(Sender: TObject);
    procedure MenuMouseLeave(Sender: TObject);
    procedure SelectMenu(AButton: TSpeedButton);
    procedure OpenPage(
    AButton: TSpeedButton;
    const ATitle: string;
    AFormClass: TFormClass
  );
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
  OpenPage(btnDashboard, 'Dashboard',TTfrmDashboard);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  lblPageTitle.Caption := 'Dashboard';

  btnDashboard.OnMouseEnter := MenuMouseEnter;
  btnDashboard.OnMouseLeave := MenuMouseLeave;

  btnProducts.OnMouseEnter := MenuMouseEnter;
  btnProducts.OnMouseLeave := MenuMouseLeave;

  btnCustomers.OnMouseEnter := MenuMouseEnter;
  btnCustomers.OnMouseLeave := MenuMouseLeave;

  btnSuppliers.OnMouseEnter := MenuMouseEnter;
  btnSuppliers.OnMouseLeave := MenuMouseLeave;

  btnWarehouse.OnMouseEnter := MenuMouseEnter;
  btnWarehouse.OnMouseLeave := MenuMouseLeave;

  btnInvoices.OnMouseEnter := MenuMouseEnter;
  btnInvoices.OnMouseLeave := MenuMouseLeave;

  btnReports.OnMouseEnter := MenuMouseEnter;
  btnReports.OnMouseLeave := MenuMouseLeave;

  btnUsers.OnMouseEnter := MenuMouseEnter;
  btnUsers.OnMouseLeave := MenuMouseLeave;

  btnSettings.OnMouseEnter := MenuMouseEnter;
  btnSettings.OnMouseLeave := MenuMouseLeave;
end;

procedure TfrmMain.MenuMouseEnter(Sender: TObject);
begin
  with Sender as TSpeedButton do
  begin
    Flat := False;
    Font.Style := [fsBold];
  end;
end;

procedure TfrmMain.MenuMouseLeave(Sender: TObject);
begin
  with Sender as TSpeedButton do
  begin
    Flat := True;
    Font.Style := [];
  end;
end;

procedure TfrmMain.OpenPage(AButton: TSpeedButton;const ATitle: string;AFormClass: TFormClass);
begin
  SelectMenu(AButton);
  lblPageTitle.Caption := ATitle;
  TFormHost.OpenForm(pnlWorkspace, AFormClass);
end;

procedure TfrmMain.SelectMenu(AButton: TSpeedButton);
var
  I: Integer;
begin
  for I := 0 to pnlMenu.ControlCount - 1 do
    if pnlMenu.Controls[I] is TSpeedButton then
      TSpeedButton(pnlMenu.Controls[I]).Font.Style := [];

  AButton.Font.Style := [fsBold];
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
