program WareHouse;

uses
  Vcl.Forms,
  System.UITypes,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  Vcl.Dialogs,
  MainForm in 'MainForm.pas' {frmMain},
  dmDataBase in 'Data\dmDataBase.pas' {TDMDatabase: TDataModule},
  frmLogin in 'Forms\frmLogin.pas' {TfrmLogin},
  uConnectionManager in 'Data\uConnectionManager.pas',
  uDataBaseinitializer in 'Data\uDataBaseinitializer.pas',
  uPasswordHasher in 'Security\uPasswordHasher.pas',
  uUserSession in 'Security\uUserSession.pas',
  uAuthenticationService in 'Security\uAuthenticationService.pas',
  uUserSeeder in 'Security\uUserSeeder.pas',
  uDatabaseMigrator in 'Core\DataBase\uDatabaseMigrator.pas',
  uUserService in 'Security\uUserService.pas',
  uPermissionService in 'Security\uPermissionService.pas',
  uAuthorization in 'Security\uAuthorization.pas',
  uRememberMe in 'Security\uRememberMe.pas',
  uBaseForm in 'Forms\uBaseForm.pas' {frmBase},
  uFormHost in 'Forms\uFormHost.pas',
  frmDashboard in 'Forms\frmDashboard.pas' {Form1};

{$R *.res}


begin
  Application.Initialize;

Application.MainFormOnTaskbar := True;

  TDatabaseInitializer.Initialize;

  Application.CreateForm(TTDMDatabase, TDMDatabase);
  with TTfrmLogin.Create(nil) do
  try
    if ShowModal <> mrOk then
      Exit;
  finally
    Free;
  end;

  Application.CreateForm(TfrmMain, frmMain);

  Application.Run;
end.
