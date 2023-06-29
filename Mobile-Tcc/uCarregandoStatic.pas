unit uCarregandoStatic;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Objects, FMX.Controls.Presentation;

type
  TfrmCarregandoStatic = class(TfrmPadrao)
    imgEtec3: TImage;
    lblUmMomento: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCarregandoStatic: TfrmCarregandoStatic;

implementation

{$R *.fmx}

end.
