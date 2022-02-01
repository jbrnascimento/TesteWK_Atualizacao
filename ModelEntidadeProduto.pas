unit ModelEntidadeProduto;

interface

uses
  InterfaceConexao, Data.DB;

Type
    TModelEntidadeProduto = class(TInterfacedObject, iModelEntidade)
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

{ TModelEntidadeProduto }

constructor TModelEntidadeProduto.Create;
begin
    FQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntidadeProduto.DataSet(aValue: TDataSource): iModelEntidade;
begin
    Result := Self;
    aValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelEntidadeProduto.Destroy;
begin
    inherited;
end;

class function TModelEntidadeProduto.New: iModelEntidade;
begin
    Result := Self.Create;
end;

procedure TModelEntidadeProduto.Open;
begin
    FQuery.Open('select * from produtos');
end;

end.
