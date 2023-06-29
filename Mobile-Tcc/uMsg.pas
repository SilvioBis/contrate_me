unit uMsg;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Objects, FMX.Controls.Presentation, System.ImageList, FMX.ImgList,
  FMX.Layouts, FMX.Ani;

type
  TfrmMsg = class(TfrmPadrao)
    imgMsg: TImage;
    lblMsg: TLabel;
    StyleBook1: TStyleBook;
    imgList: TImageList;
    lytOK: TLayout;
    btnCadPessoal: TButton;
    lytSimNao: TLayout;
    lytSim: TLayout;
    btnSim: TButton;
    lytNao: TLayout;
    btnNao: TButton;
    FloatKeyAnimation1: TFloatKeyAnimation;
    procedure btnCadPessoalClick(Sender: TObject);
    procedure btnSimClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vpRetornaValor : Integer;
    vpOK : Boolean;
  end;

var
  frmMsg: TfrmMsg;

implementation

{$R *.fmx}

procedure TfrmMsg.btnCadPessoalClick(Sender: TObject);
begin
  inherited;
  vpOK := True;
  Close;
end;

procedure TfrmMsg.btnNaoClick(Sender: TObject);
begin
  inherited;
  vpOK := True;
  vpRetornaValor := 0;
  Close;
end;

procedure TfrmMsg.btnSimClick(Sender: TObject);
begin
  inherited;
  vpOK := True;
  vpRetornaValor := 1;
  Close;
end;

end.
