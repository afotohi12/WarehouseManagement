unit frmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,uAuthenticationService;

type
  TTfrmLogin = class(TForm)
    lblUsername: TLabel;
    lblPassword: TLabel;
    btnLogin: TButton;
    btnExit: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TfrmLogin: TTfrmLogin;

implementation

{$R *.dfm}

end.
