unit uBaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmBase = class(TForm)
  public
    constructor Create(AOwner: TComponent); override;
  end;


implementation

{$R *.dfm}

{ TBaseForm }

constructor TfrmBase.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);

  // Windows 11 Font
  if Screen.Fonts.IndexOf('Segoe UI Variable') >= 0 then
    Font.Name := 'Segoe UI Variable'
  else
    Font.Name := 'Segoe UI';

  Font.Size := 10;
  Font.Color := RGB(32, 32, 32);

  // parent Font
  ParentFont := True;

  // Background Color
  Color := RGB(248, 248, 248);

  // Center Screen
  Position := poScreenCenter;

  // Form Style
  BorderStyle := bsSingle;
  BorderIcons := [biSystemMenu];


end;

end.


