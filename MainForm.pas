unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,FireDAC.DApt,FireDAC.Phys,FireDAC.Phys.MSSQL,FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Def,FireDAC.Stan.Async,FireDAC.Stan.Param,FireDAC.UI.Intf;

type
  TfrmMain = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


end.
