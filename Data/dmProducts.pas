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
    qryCategories: TFDQuery;
    qryUnits: TFDQuery;
    dsCategories: TDataSource;
    dsUnits: TDataSource;
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

function BarcodeExists(
  const ABarcode: string;
  AExcludeID: Integer = 0
): Boolean;

procedure DeleteProduct(AProductID: Integer);

procedure UpdateProduct(
  AProductID: Integer;
  const ACode,
        AName,
        ABarcode: string;
  ACategoryID,
  AUnitID: Integer;
  const APurchasePrice,
        ASalePrice,
        AMinStock,
        ADescription: string;
  AActive: Boolean
);

procedure InsertProduct(
  const ACode,
        AName,
        ABarcode: string;
  ACategoryID,
  AUnitID: Integer;
  const APurchasePrice,
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

function TTdmProducts.BarcodeExists(const ABarcode: string;
  AExcludeID: Integer): Boolean;
begin
  qryLookup.Close;

  qryLookup.SQL.Text :=
    'SELECT COUNT(*) ' +
    'FROM Products ' +
    'WHERE Barcode = :Barcode ' +
    'AND ProductID <> :ProductID';


  qryLookup.ParamByName('Barcode').AsString :=
    Trim(ABarcode);

  qryLookup.ParamByName('ProductID').AsInteger :=
    AExcludeID;


  qryLookup.Open;


  Result :=
    qryLookup.Fields[0].AsInteger > 0;
end;

procedure TTdmProducts.DataModuleCreate(Sender: TObject);
begin
  qryProducts.Connection := TDMDatabase.FDConnectionMain;
  qryExec.Connection := TDMDatabase.FDConnectionMain;
  qryLookup.Connection := TDMDatabase.FDConnectionMain;
  qryCategories.Connection  := TDMDatabase.FDConnectionMain;
  qryUnits.Connection  := TDMDatabase.FDConnectionMain;

  dsProducts.DataSet   := qryProducts;
  dsCategories.DataSet := qryCategories;
  dsUnits.DataSet      := qryUnits;

  LoadProducts;
end;

procedure TTdmProducts.DeleteProduct(AProductID: Integer);
begin

  TDMDatabase.FDConnectionMain.StartTransaction;

  try

    qryExec.Close;

    qryExec.SQL.Text :=
      'DELETE FROM Products ' +
      'WHERE ProductID = :ProductID';


    qryExec.ParamByName('ProductID').AsInteger :=
      AProductID;


    qryExec.ExecSQL;


    TDMDatabase.FDConnectionMain.Commit;

  except
    on E: Exception do
    begin
      TDMDatabase.FDConnectionMain.Rollback;
      raise;
    end;
  end;


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

procedure TTdmProducts.InsertProduct(
  const ACode, AName, ABarcode: string;
  ACategoryID, AUnitID: Integer;
  const APurchasePrice, ASalePrice,
        AMinStock, ADescription: string;
  AActive: Boolean
);
begin

  TDMDatabase.FDConnectionMain.StartTransaction;

  try

    qryExec.Close;

    qryExec.SQL.Text :=
      'INSERT INTO Products ('+
      'ProductCode,'+
      'ProductName,'+
      'Barcode,'+
      'CategoryID,'+
      'UnitID,'+
      'PurchasePrice,'+
      'SalePrice,'+
      'MinStock,'+
      'Description,'+
      'IsActive'+
      ') VALUES ('+
      ':ProductCode,'+
      ':ProductName,'+
      ':Barcode,'+
      ':CategoryID,'+
      ':UnitID,'+
      ':PurchasePrice,'+
      ':SalePrice,'+
      ':MinStock,'+
      ':Description,'+
      ':IsActive'+
      ')';


    qryExec.ParamByName('ProductCode').AsString := Trim(ACode);
    qryExec.ParamByName('ProductName').AsString := Trim(AName);
    qryExec.ParamByName('Barcode').AsString := Trim(ABarcode);

    qryExec.ParamByName('CategoryID').AsInteger := ACategoryID;
    qryExec.ParamByName('UnitID').AsInteger := AUnitID;


    qryExec.ParamByName('PurchasePrice').AsFloat :=
      ToFloat(APurchasePrice);

    qryExec.ParamByName('SalePrice').AsFloat :=
      ToFloat(ASalePrice);

    qryExec.ParamByName('MinStock').AsFloat :=
      ToFloat(AMinStock);


    qryExec.ParamByName('Description').AsString :=
      Trim(ADescription);

    qryExec.ParamByName('IsActive').AsBoolean :=
      AActive;


    qryExec.ExecSQL;


    TDMDatabase.FDConnectionMain.Commit;

  except
    on E: Exception do
    begin
      TDMDatabase.FDConnectionMain.Rollback;
      raise;
    end;
  end;


  RefreshProducts;

end;

procedure TTdmProducts.LoadProducts;
begin
qryProducts.Close;

qryProducts.SQL.Text :=
  'SELECT ' +
  'P.ProductID, ' +
  'P.ProductCode, ' +
  'P.ProductName, ' +
  'P.Barcode, ' +
  'P.CategoryID, ' +
  'C.CategoryName, ' +
  'P.UnitID, ' +
  'U.UnitName, ' +
  'P.PurchasePrice, ' +
  'P.SalePrice, ' +
  'P.MinStock, ' +
  'P.IsActive ' +
  'FROM Products P ' +
  'LEFT JOIN Categories C ' +
  'ON P.CategoryID = C.CategoryID ' +
  'LEFT JOIN Units U ' +
  'ON P.UnitID = U.UnitID ' +
  'WHERE P.IsActive = 1 ' +
  'ORDER BY P.ProductName';

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
procedure TTdmProducts.UpdateProduct(
  AProductID: Integer;
  const ACode, AName, ABarcode: string;
  ACategoryID, AUnitID: Integer;
  const APurchasePrice, ASalePrice,
        AMinStock, ADescription: string;
  AActive: Boolean
);
begin

  TDMDatabase.FDConnectionMain.StartTransaction;

  try

    qryExec.Close;

    qryExec.SQL.Text :=
      'UPDATE Products SET ' +
      'ProductCode = :ProductCode, ' +
      'ProductName = :ProductName, ' +
      'Barcode = :Barcode, ' +
      'CategoryID = :CategoryID, ' +
      'UnitID = :UnitID, ' +
      'PurchasePrice = :PurchasePrice, ' +
      'SalePrice = :SalePrice, ' +
      'MinStock = :MinStock, ' +
      'Description = :Description, ' +
      'IsActive = :IsActive, ' +
      'UpdatedAt = GETDATE() ' +
      'WHERE ProductID = :ProductID';


    qryExec.ParamByName('ProductID').AsInteger :=
      AProductID;


    qryExec.ParamByName('ProductCode').AsString :=
      Trim(ACode);

    qryExec.ParamByName('ProductName').AsString :=
      Trim(AName);

    qryExec.ParamByName('Barcode').AsString :=
      Trim(ABarcode);


    qryExec.ParamByName('CategoryID').AsInteger :=
      ACategoryID;

    qryExec.ParamByName('UnitID').AsInteger :=
      AUnitID;


    qryExec.ParamByName('PurchasePrice').AsFloat :=
      ToFloat(APurchasePrice);

    qryExec.ParamByName('SalePrice').AsFloat :=
      ToFloat(ASalePrice);

    qryExec.ParamByName('MinStock').AsFloat :=
      ToFloat(AMinStock);


    qryExec.ParamByName('Description').AsString :=
      Trim(ADescription);

    qryExec.ParamByName('IsActive').AsBoolean :=
      AActive;


    qryExec.ExecSQL;


    TDMDatabase.FDConnectionMain.Commit;

  except
    on E: Exception do
    begin
      TDMDatabase.FDConnectionMain.Rollback;
      raise;
    end;
  end;


  RefreshProducts;

end;

end.
