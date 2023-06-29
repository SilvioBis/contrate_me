unit uFuncoes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.ListBox,Datasnap.DBClient,FMX.ListView.Types, FMX.TextLayout;

function  CampoSTR(vValor : string; vNull : Boolean = False) : string;
function  CampoFloat(vValor : Integer; vNull : Boolean = False) : string;
function  MSG(vMsg : string; vCor: Integer = 0; indexImg : Integer = 0; vTipoMSG: Integer = 0): Integer;
procedure PreencheComboBoxCidade(vComboBox: array of tComboBox);
procedure PreencheComboBoxLinguagem(vComboBox: tComboBox);
function GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;

implementation

uses uMsg, uCarregando, dmContrateME;

function CampoSTR(vValor : string; vNull : Boolean = False ) : string;
begin
  if not(Trim(vValor) = '') then
  begin
    StringReplace(vvalor,'''','',[]);
    Result := QuotedStr(vValor)
  end
  else
    result := 'NULL';

  if not(Trim(vValor) = '') and (vNull) then
    Result := 'NULL';
end;

function CampoFloat(vValor : Integer; vNull : Boolean = False) : string;
begin
  if vValor <> 0 then
   Result := FloatToStr(vValor)
  else
   Result := 'NULL';


end;

function MSG(vMsg : string; vCor: Integer = 0; indexImg : Integer = 0; vTipoMSG: Integer = 0): Integer;
var i : tSizef;
  function DefiniCor: TAlphaColor;
  begin
    case vCor of
      0: result := $FF092B63; //Azul
      1: result := $FFF7B100; //Amarelo
      2: result := $FFFA2F28; //Vermelho
      3: result := $FF1F7D22; //Verde
    end;

  end;
begin
  frmMsg := TfrmMsg.Create(Application);
  frmMsg.lblMsg.text := StringReplace(frmMsg.lblMsg.text,'XXXX',vMsg,[]);
  frmMsg.Fill.Color  := DefiniCor;
  frmMsg.imgMsg.MultiResBitmap[0].Bitmap := frmMsg.imgList.Source[indexImg].MultiResBitmap[0].Bitmap;
  case vTipoMSG of
    0: begin
         frmMsg.lytOK.visible := TRue;
         frmMsg.lytSimNao.Visible := false;
       end;
    1: begin
         frmMsg.lytOK.visible := false;
         frmMsg.lytSimNao.Visible := true;
       end;
  end;
  frmMsg.ShowModal;

  if frmMsg.vpOk then
  begin
    if vTipoMSG = 0 then
      Result := 1
    else
      Result := frmMsg.vpRetornaValor;
  end;

  frmMsg.Free;
  frmMsg := Nil;
end;

procedure PreencheComboBoxCidade(vComboBox: array of tComboBox);
var i : Integer;
    vform : TForm;
begin
  dm_ContrateME.qryCidade.Close;
  dm_ContrateME.qryCidade.SQL.Text := 'SELECT * FROM cm_cidade';
  dm_ContrateME.qryCidade.Open;

  dm_ContrateME.qryCidade.data;
  for i := 0 to Length(vComboBox) -1 do
  begin
    dm_ContrateME.qryCidade.Filter := 'CM_CIDADE_CODESTADO = ' + inttostr(vComboBox[i].Tag);
    dm_ContrateME.qryCidade.Filtered := True;
    while not dm_ContrateME.qryCidade.Eof do
    begin
      vComboBox[i].Items.Add(dm_ContrateME.qryCidade.FindField('CM_CIDADE_NOME').AsString);
      dm_ContrateME.qryCidade.Next;
    end;
    vComboBox[i].ItemIndex := 0;
  end;
  dm_ContrateME.qryCidade.Close;

end;

procedure PreencheComboBoxLinguagem(vComboBox: tComboBox);
begin
  dm_ContrateME.qryConsulta.Close;
  dm_ContrateME.qryConsulta.SQL.Text := 'SELECT * FROM cm_linguagens';
  dm_ContrateME.qryConsulta.Open;


  while not dm_ContrateME.qryConsulta.Eof do
  begin
    vComboBox.Items.Add(dm_ContrateME.qryConsulta.FindField('CM_LINGUAGEM_LINGUAGEM').AsString);
    dm_ContrateME.qryConsulta.Next;
  end;

  dm_ContrateME.qryConsulta.Close;

end;


function GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;

    Result := Round(Layout.Height);

    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

end.
