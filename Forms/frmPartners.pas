unit frmPartners;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TTfrmPartners = class(TForm)
    edtSearch: TEdit;
    dbgPartners: TDBGrid;
    btnNew: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TfrmPartners: TTfrmPartners;

implementation

{$R *.dfm}

uses dmPartners, frmPartnerEdit;

procedure TTfrmPartners.btnEditClick(Sender: TObject);
begin
  TfrmPartnerEdit.Execute(TdmPartners.qryPartners.FieldByName('PartnerID').AsInteger);
end;

procedure TTfrmPartners.btnNewClick(Sender: TObject);
begin
  TfrmPartnerEdit.Execute(0);
end;

procedure TTfrmPartners.FormCreate(Sender: TObject);
begin
  dbgPartners.DataSource := TdmPartners.dsPartners ;
end;

procedure TTfrmPartners.FormShow(Sender: TObject);
begin
  TdmPartners.RefreshPartners;
end;

end.
