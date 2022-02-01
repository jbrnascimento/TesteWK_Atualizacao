unit InterfaceConexao;

interface

uses Data.DB;

type
    iModelQuery = interface;

    iModelConexao = interface
   ['{B01429FB-FA41-43F6-AB7A-4713C214CD02}']
        function Connection : TObject;
    end;

    iModelConexaoFactory = interface
    ['{E13F5576-2CCA-45A7-8D4D-97B4C026DB60}']
        function Conexao : iModelConexao;
        function Query : iModelQuery;
    end;

    iModelQuery = interface
    ['{70C3B460-CFB9-44F5-A063-62C742561E63}']
        function Query : TObject;
        function Open(aSQL : String) : iModelQuery;
        function ExecSQL(aSQL : String) : iModelQuery;
    end;

    iModelEntidade = interface
    ['{047EE5A9-8F33-4BEE-8864-CFB530A56A5A}']
        function DataSet ( aValue : TDataSource ) : iModelEntidade;
        procedure Open;
    end;

    iModelEntidadeFactory = interface
    ['{8B18CC0A-F1D6-4B65-B8A1-FB68CEFB8AAB}']
        function Produto   : iModelEntidade;
        function Cliente   : iModelEntidade;
        function PedidoDadoGeral : iModelEntidade;
        function PedidoProduto   : iModelEntidade;
    end;

implementation

end.
