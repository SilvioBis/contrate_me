unit uLogin;
// Cor Azul FF0F1020
interface


uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FMX.ListBox,
  FireDAC.Comp.Client, FMX.ComboEdit,uUsuario;

type
  Index = record
    Candidato : array[0..1] of integer;
    Empresa : array[0..1] of integer;

    public
      procedure DefinirConta;
end;

type
  TfrmLogin = class(TForm)
    tbControl: TTabControl;
    tabLogin: TTabItem;
    tabConta1: TTabItem;
    tabConta2: TTabItem;
    imgEtec: TImage;
    lytLogin: TLayout;
    lblLogin: FMX.StdCtrls.TLabel;
    lblCriarConta: FMX.StdCtrls.TLabel;
    imgEtec2: TImage;
    lytCriarConta1: TLayout;
    Label2: FMX.StdCtrls.TLabel;
    Label3: FMX.StdCtrls.TLabel;
    lblJaPossuiConta1: FMX.StdCtrls.TLabel;
    lytCriar: TLayout;
    imgEtec3: TImage;
    lblPossuiConta2: FMX.StdCtrls.TLabel;
    btnAcessar: FMX.StdCtrls.TButton;
    btnProximo: FMX.StdCtrls.TButton;
    Layout1: TLayout;
    StyleBook: TStyleBook;
    Rectangle1: TRectangle;
    edtEmail: FMX.Edit.TEdit;
    Rectangle2: TRectangle;
    edtSenha: FMX.Edit.TEdit;
    Rectangle3: TRectangle;
    edtNome: FMX.Edit.TEdit;
    Rectangle4: TRectangle;
    edtEmailCad1: FMX.Edit.TEdit;
    Rectangle5: TRectangle;
    edtSenhaCad1: FMX.Edit.TEdit;
    Rectangle6: TRectangle;
    edtConfirmaSenha: FMX.Edit.TEdit;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Rectangle9: TRectangle;
    edtBairro: FMX.Edit.TEdit;
    Rectangle10: TRectangle;
    edtEndereco: FMX.Edit.TEdit;
    Rectangle11: TRectangle;
    edtCpf: FMX.Edit.TEdit;
    Rectangle12: TRectangle;
    edtNumero: FMX.Edit.TEdit;
    Rectangle13: TRectangle;
    edtRG: FMX.Edit.TEdit;
    btnCadPessoal: FMX.StdCtrls.TButton;
    sqlExecutar: TFDQuery;
    cbxEstado: TComboBox;
    Layout2: TLayout;
    Label6: FMX.StdCtrls.TLabel;
    Label5: FMX.StdCtrls.TLabel;
    ImgVoltar: TImage;
    TabItem1: TTabItem;
    Image1: TImage;
    Layout3: TLayout;
    Label1: FMX.StdCtrls.TLabel;
    Label4: FMX.StdCtrls.TLabel;
    Button1: FMX.StdCtrls.TButton;
    Rectangle14: TRectangle;
    Edit1: FMX.Edit.TEdit;
    Rectangle15: TRectangle;
    Edit2: FMX.Edit.TEdit;
    Rectangle16: TRectangle;
    Edit3: FMX.Edit.TEdit;
    Rectangle17: TRectangle;
    Edit4: FMX.Edit.TEdit;
    Label7: FMX.StdCtrls.TLabel;
    TabItem2: TTabItem;
    Image2: TImage;
    Layout4: TLayout;
    Label8: FMX.StdCtrls.TLabel;
    Label9: FMX.StdCtrls.TLabel;
    Button3: FMX.StdCtrls.TButton;
    Rectangle18: TRectangle;
    Edit5: FMX.Edit.TEdit;
    Rectangle19: TRectangle;
    Edit6: FMX.Edit.TEdit;
    Rectangle20: TRectangle;
    Edit7: FMX.Edit.TEdit;
    Rectangle21: TRectangle;
    Edit8: FMX.Edit.TEdit;
    Label10: FMX.StdCtrls.TLabel;
    TabItem3: TTabItem;
    Image3: TImage;
    Layout5: TLayout;
    Label11: FMX.StdCtrls.TLabel;
    Label12: FMX.StdCtrls.TLabel;
    Button4: FMX.StdCtrls.TButton;
    Rectangle22: TRectangle;
    Edit9: FMX.Edit.TEdit;
    Rectangle23: TRectangle;
    Edit10: FMX.Edit.TEdit;
    Rectangle24: TRectangle;
    Edit11: FMX.Edit.TEdit;
    Rectangle25: TRectangle;
    Edit12: FMX.Edit.TEdit;
    Label13: FMX.StdCtrls.TLabel;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    Layout6: TLayout;
    Label14: FMX.StdCtrls.TLabel;
    Label15: FMX.StdCtrls.TLabel;
    btnProxEmp: FMX.StdCtrls.TButton;
    Rectangle26: TRectangle;
    edtNomeEmp: FMX.Edit.TEdit;
    Rectangle27: TRectangle;
    edtEmailEmp: FMX.Edit.TEdit;
    Rectangle28: TRectangle;
    edtSenhaEmp: FMX.Edit.TEdit;
    Rectangle29: TRectangle;
    edtConfirmarSenhaEmp: FMX.Edit.TEdit;
    Image4: TImage;
    Layout7: TLayout;
    Layout8: TLayout;
    Rectangle30: TRectangle;
    cbxUfEmp: TComboBox;
    Rectangle31: TRectangle;
    Rectangle32: TRectangle;
    edtBairroEmp: FMX.Edit.TEdit;
    Rectangle33: TRectangle;
    edtEnderecoEmp: FMX.Edit.TEdit;
    Rectangle34: TRectangle;
    edtCnpjEmp: FMX.Edit.TEdit;
    Rectangle35: TRectangle;
    edtNumeroEmp: FMX.Edit.TEdit;
    btnCriarEmp: FMX.StdCtrls.TButton;
    Layout9: TLayout;
    Label16: FMX.StdCtrls.TLabel;
    Label17: FMX.StdCtrls.TLabel;
    imgVoltarEmp: TImage;
    Image6: TImage;
    TabItem6: TTabItem;
    Image7: TImage;
    Layout10: TLayout;
    Label18: FMX.StdCtrls.TLabel;
    btnEmpresa: FMX.StdCtrls.TButton;
    Label19: FMX.StdCtrls.TLabel;
    btnCandidato: FMX.StdCtrls.TButton;
    Label20: FMX.StdCtrls.TLabel;
    Label21: FMX.StdCtrls.TLabel;
    Label22: FMX.StdCtrls.TLabel;
    cbxCidadeAC: TComboBox;
    cbxCidadeAL: TComboBox;
    cbxCidadeAP: TComboBox;
    cbxCidadeAM: TComboBox;
    cbxCidadeBA: TComboBox;
    cbxCidadeCE: TComboBox;
    cbxCidadeES: TComboBox;
    cbxCidadeGO: TComboBox;
    cbxCidadeMA: TComboBox;
    cbxCidadeMT: TComboBox;
    cbxCidadeMS: TComboBox;
    cbxCidadeMG: TComboBox;
    cbxCidadePA: TComboBox;
    cbxCidadePB: TComboBox;
    cbxCidadePR: TComboBox;
    cbxCidadePE: TComboBox;
    cbxCidadePI: TComboBox;
    cbxCidadeRJ: TComboBox;
    cbxCidadeRN: TComboBox;
    cbxCidadeRS: TComboBox;
    cbxCidadeRO: TComboBox;
    cbxCidadeRR: TComboBox;
    cbxCidadeSC: TComboBox;
    cbxCidadeSP: TComboBox;
    cbxCidadeSE: TComboBox;
    cbxCidadeTO: TComboBox;
    cbxCidadeDF: TComboBox;
    cbxCidadeACEmp: TComboBox;
    cbxCidadeAMEmp: TComboBox;
    cbxCidadePAEmp: TComboBox;
    cbxCidadeROEmp: TComboBox;
    cbxCidadeRREmp: TComboBox;
    cbxCidadeRSEmp: TComboBox;
    cbxCidadeSCEmp: TComboBox;
    cbxCidadeSEEmp: TComboBox;
    cbxCidadeSPEmp: TComboBox;
    cbxCidadeTOEmp: TComboBox;
    cbxCidadeAPEmp: TComboBox;
    cbxCidadeBAEmp: TComboBox;
    cbxCidadeCEEmp: TComboBox;
    cbxCidadeDFEmp: TComboBox;
    cbxCidadeESEmp: TComboBox;
    cbxCidadeGOEmp: TComboBox;
    cbxCidadeMAEmp: TComboBox;
    cbxCidadeMGEmp: TComboBox;
    cbxCidadeMSEmp: TComboBox;
    cbxCidadeMTEmp: TComboBox;
    cbxCidadePBEmp: TComboBox;
    cbxCidadePEEmp: TComboBox;
    cbxCidadePIEmp: TComboBox;
    cbxCidadePREmp: TComboBox;
    cbxCidadeRJEmp: TComboBox;
    cbxCidadeRNEmp: TComboBox;
    cbxCidadeALEmp: TComboBox;
    procedure lblCriarContaClick(Sender: TObject);
    procedure lblJaPossuiConta1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAcessarClick(Sender: TObject);
    procedure lblPossuiConta2Click(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure lblCriarContaMouseEnter(Sender: TObject);
    procedure lblCriarContaMouseLeave(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure ImgVoltarClick(Sender: TObject);
    procedure btnCandidatoClick(Sender: TObject);
    procedure btnProxEmpClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure imgVoltarEmpClick(Sender: TObject);
    procedure btnCadPessoalClick(Sender: TObject);
    procedure btnCriarEmpClick(Sender: TObject);
    procedure cbxEstadoChange(Sender: TObject);
    procedure Z(Sender: TObject);
    procedure cbxUfEmpChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtEmailCad1Exit(Sender: TObject);
    procedure edtEmailEmpExit(Sender: TObject);

  private
    vpLoginIndex : Index;
    vpUsuario : tUsuario;
    procedure SalvarConta;
    procedure VerificaPessoa;
    procedure VerificaEmpresa;
    { Private declarations }
  public
    { Public declarations }
  end;


var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses uPrincipal, dmContrateME, uFuncoes, uCarregando, uCarregandoStatic{,Vcl.StdCtrls},
  uCadInfo;

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
VAR TESTE : INTEGER;
begin
  vpTipoConta := tNada;
  try
    dm_ContrateME.qryLogin.Close;
    dm_ContrateME.qryLogin.SQL.Text := 'SELECT * FROM contrateme.cm_usuarios U ' +
                                       ' WHERE U.CM_USUARIO_EMAIL = ' + CampoSTR(edtEmail.Text) +
                                       ' AND U.CM_USUARIO_SENHA = ' + CampoSTR(edtSenha.Text);
    dm_ContrateME.qryLogin.Open;

    if dm_ContrateME.qryLogin.IsEmpty then
      raise Exception.Create('Usuário ou senha incorretos')
    else
    begin
      if Trim(dm_ContrateME.qryLogin.FindField('CM_USUARIO_TIPOCONTA').AsString) = 'E' then
      begin
        MSG('A conta empresarial em questão necessita de verificação da nossa equipe. Tempo estimado 24hrs.',0,1);
        vpTipoConta := tEmpresa;
      end
      else
        vpTipoConta := tPessoa;


      AlimentaID(dm_ContrateME.qryLogin.FindField('CM_USUARIO_COD').AsInteger);

      dm_ContrateME.qryConsulta3.Close;
      dm_ContrateME.qryConsulta3.SQL.Text := ' SELECT * FROM cm_usuarios U ' +
                                            ' WHERE U.CM_USUARIO_COD = ' + dm_ContrateME.qryLogin.FindField('CM_USUARIO_COD').AsString +
                                            ' AND (( CM_USUARIO_PRMLOGIN = ''S''  ) OR (CM_USUARIO_PRMLOGIN IS NULL)) ';

      dm_ContrateME.qryConsulta3.Open;

      if NOT dm_ContrateME.qryConsulta3.IsEmpty then
      begin
        frmCadInfo := TfrmCadInfo.Create(Self);
        if dm_ContrateME.qryConsulta3.FindField('CM_USUARIO_TIPOCONTA').AsString = 'P' then
          frmCadInfo.tabForm.TabIndex := 0
        else
          frmCadInfo.tabForm.TabIndex := 1;
        frmCadInfo.ShowModal;
        FreeMem(Pointer(frmCadInfo));
        frmCadInfo := nil;
        close;
      end
      else
      begin
        frmPrincipal  := TfrmPrincipal.Create(self);
        frmPrincipal.Showmodal;

        FreeMem(Pointer(frmPrincipal));
        frmPrincipal := nil;
        close;
      end;
    end;

  except
    on e:Exception do
    begin
      dm_ContrateME.qryLogin.Close;
      msg(e.Message,0,1);
    end;
  end;
end;

procedure TfrmLogin.btnProximoClick(Sender: TObject);
begin
  tbControl.TabIndex := vpLoginIndex.Candidato[1];
  cbxEstado.ItemIndex :=  0;
end;

procedure TfrmLogin.cbxEstadoChange(Sender: TObject);
var vCombo : array of TComboBox;
    b : integer;
begin
  vCombo := [cbxCidadeAC,
              cbxCidadeAL,
              cbxCidadeAP,
              cbxCidadeAM,
              cbxCidadeBA,
              cbxCidadeCE,
              cbxCidadeDF,
              cbxCidadeES,
              cbxCidadeGO,
              cbxCidadeMA,
              cbxCidadeMT,
              cbxCidadeMS,
              cbxCidadeMG,
              cbxCidadePA,
              cbxCidadePB,
              cbxCidadePR,
              cbxCidadePE,
              cbxCidadePI,
              cbxCidadeRJ,
              cbxCidadeRN,
              cbxCidadeRS,
              cbxCidadeRO,
              cbxCidadeRR,
              cbxCidadeSC,
              cbxCidadeSP,
              cbxCidadeSE,
              cbxCidadeTO];

  for b := 0 to Length(vCombo) -1 do
  begin
    vCombo[b].Visible := false;
    if (vCombo[b].Tag - 1) = cbxEstado.ItemIndex then
    begin
      vCombo[b].Visible := true;
      vCombo[b].ItemIndex := 0;
    end;
  end;
end;

procedure TfrmLogin.cbxUfEmpChange(Sender: TObject);
var vCombo : array of TComboBox;
    b : integer;
begin
  vCombo := [cbxCidadeACEmp,
              cbxCidadeALEmp,
              cbxCidadeAPEmp,
              cbxCidadeAMEmp,
              cbxCidadeBAEmp,
              cbxCidadeCEEmp,
              cbxCidadeDFEmp,
              cbxCidadeESEmp,
              cbxCidadeGOEmp,
              cbxCidadeMAEmp,
              cbxCidadeMTEmp,
              cbxCidadeMSEmp,
              cbxCidadeMGEmp,
              cbxCidadePAEmp,
              cbxCidadePBEmp,
              cbxCidadePREmp,
              cbxCidadePEEmp,
              cbxCidadePIEmp,
              cbxCidadeRJEmp,
              cbxCidadeRNEmp,
              cbxCidadeRSEmp,
              cbxCidadeROEmp,
              cbxCidadeRREmp,
              cbxCidadeSCEmp,
              cbxCidadeSPEmp,
              cbxCidadeSEEmp,
              cbxCidadeTOEmp];

  for b := 0 to Length(vCombo) -1 do
  begin
    vCombo[b].Visible := false;
    if (vCombo[b].Tag - 1) = cbxUfEmp.ItemIndex then
    begin
      vCombo[b].Visible := true;
      vCombo[b].ItemIndex := 0;
    end;
  end;
end;

procedure TfrmLogin.btnProxEmpClick(Sender: TObject);
begin
  tbControl.TabIndex := vpLoginIndex.Empresa[1];
end;

procedure TfrmLogin.btnEmpresaClick(Sender: TObject);
begin
  Cursor :=  crHourGlass;
  frmCarregandoStatic := TfrmCarregandoStatic.Create(Self);
  frmCarregandoStatic.Show;
  Application.ProcessMessages;
  PreencheComboBoxCidade([cbxCidadeACEmp,
                          cbxCidadeALEmp,
                          cbxCidadeAPEmp,
                          cbxCidadeAMEmp,
                          cbxCidadeBAEmp,
                          cbxCidadeCEEmp,
                          cbxCidadeDFEmp,
                          cbxCidadeESEmp,
                          cbxCidadeGOEmp,
                          cbxCidadeMAEmp,
                          cbxCidadeMTEmp,
                          cbxCidadeMSEmp,
                          cbxCidadeMGEmp,
                          cbxCidadePAEmp,
                          cbxCidadePBEmp,
                          cbxCidadePREmp,
                          cbxCidadePEEmp,
                          cbxCidadePIEmp,
                          cbxCidadeRJEmp,
                          cbxCidadeRNEmp,
                          cbxCidadeRSEmp,
                          cbxCidadeROEmp,
                          cbxCidadeRREmp,
                          cbxCidadeSCEmp,
                          cbxCidadeSPEmp,
                          cbxCidadeSEEmp,
                          cbxCidadeTOEmp]);
  frmCarregandoStatic.Free;
  frmCarregandoStatic := nil;
  Cursor := crDefault;
  tbControl.TabIndex := vpLoginIndex.Empresa[0];
  vpTipoConta := tEmpresa;
end;

procedure TfrmLogin.btnCadPessoalClick(Sender: TObject);
begin
 SalvarConta
end;

procedure TfrmLogin.btnCandidatoClick(Sender: TObject);
var vfrmCarregandoStatic : TfrmCarregandoStatic;
begin
  Cursor :=  crHourGlass;
  vfrmCarregandoStatic := TfrmCarregandoStatic.Create(Self);
  vfrmCarregandoStatic.Show;
  Application.ProcessMessages;
  PreencheComboBoxCidade([cbxCidadeAC,
                          cbxCidadeAL,
                          cbxCidadeAP,
                          cbxCidadeAM,
                          cbxCidadeBA,
                          cbxCidadeCE,
                          cbxCidadeDF,
                          cbxCidadeES,
                          cbxCidadeGO,
                          cbxCidadeMA,
                          cbxCidadeMT,
                          cbxCidadeMS,
                          cbxCidadeMG,
                          cbxCidadePA,
                          cbxCidadePB,
                          cbxCidadePR,
                          cbxCidadePE,
                          cbxCidadePI,
                          cbxCidadeRJ,
                          cbxCidadeRN,
                          cbxCidadeRS,
                          cbxCidadeRO,
                          cbxCidadeRR,
                          cbxCidadeSC,
                          cbxCidadeSP,
                          cbxCidadeSE,
                          cbxCidadeTO ]);
  Cursor := crDefault;
  tbControl.TabIndex := vpLoginIndex.Candidato[0];
  vpTipoConta := tPessoa;

  vfrmCarregandoStatic.Free;
  vfrmCarregandoStatic := nil;
end;

procedure TfrmLogin.btnCriarEmpClick(Sender: TObject);
begin
  SalvarConta;
end;

procedure TfrmLogin.edtEmailCad1Exit(Sender: TObject);
begin
  if Trim(edtEmailCad1.Text) <> '' then
  begin
    dm_ContrateME.qryConsulta.Close;
    dm_ContrateME.qryConsulta.SQL.Text := 'SELECT CM_USUARIO_EMAIL ' +
                                          ' FROM cm_usuarios ' +
                                          ' WHERE CM_USUARIO_EMAIL = ' + CampoSTR(edtEmailCad1.Text);
    dm_ContrateME.qryConsulta.Open;

    if not  dm_ContrateME.qryConsulta.IsEmpty then
    begin
       if MSG('E-mail indisponivel!, deseja realizar o login',0,1,1) = 1 then
       begin
         tbControl.TabIndex := 0;
       end
       else
       begin
         edtEmailCad1.OnExit := nil;

         edtEmailCad1.Text := '';
         edtEmailCad1.SetFocus;

         edtEmailCad1.OnExit := edtEmailCad1Exit;
       end;
    end;

  end;
end;

procedure TfrmLogin.edtEmailEmpExit(Sender: TObject);
begin
if Trim(edtEmailEmp.Text) <> '' then
  begin
    dm_ContrateME.qryConsulta.Close;
    dm_ContrateME.qryConsulta.SQL.Text := 'SELECT CM_USUARIO_EMAIL ' +
                                          ' FROM cm_usuarios ' +
                                          ' WHERE CM_USUARIO_EMAIL = ' + CampoSTR(edtEmailEmp.Text);
    dm_ContrateME.qryConsulta.Open;

    if not  dm_ContrateME.qryConsulta.IsEmpty then
    begin
       if MSG('E-mail Indisponivel! Deseja realizar o login?',0,1,1) = 1 then
       begin
         tbControl.TabIndex := 0;
       end
       else
       begin
         edtEmailEmp.OnExit := nil;

         edtEmailEmp.Text := '';
         edtEmailEmp.SetFocus;

         edtEmailEmp.OnExit := edtEmailCad1Exit;
       end;
    end;

  end;
end;

procedure TfrmLogin.edtEmailExit(Sender: TObject);
begin
  edtSenha.SetFocus;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Application.Terminate;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);

begin
  tbControl.TabIndex := 0;
  edtEmail.SetFocus;
  vpLoginIndex.DefinirConta;

  cbxEstadoChange(cbxEstado);
end;

procedure TfrmLogin.imgVoltarEmpClick(Sender: TObject);
begin
  tbControl.TabIndex := vpLoginIndex.Empresa[0];
end;

procedure TfrmLogin.ImgVoltarClick(Sender: TObject);
begin
  tbControl.TabIndex := vpLoginIndex.Candidato[0];
end;

procedure TfrmLogin.lblCriarContaClick(Sender: TObject);
begin
  cbxCidadeAC.ItemIndex := 0;
  tbControl.TabIndex := 1;
end;

procedure TfrmLogin.lblCriarContaMouseEnter(Sender: TObject);
begin
lblCriarConta.TextSettings.FontColor := $FF0B16B1;
  //TAlphaColorRec.ColorToRGB($FFFF00);
end;

procedure TfrmLogin.lblCriarContaMouseLeave(Sender: TObject);
begin
lblCriarConta.TextSettings.FontColor := $FF000000;
  //TAlphaColorRec.ColorToRGB($FFFF00);
end;

procedure TfrmLogin.lblJaPossuiConta1Click(Sender: TObject);
begin
  tbControl.TabIndex := 0;
end;

procedure TfrmLogin.lblPossuiConta2Click(Sender: TObject);
begin
  tbControl.TabIndex := 0;
end;

procedure TfrmLogin.SalvarConta;
var vCodCidade,i : integer;
    vArraCidade : Array of TComboBox;
    vNomeCidade: string;
begin
  if vpTipoConta = tPessoa then
  begin
   vArraCidade := [cbxCidadeAC,
                cbxCidadeAC,
                cbxCidadeAP,
                cbxCidadeAM,
                cbxCidadeBA,
                cbxCidadeCE,
                cbxCidadeDF,
                cbxCidadeES,
                cbxCidadeGO,
                cbxCidadeMA,
                cbxCidadeMT,
                cbxCidadeMS,
                cbxCidadeMG,
                cbxCidadePA,
                cbxCidadePB,
                cbxCidadePR,
                cbxCidadePE,
                cbxCidadePI,
                cbxCidadeRJ,
                cbxCidadeRN,
                cbxCidadeRS,
                cbxCidadeRO,
                cbxCidadeRR,
                cbxCidadeSC,
                cbxCidadeSP,
                cbxCidadeSE,
                cbxCidadeTO];

   for I := 0 to length(vArraCidade) - 1 do
   begin
      if vArraCidade[i].Visible = true then
      begin
        vNomeCidade := vArraCidade[i].Items[vArraCidade[i].ItemIndex];
      end;
   end;

   VerificaPessoa;
   dm_ContrateME.qryConsulta.Close;
   dm_ContrateME.qryConsulta.SQL.Text := ' SELECT * FROM cm_cidade C '+
                                         ' LEFT JOIN cm_estado E ON(E.CM_ESTADO_CODIGO = C.CM_CIDADE_CODESTADO) ' +
                                         ' WHERE C.CM_CIDADE_NOME = ' + CampoSTR(vNomeCidade) +
                                         ' AND E.CM_ESTADO_SIGLA = ' + CampoSTR(cbxEstado.Items[cbxEstado.ItemIndex]);
   dm_ContrateME.qryConsulta.Open;

   if not dm_ContrateME.qryConsulta.IsEmpty then
     vCodCidade := dm_ContrateME.qryConsulta.FindField('CM_CIDADE_CODIGO').AsInteger
   else
     vCodCidade := 0;
  end
  Else
  begin
    vArraCidade := [cbxCidadeACEmp,
                  cbxCidadeACEmp,
                  cbxCidadeAPEmp,
                  cbxCidadeAMEmp,
                  cbxCidadeBAEmp,
                  cbxCidadeCEEmp,
                  cbxCidadeDFEmp,
                  cbxCidadeESEmp,
                  cbxCidadeGOEmp,
                  cbxCidadeMAEmp,
                  cbxCidadeMTEmp,
                  cbxCidadeMSEmp,
                  cbxCidadeMGEmp,
                  cbxCidadePAEmp,
                  cbxCidadePBEmp,
                  cbxCidadePREmp,
                  cbxCidadePEEmp,
                  cbxCidadePIEmp,
                  cbxCidadeRJEmp,
                  cbxCidadeRNEmp,
                  cbxCidadeRSEmp,
                  cbxCidadeROEmp,
                  cbxCidadeRREmp,
                  cbxCidadeSCEmp,
                  cbxCidadeSPEmp,
                  cbxCidadeSEEmp,
                  cbxCidadeTOEmp];

     for I := 0 to length(vArraCidade) - 1 do
     begin
        if vArraCidade[i].Visible = true then
        begin
          vNomeCidade := vArraCidade[i].Items[vArraCidade[i].ItemIndex];
        end;
     end;
     VerificaEmpresa;
     dm_ContrateME.qryConsulta.Close;
     dm_ContrateME.qryConsulta.SQL.Text := ' SELECT * FROM cm_cidade C '+
                                           ' LEFT JOIN cm_estado E ON(E.CM_ESTADO_CODIGO = C.CM_CIDADE_CODESTADO) ' +
                                           ' WHERE C.CM_CIDADE_NOME = ' + CampoSTR(vNomeCidade) +
                                           ' AND E.CM_ESTADO_SIGLA = ' + CampoSTR(cbxUfEmp.Items[cbxUfEmp.ItemIndex]);
     dm_ContrateME.qryConsulta.Open;

     if not dm_ContrateME.qryConsulta.IsEmpty then
       vCodCidade := dm_ContrateME.qryConsulta.FindField('CM_CIDADE_CODIGO').AsInteger
     else
       vCodCidade := 0;
  end;

  try

    if vpTipoConta = tPessoa then
    begin
      sqlExecutar.Close;
      sqlExecutar.SQL.Text := ' INSERT INTO `contrateme`.`cm_usuarios` ' +
                              '                       (`CM_USUARIO_NOME`, ' +
                              '                        `CM_USUARIO_EMAIL`, ' +
                              '                        `CM_USUARIO_SENHA`, ' +
                              '                        `CM_USUARIO_CODCIDADE`, '+
                              '                        `CM_USUARIO_BAIRRO`, ' +
                              '                        `CM_USUARIO_ENDERECO`, ' +
                              '                        `CM_USUARIO_ENDNO`, ' +
                              '                        `CM_USUARIO_CPF`, ' +
                              '                        `CM_USUARIO_RG` , ' +
                              '                        `CM_USUARIO_PRMLOGIN`, ' +
                              '                        `CM_USUARIO_TIPOCONTA` ) ' +
                              '  VALUES (' + CampoSTR(edtNome.Text)         + ', ' +
                                             CampoSTR(edtEmailCad1.Text)    + ', ' +
                                             CampoSTR(edtSenhaCad1.Text)    + ', ' +
                                             CampoFloat(vCodCidade)         + ', ' +
                                             CampoSTR(edtBairro.Text)       + ', ' +
                                             CampoSTR(edtEndereco.Text)     + ', ' +
                                             CampoSTR(edtNumero.Text)       + ', ' +
                                             CampoSTR(edtCpf.Text)          + ', ' +
                                             CampoSTR(edtRG.Text)           + ', ' +
                                             CampoSTR('S')                  + ', ' +
                                             CampoSTR('P')                  + ');' ;
      sqlExecutar.ExecSQL;

      dm_ContrateME.conexao.Commit;
      msg('Usuario cadastrado com sucesso!',3);
      msg('Realize o login.');
      tbControl.TabIndex := 0;
    end
    else
    begin
      sqlExecutar.Close;
      sqlExecutar.SQL.Text := ' INSERT INTO `contrateme`.`cm_usuarios` ' +
                              '                       (`CM_USUARIO_NOME`, ' +
                              '                        `CM_USUARIO_EMAIL`, ' +
                              '                        `CM_USUARIO_SENHA`, ' +
                              '                        `CM_USUARIO_CODCIDADE`, '+
                              '                        `CM_USUARIO_BAIRRO`, ' +
                              '                        `CM_USUARIO_ENDERECO`, ' +
                              '                        `CM_USUARIO_ENDNO`, ' +
                              '                        `CM_USUARIO_CNPJ`, ' +
                              '                        `CM_USUARIO_CPF`, ' +
                              '                        `CM_USUARIO_RG` , ' +
                              '                        `CM_USUARIO_PRMLOGIN`, ' +
                              '                        `CM_USUARIO_TIPOCONTA` ) ' +
                              '  VALUES (' + CampoSTR(edtNomeEmp.Text)     + ', ' +
                                             CampoSTR(edtEmailEmp.Text)    + ', ' +
                                             CampoSTR(edtSenhaEmp.Text)    + ', ' +
                                             CampoFloat(vCodCidade)        + ', ' +
                                             CampoSTR(edtBairroEmp.Text)   + ', ' +
                                             CampoSTR(edtEnderecoEmp.Text) + ', ' +
                                             CampoSTR(edtNumeroEmp.Text)   + ', ' +
                                             CampoSTR(edtCnpjEmp.Text)     + ', ' +
                                             CampoSTR('0'        )         + ', ' +
                                             CampoSTR('0')                 + ', ' +
                                             CampoSTR('S')                 + ', ' +
                                             CampoSTR('E')                 + ');' ;
      sqlExecutar.ExecSQL;

      dm_ContrateME.conexao.Commit;
      MSG('Empresa cadastrada com sucesso!',3);
      msg('Realize o login.');
      tbControl.TabIndex := 0;
    end;
  except
    on e:Exception do
    begin
      if dm_ContrateME.conexao.InTransaction then
        dm_ContrateME.conexao.Rollback;
      msg('Informações incorretas confira.',2,2);
    end;
  end;
end;

procedure TfrmLogin.VerificaEmpresa;
begin
if  (trim(edtNomeEmp.Text) = '') then
  begin
    MSG('O campo Nome não está Preenchido. Verifique.', 1,1);
    edtNomeEmp.SetFocus;
    Abort;
  end;

  if (trim(edtEmailEmp.Text) = '') then
  begin
    MSG('O campo Email não está Preenchido.Verifique', 1,1);
    edtEmailEmp.SetFocus;
    Abort;
  end;

  if (trim(edtSenhaEmp.Text) = '') then
  begin
    MSG('O campo Senha não está Preenchido.Verifique', 1,1);
    edtSenhaEmp.SetFocus;
    Abort;
  end;

  if (Trim(edtConfirmarSenhaEmp.Text) = '') then
  begin
    MSG('O campo Confirmar Senha não está Preenchido.Verifique', 1,1);
    edtConfirmarSenhaEmp.SetFocus;
    Abort;
  end;

  if Not(Trim(edtSenhaEmp.Text) = Trim(edtConfirmarSenhaEmp.Text)) then
  begin
    MSG('A Confirmação de Senha não corresponde a senha informada.', 1,1);
    edtNomeEmp.SetFocus;
    Abort;
  end;

{   if  Trim(edtCidadeEmp.Text) = ''  then
  begin
    MSG('Não foi informado uma cidade para o cadastro do usuário.', 1,1);
    edtCidadeEmp.SetFocus;
    Abort;
  end;}

  if (Trim(edtEnderecoEmp.Text) = '') then
  begin
    MSG('Não foi informado o Endereço para o cadastro do usuário.', 1,1);
    edtEnderecoEmp.SetFocus;
    Abort;
  end;

  if (Trim(edtCnpjEmp.Text) = '') then
  begin
    MSG('Informe o cpf do usuário.', 1,1);
    edtCnpjEmp.SetFocus;
    Abort;
  end;
end;

procedure TfrmLogin.VerificaPessoa;
begin
if (Trim(edtNome.Text) = '') then
  begin
    MSG('O campo Nome não está Preenchido. Verifique.', 1, 1);
    edtNome.SetFocus;
    Abort;
  end;

  if (Trim(edtEmailCad1.Text) = '')then
  begin
    MSG('O campo Email não está Preenchido.Verifique', 1,1);
    edtEmail.SetFocus;
    Abort;
  end;

  if (Trim(edtSenhaCad1.Text) = '')  then
  begin
    MSG('O campo Senha não está Preenchido.Verifique', 1,1);
    edtSenha.SetFocus;
    Abort;
  end;

  if (Trim(edtConfirmaSenha.Text) = '')  then
  begin
    MSG('O campo Confirmar Senha não está Preenchido.Verifique', 1,1);
    edtConfirmaSenha.SetFocus;
    Abort;
  end;

  if Not(Trim(edtSenhaCad1.Text) = Trim(edtConfirmaSenha.Text))
  then
  begin
    MSG('A Confirmação de Senha não corresponde a senha informada.', 1,1);
    edtNome.SetFocus;
    Abort;
  end;

{  if (Trim(edtCidade.Text) = '') then
  begin
    ShowMessage('Não foi informado uma cidade para o cadastro do usuário.');
    edtCidade.SetFocus;
    Abort;
  end;
}
  if (Trim(edtEndereco.Text) = '') then
  begin
    MSG('Não foi informado o Endereço para o cadastro do usuário.', 1,1);
    edtEndereco.SetFocus;
    Abort;
  end;

  if (Trim(edtCpf.Text) = '') then
  begin
    MSG('Informe o cpf do usuário.', 1,1);
    edtCpf.SetFocus;
    Abort;
  end;
end;

procedure TfrmLogin.Z(Sender: TObject);
begin

end;

{ Index }

procedure Index.DefinirConta;
begin
    Empresa[0]:= 4;
    Empresa[1]:= 5;

    Candidato[0]:= 2;
    Candidato[1]:= 3;
end;

end.
