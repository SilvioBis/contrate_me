unit uCarregando;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Objects, FMX.Ani, FMX.Controls.Presentation;

type
  TfrmCarregando = class(TfrmPadrao)
    gif: TRectangle;
    BitmapListAnimation1: TBitmapListAnimation;
    lblCarregando: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCarregando: TfrmCarregando;

implementation

{$R *.fmx}

uses dmContrateME, uFuncoes, uLogin;


procedure TfrmCarregando.Timer1Timer(Sender: TObject);
begin
  inherited;
  if frmLogin = nil then
  begin
    try
      frmLogin := TfrmLogin.Create(self);
      Timer1.Enabled := false;
      frmLogin.Showmodal;

    finally
      FreeMem(Pointer(frmLogin));
      FreeMem(Pointer(self));
      dm_ContrateME := nil;
      frmCarregando := nil;
      close;
    end;
  end;
end;

end.
