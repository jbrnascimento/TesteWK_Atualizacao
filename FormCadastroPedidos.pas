unit FormCadastroPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, InterfaceController, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.NumberBox,
  Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client;

type
  TfrmCadastradoPedidos = class(TForm)
    statusBarPedido: TStatusBar;
    gpbItemProduto: TGroupBox;
    lblNomeCliente: TLabel;
    lblDescricaoProduto: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodigoCliente: TLabeledEdit;
    edtCodigoProduto: TLabeledEdit;
    btnSalvarItemProduto: TButton;
    edtQuantidade: TNumberBox;
    edtPrecoUnitario: TNumberBox;
    gpbPedido: TGroupBox;
    btnGravarPedido: TButton;
    stgPedidos: TStringGrid;
    Splitter1: TSplitter;
    FDConnection1: TFDConnection;
    btnCarregarPedido: TButton;
    btnExcluiPedido: TButton;
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure btnSalvarItemProdutoClick(Sender: TObject);
    procedure stgPedidosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure btnCarregarPedidoClick(Sender: TObject);
    procedure btnExcluiPedidoClick(Sender: TObject);
  private
    { Private declarations }
    FController : iController;
    dtsCliente, dtsProduto, dtsPedidosDadosGerais, dtsPedidosProdutos : TDataSource;
    valorTotal : Double;
  public
    { Public declarations }
  end;

var
  frmCadastradoPedidos: TfrmCadastradoPedidos;

implementation

uses
  Controller;

{$R *.dfm}

procedure TfrmCadastradoPedidos.btnCarregarPedidoClick(Sender: TObject);
var codigo : string;
    Linha  : Integer;
begin
   codigo := InputBox('Consultar pedido', 'Número do Pedido', '');
   if Trim(codigo) = EmptyStr then Exit;

   if not dtsPedidosDadosGerais.DataSet.Locate('numero_pedido',codigo,[]) then
   begin
     ShowMessage('Pedido não localizado.');
     Exit;
   end;

   edtCodigoCliente.Text := dtsPedidosDadosGerais.DataSet.FieldByName('codigo_cliente').AsString;
   edtCodigoClienteExit(edtCodigoCliente);

   valorTotal := dtsPedidosDadosGerais.DataSet.FieldByName('valor_total').Value;
   statusBarPedido.Panels.Items[0].Text := 'Valor Total ' + FormatFloat('#,##0.00',valorTotal);

   stgPedidos.RowCount := 1;
   dtsPedidosProdutos.DataSet.Filter   := 'numero_pedido = ' + QuotedStr(codigo);
   dtsPedidosProdutos.DataSet.Filtered := True;
   dtsPedidosProdutos.DataSet.First;
   while not dtsPedidosProdutos.DataSet.Eof do
   begin
      stgPedidos.RowCount := stgPedidos.RowCount +1;
      Linha := stgPedidos.RowCount -1;

      dtsProduto.DataSet.Locate('codigo',dtsPedidosProdutos.DataSet.FieldByName('codigo_produto').AsString,[]);

      stgPedidos.Cells[0,Linha] := dtsPedidosProdutos.DataSet.FieldByName('codigo_produto').AsString;
      stgPedidos.Cells[1,Linha] := dtsProduto.DataSet.FieldByName('descricao').AsString;
      stgPedidos.Cells[2,Linha] := FormatFloat('#,##0.00',dtsPedidosProdutos.DataSet.FieldByName('quantidade').AsFloat);
      stgPedidos.Cells[3,Linha] := FormatFloat('#,##0.00',dtsPedidosProdutos.DataSet.FieldByName('valor_unitario').AsFloat);
      stgPedidos.Cells[4,Linha] := FormatFloat('#,##0.00',dtsPedidosProdutos.DataSet.FieldByName('valor_total').AsFloat);

      dtsPedidosProdutos.DataSet.Next;
   end;

end;

procedure TfrmCadastradoPedidos.btnExcluiPedidoClick(Sender: TObject);
var codigo : string;
    Linha  : Integer;
begin
   codigo := InputBox('Excluir pedido', 'Número do Pedido', '');
   if Trim(codigo) = EmptyStr then Exit;

   if not dtsPedidosDadosGerais.DataSet.Locate('numero_pedido',codigo,[]) then
   begin
     ShowMessage('Pedido não localizado.');
     Exit;
   end;

   valorTotal := 0;
   statusBarPedido.Panels.Items[0].Text := 'Valor Total ' + FormatFloat('#,##0.00',valorTotal);

   stgPedidos.RowCount := 1;
   dtsPedidosProdutos.DataSet.Filter   := 'numero_pedido = ' + QuotedStr(codigo);
   dtsPedidosProdutos.DataSet.Filtered := True;
   dtsPedidosProdutos.DataSet.First;
   while not dtsPedidosProdutos.DataSet.Eof do
   begin
      dtsPedidosProdutos.DataSet.Delete;
   end;
   dtsPedidosDadosGerais.DataSet.Delete;
