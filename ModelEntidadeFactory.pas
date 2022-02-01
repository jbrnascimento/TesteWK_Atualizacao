unit ModelEntidadeFactory;

interface

uses
  InterfaceConexao;

type
    TModelEntidadesFactory = class(TInterfacedObject, iModelEntidadeFactory)
    private
        FProduto        : iModelEntidade;
        FCliente        : iModelEntidade;
        FPedidoDadoGeral : iModelEntidade;
        FPedidoProduto   : iModelEntidade;

    public
        constructor Create;
        destructor Destroy; override;
        class function New       : iModelEntidadeFactory;
        function Produto         : iModelEntidade;
        function Cliente         : iModelEntidade;
        function PedidoDadoGeral : iModelEntidade;
        function PedidoProduto   : iModelEntidade;
    end;

implementation

uses
  ModelEntidadeProduto, ModelEntidadeCliente,
  ModelEntidadePedidoProduto,ModelEntidadePedidoDadoGeral;

{ TModelEntidadesFactory }

constructor TModelEntidadesFactory.Create;
begin

end;

destructor TModelEntidadesFactory.Destroy;
begin
    inherited;
end;

class function TModelEntidadesFactory.New: iModelEntidadeFactory;
begin
    Result := Self.Create;
end;

function TModelEntidadesFactory.Cliente: iModelEntidade;
begin
  if not Assigned(FCliente) then
       FCliente := TModelEntidadeCliente.New;
   Result := FCliente;
end;

function TModelEntidadesFactory.PedidoDadoGeral: iModelEntidade;
begin
   if not Assigned(FPedidoDadoGeral) then
       FPedidoDadoGeral := TModelEntidadePedidoDadoGeral.New;
   Result := FPedidoDadoGeral;
end;

function TModelEntidadesFactory.PedidoProduto: iModelEntidade;
begin
   if not Assigned(FPedidoProduto) then
       FPedidoProduto := TModelEntidadePedidoProduto.New;
   Result := FPedidoProduto;
end;

function TModelEntidadesFactory.Produto: iModelEntidade;
begin
   if not Assigned(FProduto) then
       FProduto := TModelEntidadeProduto.New;
   Result := FProduto;
end;

end.
