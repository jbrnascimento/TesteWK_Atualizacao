unit ModelEntidadePedidoProduto;

interface

uses
  InterfaceConexao, Data.DB;

Type
    TModelEntidadePedidoProduto = class(TInterfacedObject, iModelEntidade)
    private
        FQuery : iModelQuery;
    public
        constructor Create;
        destructor Destroy; override;
        class function New : iModelEntidade;
        function DataSet ( aValue : TDataSource ) : iModelEntidade;
        procedure Open;
    end;

implementation

uses
  ModelConexaoFactory;

{ TModelEntidadePedidoProduto }

constructor TModelEntidadePedidoProduto.Create;
begin
    FQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntidadePedidoProduto.DataSet(aValue: TDataSource): iModelEntidade;
begin
    Result := Self;
    aValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelEntidadePedidoProduto.Destroy;
begin
    inherited;
end;

class function TModelEntidadePedidoProduto.New: iModelEntidade;
begin
    Result := Self.Create;
end;

procedure TModelEntidadePedidoProduto.Open;
begin
    FQuery.Open('select * from pedidos_produtos');
end;

end.