end;

procedure TfrmCadastradoPedidos.btnGravarPedidoClick(Sender: TObject);
var sql : string;
    I : Integer;
begin
  if stgPedidos.RowCount <= 1 then Exit;

  TFDQuery(dtsPedidosDadosGerais.DataSet).Connection.StartTransaction;
  try
    dtsPedidosDadosGerais.DataSet.Insert;
    dtsPedidosDadosGerais.DataSet.FieldByName('data_emissao').Value := Date;
    dtsPedidosDadosGerais.DataSet.FieldByName('codigo_cliente').AsString := edtCodigoCliente.Text;
    dtsPedidosDadosGerais.DataSet.FieldByName('valor_total').Value := valorTotal;
    dtsPedidosDadosGerais.DataSet.Post;
  except
    on E:Exception do
    begin
       ShowMessage('Erro ao gravar o pedido. '+E.Message);
       TFDQuery(dtsPedidosDadosGerais.DataSet).Connection.Rollback;
       Exit;
    end;
  end;

  dtsPedidosProdutos.DataSet.Close;
  TFDQuery(dtsPedidosProdutos.DataSet).Connection := TFDQuery(dtsPedidosDadosGerais.DataSet).Connection;
  dtsPedidosProdutos.DataSet.Open;
  try
    for I := 1 to Pred(stgPedidos.RowCount) do
    begin
      dtsPedidosProdutos.DataSet.Insert;
      dtsPedidosProdutos.DataSet.FieldByName('numero_pedido').Value := dtsPedidosDadosGerais.DataSet.FieldByName('numero_pedido').Value;
      dtsPedidosProdutos.DataSet.FieldByName('codigo_produto').AsString := stgPedidos.Cells[0,I];
      dtsPedidosProdutos.DataSet.FieldByName('quantidade').Value := stgPedidos.Cells[2,I];
      dtsPedidosProdutos.DataSet.FieldByName('valor_unitario').Value := stgPedidos.Cells[3,I];
      dtsPedidosProdutos.DataSet.FieldByName('valor_total').Value := stgPedidos.Cells[4,I];
      dtsPedidosProdutos.DataSet.Post;
    end;
  except
    on E:Exception do
    begin
       ShowMessage('Erro ao gravar o pedido. '+E.Message);
       TFDQuery(dtsPedidosProdutos.DataSet).Connection.Rollback;
       Exit;
    end;
  end;

  if TFDQuery(dtsPedidosDadosGerais.DataSet).Connection.InTransaction then
     TFDQuery(dtsPedidosDadosGerais.DataSet).Connection.Commit;

  ShowMessage('Pedido Gravado com sucesso.');
end;

procedure TfrmCadastradoPedidos.btnSalvarItemProdutoClick(Sender: TObject);
var Linha : Integer;
    total : Double;
begin
   if edtCodigoCliente.Text = EmptyStr then
   begin
     ShowMessage('Favor informar o código do cliente.');
     edtCodigoCliente.SetFocus;
     Exit;
   end;

   if edtCodigoCliente.Text = EmptyStr then
   begin
     ShowMessage('Favor informar o código do produto.');
     edtCodigoProduto.SetFocus;
     Exit;
   end;

   if edtQuantidade.ValueFloat <= 0 then
   begin
     ShowMessage('Favor informar a quantidade.');
     edtQuantidade.SetFocus;
     Exit;
   end;

   if edtPrecoUnitario.ValueCurrency <= 0 then
   begin
     ShowMessage('Favor informar o preço unitário.');
     edtPrecoUnitario.SetFocus;
     Exit;
   end;

   total := edtQuantidade.ValueFloat * edtPrecoUnitario.ValueCurrency;

   if stgPedidos.Tag = 0 then
   begin
     stgPedidos.RowCount := stgPedidos.RowCount + 1;
     Linha := stgPedidos.RowCount -1;
     valorTotal := valorTotal + total;
   end
   else
   begin
     Linha := stgPedidos.Row;
     valorTotal := valorTotal - StrToFloat(stgPedidos.Cells[4,Linha]);
   end;

   stgPedidos.Cells[0,Linha] := dtsProduto.DataSet.FieldByName('codigo').AsString;
   stgPedidos.Cells[1,Linha] := dtsProduto.DataSet.FieldByName('descricao').AsString;
   stgPedidos.Cells[2,Linha] := edtQuantidade.Text;
   stgPedidos.Cells[3,Linha] := edtPrecoUnitario.Text;
   stgPedidos.Cells[4,Linha] := FormatFloat('#,##0.00',total);

   statusBarPedido.Panels.Items[0].Text := 'Valor Total ' + FormatFloat('#,##0.00',valorTotal);

   if not edtCodigoCliente.Enabled then edtCodigoCliente.Enabled := True;
   if not edtCodigoProduto.Enabled then edtCodigoProduto.Enabled := True;

   stgPedidos.Tag := 0;
