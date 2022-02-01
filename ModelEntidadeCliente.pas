unit ModelEntidadeCliente;

interface

uses
  InterfaceConexao, Data.DB;

Type
    TModelEntidadeCliente = class(TInterfacedObject, iModelEntidade)
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

{ TModelEntidadeCliente }

constructor TModelEntidadeCliente.Create;
begin
    FQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntidadeCliente.DataSet(aValue: TDataSource): iModelEntidade;
begin
    Result := Self;
    aValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelEntidadeCliente.Destroy;
begin
    inherited;
end;

class function TModelEntidadeCliente.New: iModelEntidade;
begin
    Result := Self.Create;
end;

procedure TModelEntidadeCliente.Open;
begin
    FQuery.Open('select * from clientes');
end;

end.
