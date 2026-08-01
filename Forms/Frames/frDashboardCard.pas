unit frDashboardCard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrDashboardCard = class(TFrame)
    pnlCard: TPanel;
    pnlIcon: TPanel;
    imgIcon: TImage;
    lblTitle: TLabel;
    lblValue: TLabel;
    lblStatus: TLabel;
  private
        FTitle: string;
      FValue: string;
      FStatus: string;
      FIconColor: TColor;

procedure SetIconColor(const Value: TColor);
procedure SetIcon(const Value: TPicture);

      procedure SetTitle(const Value: string);
      procedure SetValue(const Value: string);
      procedure SetStatus(const Value: string);
    { Private declarations }
  procedure RoundIcon;
  procedure RoundCard;
  procedure AddShadow;
  protected
    procedure Loaded; override;
  public
  property Icon: TPicture write SetIcon;
  property IconColor: TColor read FIconColor write SetIconColor;
        property Title: string read FTitle write SetTitle;
      property Value: string read FValue write SetValue;
      property Status: string read FStatus write SetStatus;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrDashboardCard }

procedure TfrDashboardCard.AddShadow;
var
  ExStyle: Longint;
begin
  ExStyle := GetWindowLong(pnlCard.Handle, GWL_EXSTYLE);
  SetWindowLong(
    pnlCard.Handle,
    GWL_EXSTYLE,
    ExStyle or CS_DROPSHADOW
  );
end;



procedure TfrDashboardCard.Loaded;
begin
  inherited;
    RoundCard;
    RoundIcon;
    AddShadow;
end;

procedure TfrDashboardCard.RoundCard;
begin
  SetWindowRgn(
    pnlCard.Handle,
    CreateRoundRectRgn(
      0,
      0,
      pnlCard.Width,
      pnlCard.Height,
      20,
      20
    ),
    True
  );
end;

procedure TfrDashboardCard.RoundIcon;
begin
  SetWindowRgn(
    pnlIcon.Handle,
    CreateRoundRectRgn(
      0,
      0,
      pnlIcon.Width,
      pnlIcon.Height,
      45,
      45
    ),
    True
  );
end;

procedure TfrDashboardCard.SetTitle(const Value: string);
begin
  FTitle := Value;
  lblTitle.Caption := Value;
end;


procedure TfrDashboardCard.SetValue(const Value: string);
begin
  FValue := Value;
  lblValue.Caption := Value;
end;


procedure TfrDashboardCard.SetIcon(const Value: TPicture);
begin
  imgIcon.Picture.Assign(Value);
end;

procedure TfrDashboardCard.SetIconColor(const Value: TColor);
begin
  FIconColor := Value;
  pnlIcon.Color := Value;
end;

procedure TfrDashboardCard.SetStatus(const Value: string);
begin
  FStatus := Value;
  lblStatus.Caption := Value;
end;

end.
