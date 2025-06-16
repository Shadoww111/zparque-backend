managed implementation in class zbp_i_cs4_tipoveiculo unique;
strict ( 2 );
with draft;
define behavior for ZI_CS4_TipoVeiculo alias TipoVeiculo
persistent table ztipo_veiculo
draft table ztipo_veiculo_d
lock master total etag LastChangedAt
authorization master ( global )
{
  create;
  update;
  delete;

  field ( readonly )  CreatedBy, CreatedAt, LastChangedBy, LastChangedAt;
  field ( mandatory ) Descricao, PrecoHora, Moeda;


draft action Activate optimized;
  draft action Discard;
  draft action Edit;
  draft action Resume;
  draft determine action Prepare;

  mapping for ztipo_veiculo
  {
    IdTipo = id_tipo;
    Descricao = descricao;
    PrecoHora = preco_hora;
    Moeda = moeda;
    CreatedBy = local_created_by;
    CreatedAt = local_created_at;
    LastChangedBy = local_last_changed_by;
    LastChangedAt = last_changed_at;
  }
}