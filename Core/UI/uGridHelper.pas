unit uGridHelper;

interface

uses
  Vcl.DBGrids,
  Vcl.Grids,
  Vcl.Graphics,
  System.SysUtils;

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
begin
  if AGrid.Columns.Count = 0 then
    Exit;

  AGrid.Columns[0].Visible := False; // ProductID

  AGrid.Columns[1].Title.Caption := 'Code';
  AGrid.Columns[1].Width := 110;

  AGrid.Columns[2].Title.Caption := 'Product';
  AGrid.Columns[2].Width := 240;

  AGrid.Columns[3].Title.Caption := 'Barcode';
  AGrid.Columns[3].Width := 150;

  AGrid.Columns[4].Title.Caption := 'Purchase';
  AGrid.Columns[4].Width := 90;


  AGrid.Columns[5].Title.Caption := 'Sale';
  AGrid.Columns[5].Width := 90;


  AGrid.Columns[6].Title.Caption := 'Min';
  AGrid.Columns[6].Width := 70;


  AGrid.Columns[7].Title.Caption := 'Active';
  AGrid.Columns[7].Width := 60;

end;

end.
