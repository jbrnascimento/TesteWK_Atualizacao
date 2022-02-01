unit ModelFiredacConexao;

interface

uses InterfaceConexao,
     FireDAC.Stan.Def,
     FireDAC.UI.Intf,
     FireDAC.VCLUI.Wait,
     FireDAC.Phys.MySQL,
     FireDAC.Phys,
     FireDAC.Comp.UI,
     FireDAC.Stan.Intf,
     FireDAC.Comp.Client,
     FireDAC.DApt,
     FireDAC.Stan.Async;

Type
    TModelFiredacConexao = class(TInterfacedObject, iModelConexao)
    private
        FConexao : TFDConnection;
    public
       constructor Create;
       destructor Destroy; override;
       class function New : iModelConexao;
       function Connection : TObject;
    end;

implementation

uses
  System.SysUtils;

{ TModelFiredacConexao }

function TModelFiredacConexao.Connection: TObject;
begin
    Result := FConexao;
end;

constructor TModelFiredacConexao.Create;
begin
    FConexao := TFDConnection.Create(nil);
    FConexao.Params.DriverID := 'MySQL';
    FConexao.Params.Database := 'teste_wk';
    FConexao.Params.UserName := 'root';
    FConexao.Params.Password := '123456';
    FConexao.Params.Values['CharacterSet'] := 'utf8mb4';
    FConexao.Connected := true;
end;

destructor TModelFiredacConexao.Destroy;
begin
    FreeAndNil(FConexao);
    inherited;
end;

class function TModelFiredacConexao.New: iModelConexao;
begin
  Result := Self.Create;
end;

end.
