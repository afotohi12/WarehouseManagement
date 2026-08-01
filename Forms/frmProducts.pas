unit frmProducts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ToolWin, uBaseForm, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTfrmProducts = class(TfrmBase)
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    lblSearch: TLabel;
    edtSearch: TEdit;
    Panel1: TPanel;
    btnNew: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnRefresh: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TfrmProducts: TTfrmProducts;

implementation

{$R *.dfm}

uses dmProducts, frmProductEdit, uGridHelper;

procedure TTfrmProducts.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if TdmProducts.qryProducts.IsEmpty then
    Exit;

  if MessageDlg(
    'Delete selected product?',
    mtConfirmation,
    [mbYes, mbNo],
    0
  ) = mrYes then
  begin
    TdmProducts.DeleteProduct(
      TdmProducts.qryProducts.FieldByName('ProductID').AsInteger
    );
  end;
  TGridHelper.ApplyStyle(DBGrid1);
  TGridHelper.SetupColumns(DBGrid1);

end;

procedure TTfrmProducts.btnEditClick(Sender: TObject);
begin
  inherited;
  if TdmProducts.qryProducts.IsEmpty then
    Exit;

  with TTfrmProductEdit.Create(Self) do
  try
    EditProduct(
      TdmProducts.qryProducts.FieldByName('ProductID').AsInteger
    );
  finally
    Free;

  TdmProducts.RefreshProducts;
  end;

  TdmProducts.RefreshProducts;
  TGridHelper.ApplyStyle(DBGrid1);
  TGridHelper.SetupColumns(DBGrid1);
end;

procedure TTfrmProducts.btnNewClick(Sender: TObject);
begin
  inherited;

  with TTfrmProductEdit.Create(Self) do
  try
    NewProduct;
  finally
    Free;
  end;
  TdmProducts.RefreshProducts;
  TGridHelper.ApplyStyle(DBGrid1);
  TGridHelper.SetupColumns(DBGrid1);
end;



procedure TTfrmProducts.btnRefreshClick(Sender: TObject);
begin
  inherited;
  TdmProducts.RefreshProducts;
  TGridHelper.ApplyStyle(DBGrid1);
  TGridHelper.SetupColumns(DBGrid1);
end;

procedure TTfrmProducts.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if TdmProducts.qryProducts.IsEmpty then
    Exit;

  TTfrmProductEdit.EditProduct(
    TdmProducts.qryProducts.FieldByName('ProductID').AsInteger
  );

  TdmProducts.RefreshProducts;
end;

procedure TTfrmProducts.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if gdSelected in State then
    DBGrid1.Canvas.Brush.Color := $00FFD8A8
  else
  if Odd(DBGrid1.DataSource.DataSet.RecNo) then
    DBGrid1.Canvas.Brush.Color := clWhite
  else
    DBGrid1.Canvas.Brush.Color := $00F5F5F5;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TTfrmProducts.edtSearchChange(Sender: TObject);
begin
  inherited;
  TdmProducts.SearchProducts(
    edtSearch.Text
  );

  TGridHelper.ApplyStyle(DBGrid1);
  TGridHelper.SetupColumns(DBGrid1);
end;

procedure TTfrmProducts.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid1.DataSource := TdmProducts.dsProducts;
  TdmProducts.RefreshProducts;
  TGridHelper.ApplyStyle(DBGrid1);
  TGridHelper.SetupColumns(DBGrid1);
end;

end.
