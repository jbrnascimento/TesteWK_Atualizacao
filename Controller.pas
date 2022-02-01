unit Controller;

interface

uses
  InterfaceController, InterfaceConexao;

Type
    TController = class(TInterfacedObject, iController)
    private
        FModelEntidades : iModelEntidadeFactory;
    public
        constructor Create;
        destructor Destroy; override;
        class function New : iController;
        function Entidades : iModelEntidadeFactory;
    end;

implementation

uses
  ModelEntidadeFactory;

{ TController }

constructor TController.Create;
begin
    FModelEntidades := TModelEntidadesFactory.New;
end;

destructor TController.Destroy;
begin
    inherited;
end;

function TController.Entidades: iModelEntidadeFactory;
begin
    Result := FModelEntidades;
end;

class function TController.New: iController;
begin
    Result := Self.Create;
end;

end.
