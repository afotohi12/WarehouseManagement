program WareHouse;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form2},
  uConnectionManager in 'Data\uConnectionManager.pas',
  dmDataBase in 'Data\dmDataBase.pas' {DataModule1: TDataModule},
  uDataBaseinitializer in 'Data\uDataBaseinitializer.pas',
  uPasswordHasher in 'Security\uPasswordHasher.pas',
  uUserSession in 'Security\uUserSession.pas',
  uAuthenticationService in 'Security\uAuthenticationService.pas',
  uUserSeeder in 'Security\uUserSeeder.pas',
  uDatabaseMigrator in 'Core\DataBase\uDatabaseMigrator.pas',
  frmLogin in 'Forms\frmLogin.pas' {TfrmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TTfrmLogin, TfrmLogin);
  Application.Run;
end.
