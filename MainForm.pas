unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,FireDAC.DApt,FireDAC.Phys,FireDAC.Phys.MSSQL,FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Def,FireDAC.Stan.Async,FireDAC.Stan.Param,FireDAC.UI.Intf,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,uFormHost,frmDashboard,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TfrmMain = class(TForm)
    pnlHeader: TPanel;
    pnlMenu: TPanel;
    pnlContent: TPanel;
    StatusBar1: TStatusBar;
    lblTitle: TLabel;
    lblUser: TLabel;
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
    lblSubTitle: TLabel;
    ActionList1: TActionList;
    VirtualImageList1: TVirtualImageList;
    actDashboard: TAction;
    actProducts: TAction;
    actCustomers: TAction;
    actSuppliers: TAction;
    actWarehouse: TAction;
    actInvoices: TAction;
    actReports: TAction;
    actUsers: TAction;
    actSettings: TAction;
    actLogout: TAction;
    ImageCollection1: TImageCollection;
    btnLogout: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actDashboardExecute(Sender: TObject);
    procedure actProductsExecute(Sender: TObject);
    procedure actLogoutExecute(Sender: TObject);
private
    FDashboard: TTfrmDashboard;
    //procedure ShowDashboard;
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

uses frmProducts, uAuthenticationService, uUserSession;

procedure TfrmMain.actDashboardExecute(Sender: TObject);
begin
  lblPageTitle.Caption := 'Dashboard';
  TFormHost.OpenForm(pnlWorkspace, TTfrmDashboard);
  OpenPage(btnDashboard, 'Dashboard',TTfrmDashboard);
end;

procedure TfrmMain.actLogoutExecute(Sender: TObject);
begin
 TAuthenticationService.Logout;

  Close;
end;

procedure TfrmMain.actProductsExecute(Sender: TObject);
begin
   OpenPage(
    btnProducts,
    'Products',
    TTfrmProducts
  );
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

  btnLogout.OnMouseEnter := MenuMouseEnter;
  btnLogout.OnMouseLeave := MenuMouseLeave;

  pnlMenu.BevelOuter := bvNone;

  pnlHeader.Color := clWhite;
  pnlHeader.BevelOuter := bvNone;

  pnlWorkspace.Color := RGB(246,248,252);
  pnlWorkspace.BevelOuter := bvNone;


end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  lblUser.Caption := TUserSession.DisplayName;


  StatusBar1.Panels[0].Text := 'Database: Connected';
  StatusBar1.Panels[1].Text := 'Ready';
  StatusBar1.Panels[2].Text := 'Warehouse Management v1.0';
  StatusBar1.Panels[3].Text := 'Role : '+TUserSession.RoleName;

  lblPageTitle.Caption := 'Dashboard';
  TFormHost.OpenForm(pnlWorkspace, TTfrmDashboard);
  OpenPage(btnDashboard, 'Dashboard',TTfrmDashboard);


  end;

procedure TfrmMain.MenuMouseEnter(Sender: TObject);
begin
  with Sender as TSpeedButton do
  begin
    Font.Style := [fsBold];
    Font.Color := $00FFD966;
  end;
end;

procedure TfrmMain.MenuMouseLeave(Sender: TObject);
begin
  with Sender as TSpeedButton do
  begin
    Font.Style := [];
    Font.Color := clBlack;
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
  Btn: TSpeedButton;
begin
  for I := 0 to pnlMenu.ControlCount - 1 do
    if pnlMenu.Controls[I] is TSpeedButton then
    begin
      Btn := TSpeedButton(pnlMenu.Controls[I]);
      Btn.Font.Style := [];
      Btn.Font.Color := clBlack;
    end;

  AButton.Font.Style := [fsBold];
  AButton.Font.Color := $00FFD966;
end;

end.
