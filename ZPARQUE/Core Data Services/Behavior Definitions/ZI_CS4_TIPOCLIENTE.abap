managed implementation in class zbp_cs4_tipo_cliente unique;
strict ( 2 );
with draft;
define behavior for ZI_CS4_TipoCliente alias TipoCliente
persistent table ztipo_cliente
draft table ztipo_cliente_d
lock master total etag LastChangedAt
authorization master ( global )
{
  create;
  update;
  delete;

  field ( readonly )  CreatedBy, CreatedAt, LastChangedBy, LastChangedAt;
  field ( mandatory ) Descricao;
  field ( readonly : update) IdTipo;
draft action Activate optimized;
  draft action Discard;
  draft action Edit;
  draft action Resume;
  draft determine action Prepare;
  mapping for ztipo_cliente
  {
    IdTipo = id_tipo;
    Descricao = descricao;
    DescontoLigeiro = desconto_ligeiro;
    DescontoMoto = desconto_moto;
    DescontoPesado = desconto_pesado;
    CreatedBy = local_created_by;
    CreatedAt = local_created_at;
    LastChangedBy = local_last_changed_by;
    LastChangedAt = last_changed_at;
  }
}