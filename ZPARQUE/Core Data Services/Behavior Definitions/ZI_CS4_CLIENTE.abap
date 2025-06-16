
unmanaged implementation in class ZBP_CS4_CLIENTE unique;
with draft;
define behavior for ZI_CS4_Cliente alias Cliente
draft table zdt_cliente_d
lock master total etag LastChangedAt
etag master LastChangedAt
{
create;
update;
delete;
association _Veiculos { create; }

field ( readonly )  CreatedBy, CreatedAt, LastChangedBy, LastChangedAt;
field ( readonly  ) IdCliente;

draft action Activate optimized;
  draft action Discard;
  draft action Edit;
  draft action Resume;
  draft determine action Prepare;

mapping for zdt_cliente
{
IdCliente = id_cliente;
Nome = nome;
Nif = nif;
Email = email;
Telefone = telefone;
IdTipoCliente = id_tipo_cliente;
CreatedBy = local_created_by;
CreatedAt = local_created_at;
LastChangedBy = local_last_changed_by;
LastChangedAt = last_changed_at;
}
}

define behavior for ZI_CS4_Veiculo alias Veiculo
draft table zdt_veiculo_d
lock dependent by _Cliente
etag master LastChangedAt
{
update;
delete;
association _Cliente;

field ( readonly ) IdCliente, IdVeiculo, CreatedBy, CreatedAt, LastChangedBy, LastChangedAt;
field ( mandatory ) Matricula, IdTipoVeiculo;

mapping for zdt_veiculo
{
IdVeiculo = id_veiculo;
Matricula = matricula;
Marca = marca;
Modelo = modelo;
IdTipoVeiculo = id_tipo_veiculo;
IdCliente = id_cliente;
Eletrico = eletrico;
CreatedBy = local_created_by;
CreatedAt = local_created_at;
LastChangedBy = local_last_changed_by;
LastChangedAt = last_changed_at;
}
}