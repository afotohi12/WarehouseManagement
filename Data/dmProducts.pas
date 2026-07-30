unit dmProducts;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TTdmProducts = class(TDataModule)
    qryProducts: TFDQuery;
    qryExec: TFDQuery;
    qryLookup: TFDQuery;
    dsProducts: TDataSource;
    procedure DataModuleCreate(Sender: TObject);

  private
    procedure LoadProducts;
    function ToFloat(  const AValue: string): Double;

  public
    procedure RefreshProducts;
    procedure SearchProducts(
      const AText: string
    );

    function GetProduct(
    AProductID: Integer;
    AQuery: TFDQuery
    ): Boolean;
    function ProductCodeExists(
      const ACode: string;
      AExcludeID: Integer = 0
    ): Boolean;

procedure DeleteProduct(AProductID: Integer);

    procedure UpdateProduct(
  AProductID: Integer;
  const ACode,
        AName,
        ABarcode,
        APurchasePrice,
        ASalePrice,
        AMinStock,
        ADescription: string;
  AActive: Boolean
);
    procedure InsertProduct(
      const ACode,
            AName,
            ABarcode,
            APurchasePrice,
            ASalePrice,
            AMinStock,
            ADescription: string;
      AActive: Boolean
    );
  end;




var
    TdmProducts: TTdmProducts;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmDataBase;

{$R *.dfm}

{ TTdmProducts }

procedure TTdmProducts.DataModuleCreate(Sender: TObject);
begin
  qryProducts.Connection := TDMDatabase.FDConnectionMain;
  qryExec.Connection := TDMDatabase.FDConnectionMain;
  qryLookup.Connection := TDMDatabase.FDConnectionMain;

  dsProducts.DataSet := qryProducts;

  LoadProducts;
end;

procedure TTdmProducts.DeleteProduct(AProductID: Integer);
begin
 qryExec.Close;

  qryExec.SQL.Text :=
    'DELETE FROM Products ' +
    'WHERE ProductID = :ProductID';

  qryExec.ParamByName('ProductID').AsInteger := AProductID;

  qryExec.ExecSQL;

  RefreshProducts;
end;

function TTdmProducts.GetProduct(AProductID: Integer;
  AQuery: TFDQuery): Boolean;
begin
  AQuery.Close;

  AQuery.SQL.Text :=
    'SELECT * ' +
    'FROM Products ' +
    'WHERE ProductID = :ProductID';

  AQuery.ParamByName('ProductID').AsInteger := AProductID;

  AQuery.Open;

  Result := not AQuery.IsEmpty;
end;

procedure TTdmProducts.InsertProduct(const ACode, AName, ABarcode,
  APurchasePrice, ASalePrice, AMinStock, ADescription: string;
  AActive: Boolean);
begin
 qryExec.Close;

  qryExec.SQL.Text :=
    'INSERT INTO Products (' +
    'ProductCode,' +
    'ProductName,' +
    'Barcode,' +
    'PurchasePrice,' +
    'SalePrice,' +
    'MinStock,' +
    'Description,' +
    'IsActive' +
    ') VALUES (' +
    ':ProductCode,' +
    ':ProductName,' +
    ':Barcode,' +
    ':PurchasePrice,' +
    ':SalePrice,' +
    ':MinStock,' +
    ':Description,' +
    ':IsActive' +
    ')';

  qryExec.ParamByName('ProductCode').AsString := Trim(ACode);
  qryExec.ParamByName('ProductName').AsString := Trim(AName);
  qryExec.ParamByName('Barcode').AsString := Trim(ABarcode);

qryExec.ParamByName('PurchasePrice').AsFloat := ToFloat(APurchasePrice);
qryExec.ParamByName('SalePrice').AsFloat := ToFloat(ASalePrice);
qryExec.ParamByName('MinStock').AsFloat := ToFloat(AMinStock);

  qryExec.ParamByName('Description').AsString := Trim(ADescription);
  qryExec.ParamByName('IsActive').AsBoolean := AActive;

  qryExec.ExecSQL;

  RefreshProducts;
end;

procedure TTdmProducts.LoadProducts;
begin
  qryProducts.Close;

  qryProducts.SQL.Text :=
    'SELECT ' +
    'ProductID,' +
    'ProductCode,' +
    'ProductName,' +
    'Barcode,' +
    'PurchasePrice,' +
    'SalePrice,' +
    'MinStock,' +
    'IsActive ' +
    'FROM Products ' +
    'ORDER BY ProductName';

  qryProducts.Open;
end;

function TTdmProducts.ProductCodeExists(const ACode: string;
  AExcludeID: Integer): Boolean;
begin
 qryLookup.Close;

  qryLookup.SQL.Text :=
    'SELECT COUNT(*) ' +
    'FROM Products ' +
    'WHERE ProductCode = :ProductCode ' +
    'AND ProductID <> :ProductID';

  qryLookup.ParamByName('ProductCode').AsString := Trim(ACode);
  qryLookup.ParamByName('ProductID').AsInteger := AExcludeID;

  qryLookup.Open;

  Result := qryLookup.Fields[0].AsInteger > 0;
end;

procedure TTdmProducts.RefreshProducts;
begin
   LoadProducts;
end;



procedure TTdmProducts.SearchProducts(const AText: string);
begin
  qryProducts.Close;

  qryProducts.SQL.Text :=
    'SELECT * ' +
    'FROM Products ' +
    'WHERE ' +
    'ProductCode LIKE :S ' +
    'OR ProductName LIKE :S ' +
    'OR Barcode LIKE :S ' +
    'ORDER BY ProductName';

  qryProducts.ParamByName('S').AsString :=
    '%' + Trim(AText) + '%';

  qryProducts.Open;
end;

function TTdmProducts.ToFloat(
  const AValue: string
): Double;
begin
  Result :=
    StrToFloatDef(
      StringReplace(
        Trim(AValue),
        ',',
        '',
        [rfReplaceAll]
      ),
      0
    );
end;

procedure TTdmProducts.UpdateProduct(AProductID: Integer; const ACode, AName,
  ABarcode, APurchasePrice, ASalePrice, AMinStock, ADescription: string;
  AActive: Boolean);
begin
qryExec.Close;

  qryExec.SQL.Text :=
    'UPDATE Products SET ' +
    'ProductCode = :ProductCode, ' +
    'ProductName = :ProductName, ' +
    'Barcode = :Barcode, ' +
    'PurchasePrice = :PurchasePrice, ' +
    'SalePrice = :SalePrice, ' +
    'MinStock = :MinStock, ' +
    'Description = :Description, ' +
    'IsActive = :IsActive ' +
    'WHERE ProductID = :ProductID';

  qryExec.ParamByName('ProductID').AsInteger := AProductID;
  qryExec.ParamByName('ProductCode').AsString := Trim(ACode);
  qryExec.ParamByName('ProductName').AsString := Trim(AName);
  qryExec.ParamByName('Barcode').AsString := Trim(ABarcode);

 qryProducts.ParamByName('PurchasePrice').AsFloat := ToFloat(APurchasePrice);

qryProducts.ParamByName('SalePrice').AsFloat := ToFloat(ASalePrice);

qryProducts.ParamByName('MinStock').AsFloat := ToFloat(AMinStock);

  qryExec.ParamByName('Description').AsString := Trim(ADescription);
  qryExec.ParamByName('IsActive').AsBoolean := AActive;

  qryExec.ExecSQL;

  RefreshProducts;
end;

end.
