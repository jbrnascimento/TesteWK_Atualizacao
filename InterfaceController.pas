unit InterfaceController;

interface

uses
  InterfaceConexao;

type
   iController = interface
   function Entidades : iModelEntidadeFactory;
end;

implementation

end.
