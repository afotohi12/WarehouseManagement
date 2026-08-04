unit dmPartners;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TTdmPartners = class(TDataModule)
    qryPartners: TFDQuery;
    qryExec: TFDQuery;
    dsPartners: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure RefreshPartners;
  function InsertPartner: Boolean;
  function UpdatePartner: Boolean;
  function DeletePartner: Boolean;
  function SearchPartners(const AText: string): Boolean;
  end;

var
  TdmPartners: TTdmPartners;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dmDataBase;

{$R *.dfm}

{ TdmPartners }

procedure TTdmPartners.DataModuleCreate(Sender: TObject);
begin
  qryPartners.Connection := TDMDatabase.FDConnectionMain;
  qryExec.Connection := TDMDatabase.FDConnectionMain;

  dsPartners.DataSet :=  qryPartners;


end;

function TTdmPartners.InsertPartner: Boolean;
begin
  Result := False;
end;

function TTdmPartners.UpdatePartner: Boolean;
begin
  Result := False;
end;

function TTdmPartners.DeletePartner: Boolean;
begin
  Result := False;
end;

procedure TTdmPartners.RefreshPartners;
begin
  qryPartners.Close;
  qryPartners.SQL.Text :=
    'SELECT * FROM Partners ORDER BY PartnerName';
  qryPartners.Open;
end;

function TTdmPartners.SearchPartners(const AText: string): Boolean;
begin
  qryPartners.Close;

  qryPartners.SQL.Text :=
    'SELECT * ' +
    'FROM Partners ' +
    'WHERE PartnerCode LIKE :S ' +
    '   OR PartnerName LIKE :S ' +
    'ORDER BY PartnerName';

  //qryPartners.ParamByName('S').AsString := '%' + Trim(ASearch) + '%';

  qryPartners.Open;
end;


end.
