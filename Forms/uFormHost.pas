unit uFormHost;

interface

uses
  Vcl.Forms, Vcl.ExtCtrls, System.Classes,System.SysUtils,Vcl.Controls;


type
  TFormHost = class
  public
    class procedure OpenForm(AParent: TPanel; AFormClass: TFormClass);
  end;

implementation

class procedure TFormHost.OpenForm(AParent: TPanel; AFormClass: TFormClass);
var
  I: Integer;
  Frm: TForm;
begin
  for I := AParent.ControlCount - 1 downto 0 do
    if AParent.Controls[I] is TForm then
      AParent.Controls[I].Free;

  Frm := AFormClass.Create(AParent);
  Frm.BorderStyle := bsNone;
  Frm.Align := alClient;
  Frm.Parent := AParent;
  Frm.Show;
end;

end.
