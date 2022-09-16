unit ControllerEndereco;

interface

type
  TEndereco = class
    private
      Fidendereco: Integer;
      FdsCep: string;
      Fidpessoa: Integer;
      procedure SetdsCep(const Value: string);
      procedure Setidendereco(const Value: Integer);
      procedure Setidpessoa(const Value: Integer);
    public
      property idendereco : Integer read Fidendereco write Setidendereco;
      property idpessoa : Integer read Fidpessoa write Setidpessoa;
      property dsCep : string read FdsCep write SetdsCep;

      constructor Create;
      destructor Destroy;
    protected
  end;

implementation

{ TEndereco }

constructor TEndereco.Create;
begin

end;

destructor TEndereco.Destroy;
begin

end;

procedure TEndereco.SetdsCep(const Value: string);
begin
  FdsCep := Value;
end;

procedure TEndereco.Setidendereco(const Value: Integer);
begin
  Fidendereco := Value;
end;

procedure TEndereco.Setidpessoa(const Value: Integer);
begin
  Fidpessoa := Value;
end;

end.
