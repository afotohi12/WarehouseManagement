unit frmPartnerEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TTfrmPartnerEdit = class(TForm)
    lblName: TLabel;
    edtPartnerName: TEdit;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Memo1: TMemo;
    CheckBox4: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    lblCode: TLabel;
    edtPartnerCode: TEdit;
  private
    { Private declarations }
  FPartnerID: Integer;
  public
    { Public declarations }
  function Execute(APartnerID: Integer = 0): Boolean;
  end;

var
  TfrmPartnerEdit : TTfrmPartnerEdit;

implementation

{$R *.dfm}

{ TTfrmPartnerEdit }

function TTfrmPartnerEdit.Execute(APartnerID: Integer): Boolean;
begin

end;

end.