end;

procedure TfrmCadastradoPedidos.edtCodigoClienteChange(Sender: TObject);
begin
   btnExcluiPedido.Visible      := edtCodigoCliente.Text = EmptyStr;
   btnCarregarPedido.Visible    := edtCodigoCliente.Text = EmptyStr;
end;

procedure TfrmCadastradoPedidos.edtCodigoClienteExit(Sender: TObject);
begin

   if edtCodigoCliente.Text = EmptyStr then Exit;

   if not dtsCliente.DataSet.Locate('codigo',edtCodigoCliente.Text,[]) then
   begin
      ShowMessage('Cliente não cadastrado.');
      edtCodigoCliente.SetFocus;
      Exit;
   end;

   lblNomeCliente.Caption := dtsCliente.DataSet.FieldByName('nome').AsString + ' - ' +
                             dtsCliente.DataSet.FieldByName('cidade').AsString + '-' +
                             dtsCliente.DataSet.FieldByName('uf').AsString;

end;

procedure TfrmCadastradoPedidos.edtCodigoProdutoExit(Sender: TObject);
begin

   if edtCodigoProduto.Text = EmptyStr then Exit;

   if not dtsProduto.DataSet.Locate('codigo',edtCodigoProduto.Text,[]) then
   begin
      ShowMessage('Produto não cadastrado.');
      edtCodigoProduto.SetFocus;
      Exit;
   end;

   edtPrecoUnitario.Value := dtsProduto.DataSet.FieldByName('preco_venda').Value;

   lblDescricaoProduto.Caption := dtsProduto.DataSet.FieldByName('descricao').AsString + ' - Preço venda: ' +
                                  FormatFloat('#,##0.00',dtsProduto.DataSet.FieldByName('preco_venda').Value);

end;

procedure TfrmCadastradoPedidos.FormCreate(Sender: TObject);
begin
   dtsCliente            := TDataSource.Create(Self);
   dtsProduto            := TDataSource.Create(Self);
   dtsPedidosDadosGerais := TDataSource.Create(Self);
   dtsPedidosProdutos    := TDataSource.Create(Self);

   FController := TController.New;

   FController
       .Entidades
          .Cliente
          .DataSet(dtsCliente)
       .Open;

   FController
       .Entidades
          .Produto
          .DataSet(dtsProduto)
       .Open;

  FController
       .Entidades
          .PedidoDadoGeral
          .DataSet(dtsPedidosDadosGerais)
       .Open;

  FController
       .Entidades
          .PedidoProduto
          .DataSet(dtsPedidosProdutos)
       .Open;

   lblNomeCliente.Caption := '';
   lblDescricaoProduto.Caption := '';

   valorTotal := 0;

   stgPedidos.RowCount := 1;
   stgPedidos.ColWidths[0] := 120;
   stgPedidos.ColWidths[1] := 300;
   stgPedidos.ColWidths[2] := 100;
   stgPedidos.ColWidths[3] := 100;
   stgPedidos.ColWidths[4] := 100;

   stgPedidos.Cells[0,0] := 'Código do produto';
   stgPedidos.Cells[1,0] := 'Descrição do produto';
   stgPedidos.Cells[2,0] := 'Quantidade';
   stgPedidos.Cells[3,0] := 'Valor unitário';
   stgPedidos.Cells[4,0] := 'Valor total';

end;

procedure TfrmCadastradoPedidos.stgPedidosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var I, J : Integer;
begin
   if (stgPedidos.RowCount = 1) then Exit;

   if Key = VK_RETURN then
   begin
     edtCodigoCliente.Enabled := False;
     edtCodigoProduto.Enabled := False;

     edtCodigoProduto.Text := stgPedidos.Cells[0,stgPedidos.Row];
     edtQuantidade.Text    := stgPedidos.Cells[2,stgPedidos.Row];
     edtPrecoUnitario.Text := stgPedidos.Cells[3,stgPedidos.Row];
     stgPedidos.Tag := 1;
     edtCodigoProdutoExit(edtCodigoProduto);
   end
   else if Key = VK_DELETE then
   begin
      if MessageDlg('Confirma exclusão ?', mtConfirmation, [mbYes, mbNo],0) = mrNo then Exit;

      valorTotal := valorTotal - StrToFloat(stgPedidos.Cells[4,stgPedidos.Row]);
      statusBarPedido.Panels.Items[0].Text := 'Valor Total ' + FormatFloat('#,##0.00',valorTotal);

      for I := stgPedidos.Row to stgPedidos.RowCount do
        for J := 0 to Pred(stgPedidos.ColCount) do
          stgPedidos.cells[J,I] := stgPedidos.cells[J,I+1];

      stgPedidos.rowcount := stgPedidos.rowcount - 1;
   end;


end;

end.
