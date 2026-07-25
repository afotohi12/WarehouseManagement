unit uUIHelper;

interface

uses
  Winapi.Windows, Vcl.ExtCtrls;

type
  TUIHelper = class
  public
    class procedure RoundPanel(APanel: TPanel; Radius: Integer = 12);
  end;

implementation

class procedure TUIHelper.RoundPanel(APanel: TPanel; Radius: Integer);
var
  Rgn: HRGN;
begin
  Rgn := CreateRoundRectRgn(
    0,
    0,
    APanel.Width + 1,
    APanel.Height + 1,
    Radius,
    Radius
  );

  SetWindowRgn(APanel.Handle, Rgn, True);
end;

end.
