unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,FireDAC.DApt,FireDAC.Phys,FireDAC.Phys.MSSQL,FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Def,FireDAC.Stan.Async,FireDAC.Stan.Param,FireDAC.UI.Intf;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses uDataBaseinitializer;

procedure TForm2.FormCreate(Sender: TObject);
begin
TDatabaseInitializer.Initialize;
end;

end.
