unit uUsuario;

interface

type
  tUsuario = record

  end;

type
  TTipoCadastro = (tPessoa, tEmpresa,tNada);

Procedure AlimentaId(id: integer);
Procedure EncerrrarSecess�o;

 var tID: integer = 0;
      vpTipoConta : TTipoCadastro;

implementation

{ tUsuario }

uses uLogin;

Procedure AlimentaId(id: integer);
begin
 tID := id;
end;

Procedure EncerrrarSecess�o;
begin
 tID := 0;
end;

end.
