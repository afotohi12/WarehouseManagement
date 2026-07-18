


unit frmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,uAuthenticationService, uBaseForm;

type
  TTfrmLogin = class(TfrmBase)
    lblUsername: TLabel;
    lblPassword: TLabel;
    btnLogin: TButton;
    btnExit: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    chkRememberMe: TCheckBox;
    procedure btnLoginClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TfrmLogin: TTfrmLogin;

implementation

{$R *.dfm}

uses dmDataBase, uRememberMe;



procedure TTfrmLogin.btnExitClick(Sender: TObject);
begin
 TAuthenticationService.Logout;

  Close;
end;

procedure TTfrmLogin.btnLoginClick(Sender: TObject);
begin

  if TAuthenticationService.Login(
       TDMDatabase.FDConnectionMain,
       edtUserName.Text,
       edtPassword.Text
     ) then
  begin

    TRememberMe.Save(
      edtUserName.Text,
      chkRememberMe.Checked
    );

    ModalResult := mrOk;

  end
  else
    MessageDlg(
      'UserName Or Password Is Wrong !',
      mtError,
      [mbOK],
      0
    );

end;

procedure TTfrmLogin.FormCreate(Sender: TObject);
var
  UserName: string;
  Remember: Boolean;

begin

  TRememberMe.Load(
    UserName,
    Remember
  );

  edtUserName.Text :=
    UserName;

  chkRememberMe.Checked :=
    Remember;
end;

procedure TTfrmLogin.FormShow(Sender: TObject);
begin
  if edtUsername.Text = '' then
    edtUsername.SetFocus
  else
    edtPassword.SetFocus;
end;

end.
