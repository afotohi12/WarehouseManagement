unit uGridHelper;

interface

uses
  Vcl.DBGrids,
  Vcl.Grids,
  Vcl.Graphics,
  System.SysUtils,
  Data.DB;

type
  TGridHelper = class
  public
    class procedure ApplyStyle(AGrid: TDBGrid);
    class procedure SetupColumns(AGrid: TDBGrid);
    //class procedure FormatCurrencyColumns(  AGrid: TDBGrid);
  end;

implementation

class procedure TGridHelper.ApplyStyle(AGrid: TDBGrid);
begin
  AGrid.Options := AGrid.Options +
  [
    dgTitles,
    dgRowSelect,
    dgAlwaysShowSelection,
    dgIndicator
  ];

AGrid.Options := AGrid.Options - [dgEditing];

  AGrid.TitleFont.Name := 'Segoe UI';
  AGrid.TitleFont.Size := 10;
  AGrid.TitleFont.Style := [fsBold];

  AGrid.Font.Name := 'Segoe UI';
  AGrid.Font.Size := 10;

  AGrid.DefaultDrawing := True;

  AGrid.FixedColor := $00F2F2F2;

  AGrid.Color := clWhite;
end;
(*
class procedure TGridHelper.FormatCurrencyColumns(
  AGrid: TDBGrid
);
var
  I: Integer;
begin
  for I := 0 to AGrid.Columns.Count - 1 do
  begin
    if SameText(AGrid.Columns[I].FieldName, 'PurchasePrice') or
       SameText(AGrid.Columns[I].FieldName, 'SalePrice') then
    begin
     AGrid.Columns[I].Alignment := taRightJustify;
     AGrid.Columns[I].Title.Alignment := taCenter;
    end;
  end;
end;
       *)
class procedure TGridHelper.SetupColumns(AGrid: TDBGrid);
var
  I: Integer;
begin
  if AGrid.Columns.Count = 0 then
    Exit;

  for I := 0 to AGrid.Columns.Count - 1 do
  begin

    if SameText(AGrid.Columns[I].FieldName, 'ProductID') then
      AGrid.Columns[I].Visible := False;


    if SameText(AGrid.Columns[I].FieldName, 'CategoryID') then
      AGrid.Columns[I].Visible := False;


    if SameText(AGrid.Columns[I].FieldName, 'UnitID') then
      AGrid.Columns[I].Visible := False;


    if SameText(AGrid.Columns[I].FieldName, 'ProductCode') then
    begin
      AGrid.Columns[I].Title.Caption := 'Code';
      AGrid.Columns[I].Width := 100;
    end;


    if SameText(AGrid.Columns[I].FieldName, 'ProductName') then
    begin
      AGrid.Columns[I].Title.Caption := 'Product';
      AGrid.Columns[I].Width := 220;
    end;


    if SameText(AGrid.Columns[I].FieldName, 'Barcode') then
    begin
      AGrid.Columns[I].Title.Caption := 'Barcode';
      AGrid.Columns[I].Width := 130;
    end;


    if SameText(AGrid.Columns[I].FieldName, 'CategoryName') then
    begin
      AGrid.Columns[I].Title.Caption := 'Category';
      AGrid.Columns[I].Width := 130;
    end;


    if SameText(AGrid.Columns[I].FieldName, 'UnitName') then
    begin
      AGrid.Columns[I].Title.Caption := 'Unit';
      AGrid.Columns[I].Width := 80;
    end;


    if SameText(AGrid.Columns[I].FieldName, 'PurchasePrice') then
    begin
      AGrid.Columns[I].Title.Caption := 'Purchase';
      AGrid.Columns[I].Width := 90;
    end;


    if SameText(AGrid.Columns[I].FieldName, 'SalePrice') then
    begin
      AGrid.Columns[I].Title.Caption := 'Sale';
      AGrid.Columns[I].Width := 90;
    end;


    if SameText(AGrid.Columns[I].FieldName, 'MinStock') then
    begin
      AGrid.Columns[I].Title.Caption := 'Min';
      AGrid.Columns[I].Width := 70;
    end;


    if SameText(AGrid.Columns[I].FieldName, 'IsActive') then
    begin
      AGrid.Columns[I].Title.Caption := 'Active';
      AGrid.Columns[I].Width := 60;
    end;

  end;

end;

end.
