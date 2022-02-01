program Teste_WK;

uses
  Vcl.Forms,
  FormCadastroPedidos in 'FormCadastroPedidos.pas' {frmCadastradoPedidos},
  InterfaceConexao in 'InterfaceConexao.pas',
  ModelFiredacConexao in 'ModelFiredacConexao.pas',
  ModelFiredacQuery in 'ModelFiredacQuery.pas',
  ModelConexaoFactory in 'ModelConexaoFactory.pas',
  ModelEntidadeCliente in 'ModelEntidadeCliente.pas',
  ModelEntidadeFactory in 'ModelEntidadeFactory.pas',
  InterfaceController in 'InterfaceController.pas',
  Controller in 'Controller.pas',
  ModelEntidadeProduto in 'ModelEntidadeProduto.pas',
  ModelEntidadePedidoDadoGeral in 'ModelEntidadePedidoDadoGeral.pas',
  ModelEntidadePedidoProduto in 'ModelEntidadePedidoProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastradoPedidos, frmCadastradoPedidos);
  Application.Run;
end.
