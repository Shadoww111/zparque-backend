managed implementation in class zbp_i_cs4_disponibilidade unique;
strict ( 2 );
with draft;
define behavior for ZI_CS4_Disponibilidade alias Disponibilidade
persistent table zdisponibilidade
draft table zdisponivel_d
lock master total etag  LastChangedAt
authorization master ( instance )
{
update;

  field ( readonly )  CreatedBy, CreatedAt, LastChangedBy, LastChangedAt;
  field ( mandatory ) LugaresMotoTotal, LugaresLigeiroTotal, LugaresPesadoTotal;

 draft action Activate optimized;
  draft action Discard;
  draft action Edit;
  draft action Resume;
  draft determine action Prepare;
  mapping for zdisponibilidade
  {
    LugaresMotoTotal = lugares_moto_total;
    LugaresMotoOcupados = lugares_moto_ocupados;
    LugaresLigeiroTotal = lugares_ligeiro_total;
    LugaresLigeiroOcupados = lugares_ligeiro_ocupados;
    LugaresPesadoTotal = lugares_pesado_total;
    LugaresPesadoOcupados = lugares_pesado_ocupados;
    CreatedBy = local_created_by;
    CreatedAt = local_created_at;
    LastChangedBy = local_last_changed_by;
    LastChangedAt = last_changed_at;  }
}