unit frmProductEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TTfrmProductEdit = class(TForm)
    lblProductCode: TLabel;
    lblProductName: TLabel;
    lblBarcode: TLabel;
    lblCategory: TLabel;
    lblUnit: TLabel;
    lblPurchasePrice: TLabel;
    lblSalePrice: TLabel;
    lblMinStock: TLabel;
    Label9: TLabel;
    lblDescription: TLabel;
    btnSave: TButton;
    btnCancel: TButton;
    edtProductCode: TEdit;
    edtProductName: TEdit;
    edtBarcode: TEdit;
    chkActive: TCheckBox;
    cmbCategory: TComboBox;
    cmbUnit: TComboBox;
    edtPurchasePrice: TEdit;
    edtSalePrice: TEdit;
    edtMinStock: TEdit;
    memDescription: TMemo;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
private
  FProductID: Integer;

  procedure LoadProduct;
  procedure SaveProduct;
  procedure ClearControls;
  function ValidateData: Boolean;
  procedure ValidateRequired(
  AControl: TWinControl;
  const AMessage: string
);
    { Private declarations }
public
  class function NewProduct: Boolean;
  class function EditProduct(AProductID: Integer): Boolean;
    { Public declarations }
  end;

var
  TfrmProductEdit: TTfrmProductEdit;

implementation

{$R *.dfm}

uses dmProducts, uGridHelper;

{ TTfrmProductEdit }

procedure TTfrmProductEdit.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TTfrmProductEdit.btnSaveClick(Sender: TObject);
begin
  if not ValidateData then
    Exit;

  SaveProduct;
end;

procedure TTfrmProductEdit.ClearControls;
begin
  edtProductCode.Clear;
  edtProductName.Clear;
  edtBarcode.Clear;

  cmbCategory.ItemIndex := -1;
  cmbUnit.ItemIndex := -1;

  edtPurchasePrice.Text := '0';
  edtSalePrice.Text := '0';
  edtMinStock.Text := '0';

  memDescription.Clear;

  chkActive.Checked := True;


end;



class function TTfrmProductEdit.EditProduct(AProductID: Integer): Boolean;
begin
  with TTfrmProductEdit.Create(nil) do
  try
    FProductID := AProductID;
    LoadProduct;
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TTfrmProductEdit.FormShow(Sender: TObject);
begin
  edtProductCode.SetFocus;
end;

procedure TTfrmProductEdit.LoadProduct;
begin
  if not TdmProducts.GetProduct(FProductID, TdmProducts.qryLookup) then
    Exit;

 with TdmProducts.qryLookup do
begin
  edtProductCode.Text := FieldByName('ProductCode').AsString;
  edtProductName.Text := FieldByName('ProductName').AsString;
  edtBarcode.Text := FieldByName('Barcode').AsString;

  edtPurchasePrice.Text :=
    FormatFloat('#,##0.##', FieldByName('PurchasePrice').AsFloat);

  edtSalePrice.Text :=
    FormatFloat('#,##0.##', FieldByName('SalePrice').AsFloat);

  edtMinStock.Text :=
    FormatFloat('#,##0.##', FieldByName('MinStock').AsFloat);

  memDescription.Text := FieldByName('Description').AsString;

  chkActive.Checked := FieldByName('IsActive').AsBoolean;
end;
end;


class function TTfrmProductEdit.NewProduct: Boolean;
begin
  with TTfrmProductEdit.Create(nil) do
  try
    FProductID := 0;
    ClearControls;
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TTfrmProductEdit.SaveProduct;
begin
  if FProductID = 0 then
  begin
    TdmProducts.InsertProduct(
      edtProductCode.Text,
      edtProductName.Text,
      edtBarcode.Text,
      edtPurchasePrice.Text,
      edtSalePrice.Text,
      edtMinStock.Text,
      memDescription.Text,
      chkActive.Checked
    );
  end
  else
  begin
    TdmProducts.UpdateProduct(
      FProductID,
      edtProductCode.Text,
      edtProductName.Text,
      edtBarcode.Text,
      edtPurchasePrice.Text,
      edtSalePrice.Text,
      edtMinStock.Text,
      memDescription.Text,
      chkActive.Checked
    );
  end;

  ModalResult := mrOk;
end;

function TTfrmProductEdit.ValidateData: Boolean;
begin
  Result := False;

  ValidateRequired(
    edtProductCode,
    'Product Code is required.'
  );

  ValidateRequired(
    edtProductName,
    'Product Name is required.'
  );

  if StrToFloatDef(edtPurchasePrice.Text, -1) < 0 then
  begin
    MessageDlg(
      'Invalid Purchase Price.',
      mtWarning,
      [mbOK],
      0
    );

    edtPurchasePrice.SetFocus;
    Exit;
  end;

  if StrToFloatDef(edtSalePrice.Text, -1) < 0 then
  begin
    MessageDlg(
      'Invalid Sale Price.',
      mtWarning,
      [mbOK],
      0
    );

    edtSalePrice.SetFocus;
    Exit;
  end;

  if StrToFloatDef(edtMinStock.Text, -1) < 0 then
  begin
    MessageDlg(
      'Invalid Minimum Stock.',
      mtWarning,
      [mbOK],
      0
    );

    edtMinStock.SetFocus;
    Exit;
  end;


  if TdmProducts.ProductCodeExists(
     edtProductCode.Text,
     FProductID
   ) then
begin
  MessageDlg(
    'Product Code already exists.',
    mtWarning,
    [mbOK],
    0
  );

  edtProductCode.SetFocus;
  Exit;
end;

  Result := True;
end;

procedure TTfrmProductEdit.ValidateRequired(AControl: TWinControl;
  const AMessage: string);
begin
  if AControl is TEdit then
  begin
    if Trim(TEdit(AControl).Text) = '' then
    begin
      MessageDlg(AMessage, mtWarning, [mbOK], 0);
      AControl.SetFocus;
      Abort;
    end;
  end;

  if AControl is TMemo then
  begin
    if Trim(TMemo(AControl).Text) = '' then
    begin
      MessageDlg(AMessage, mtWarning, [mbOK], 0);
      AControl.SetFocus;
      Abort;
    end;
  end;

  if AControl is TComboBox then
  begin
    if TComboBox(AControl).ItemIndex = -1 then
    begin
      MessageDlg(AMessage, mtWarning, [mbOK], 0);
      AControl.SetFocus;
      Abort;
    end;
  end;
end;

end.
