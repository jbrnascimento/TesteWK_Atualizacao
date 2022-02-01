unit ModelEntidadePedidoDadoGeral;

interface

uses
  InterfaceConexao, Data.DB;

Type
    TModelEntidadePedidoDadoGeral = class(TInterfacedObject, iModelEntidade)
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

{ TModelEntidadePedidoDadoGeral }

constructor TModelEntidadePedidoDadoGeral.Create;
begin
    FQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntidadePedidoDadoGeral.DataSet(aValue: TDataSource): iModelEntidade;
begin
    Result := Self;
    aValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelEntidadePedidoDadoGeral.Destroy;
begin
    inherited;
end;

class function TModelEntidadePedidoDadoGeral.New: iModelEntidade;
begin
    Result := Self.Create;
end;

procedure TModelEntidadePedidoDadoGeral.Open;
begin
    FQuery.Open('select * from pedidos_dados_gerais');
end;

end.
