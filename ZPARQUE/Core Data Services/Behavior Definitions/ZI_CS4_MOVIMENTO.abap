unmanaged implementation in class zbp_cs4_movimento unique;
strict ( 2 );
with draft;
define behavior for ZI_CS4_Movimento alias Movimento
draft table zmovimento_d
lock master total etag  LastChangedAt
authorization master ( instance )
{
 create;
  update;
  delete;


  field ( readonly )   IdCliente, CreatedBy, CreatedAt, LastChangedBy, LastChangedAt, DataEntrada, DataSaida, Status;
  field ( mandatory ) Matricula, IdTipoVeiculo;
  field ( readonly ) IdMovimento;

//  action ( features : instance ) registrarEntrada result [1] $self;
action registrarSaida result [1] $self;
//  action ( features : instance ) calcularValor result [1] $self;

 draft action Activate optimized;
  draft action Discard;
  draft action Edit;
  draft action Resume;
  draft determine action Prepare;
  mapping for zmovimento
  {
    IdMovimento = id_movimento;
    IdVeiculo = id_veiculo;
    Matricula = matricula;
    IdCliente = id_cliente;
    IdTipoVeiculo = id_tipo_veiculo;
    DataEntrada = data_entrada;
    DataSaida = data_saida;
    DuracaoHoras = duracao_horas;
    ValorBruto = valor_bruto;
    Desconto = desconto;
    ValorLiquido = valor_liquido;
    Moeda = moeda;
    Status = status;
    CreatedBy = local_created_by;
    CreatedAt = local_created_at;
    LastChangedBy = local_last_changed_by;
    LastChangedAt = last_changed_at;
  }
}