@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Disponibilidade de Estacionamento'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_CS4_Disponibilidade
  as select from zdisponibilidade
{
  @EndUserText.label: 'ID da Disponibilidade'
  key id_dispo as IdDisponibilidade,
  @EndUserText.label: 'Total de Lugares para Motos'
  lugares_moto_total as LugaresMotoTotal,
  @EndUserText.label: 'Lugares para Motos Ocupados'
  lugares_moto_ocupados as LugaresMotoOcupados,
  @EndUserText.label: 'Lugares para Motos Disponíveis'
  lugares_moto_total - lugares_moto_ocupados as LugaresMotoLivres,
  @EndUserText.label: 'Criticidade de Ocupação - Motos'
  case 
      when lugares_moto_ocupados * 100 >= lugares_moto_total * 80 then 1  // Crítico (Vermelho) - 80%
      when lugares_moto_ocupados * 100 >= lugares_moto_total * 60 then 2  // Médio (Amarelo) - 60%
      else 3                                                              // Normal (Verde)
  end as MotoOcupadosCriticality,
  @EndUserText.label: 'Criticidade de Disponibilidade - Motos'
  case
      when (lugares_moto_total - lugares_moto_ocupados) * 100 <= lugares_moto_total * 20 then 1  // Crítico (Vermelho) - 20%
      when (lugares_moto_total - lugares_moto_ocupados) * 100 <= lugares_moto_total * 40 then 2  // Médio (Amarelo) - 40%
      else 3                                                                                     // Normal (Verde)
  end as MotoLivresCriticality,
  @EndUserText.label: 'Total de Lugares para Ligeiros'
  lugares_ligeiro_total as LugaresLigeiroTotal,
  @EndUserText.label: 'Lugares para Ligeiros Ocupados'
  lugares_ligeiro_ocupados as LugaresLigeiroOcupados,
  @EndUserText.label: 'Lugares para Ligeiros Disponíveis'
  lugares_ligeiro_total - lugares_ligeiro_ocupados as LugaresLigeiroLivres,
  @EndUserText.label: 'Criticidade de Ocupação - Ligeiros'
  case 
      when lugares_ligeiro_ocupados * 100 >= lugares_ligeiro_total * 80 then 1  // Crítico (Vermelho) - 80%
      when lugares_ligeiro_ocupados * 100 >= lugares_ligeiro_total * 60 then 2  // Médio (Amarelo) - 60%
      else 3                                                                    // Normal (Verde)
  end as LigeiroOcupadosCriticality,
  @EndUserText.label: 'Criticidade de Disponibilidade - Ligeiro'
  case
      when (lugares_ligeiro_total - lugares_ligeiro_ocupados) * 100 <= lugares_ligeiro_total * 20 then 1  // Crítico (Vermelho) - 20%
      when (lugares_ligeiro_total - lugares_ligeiro_ocupados) * 100 <= lugares_ligeiro_total * 40 then 2  // Médio (Amarelo) - 40%
      else 3                                                                                              // Normal (Verde)
  end as LigeiroLivresCriticality,
  @EndUserText.label: 'Total de Lugares para Pesados'
  lugares_pesado_total as LugaresPesadoTotal,
  @EndUserText.label: 'Lugares para Pesados Ocupados'
  lugares_pesado_ocupados as LugaresPesadoOcupados,
  @EndUserText.label: 'Lugares para Pesados Disponíveis'
  lugares_pesado_total - lugares_pesado_ocupados as LugaresPesadoLivres,
  @EndUserText.label: 'Criticidade de Ocupação - Pesados'
  case 
      when lugares_pesado_ocupados * 100 >= lugares_pesado_total * 80 then 1  // Crítico (Vermelho) - 80%
      when lugares_pesado_ocupados * 100 >= lugares_pesado_total * 60 then 2  // Médio (Amarelo) - 60%
      else 3                                                                  // Normal (Verde)
  end as PesadoOcupadosCriticality,
  @EndUserText.label: 'Criticidade de Disponibilidade - Pesados'
  case
      when (lugares_pesado_total - lugares_pesado_ocupados) * 100 <= lugares_pesado_total * 20 then 1  // Crítico (Vermelho) - 20%
      when (lugares_pesado_total - lugares_pesado_ocupados) * 100 <= lugares_pesado_total * 40 then 2  // Médio (Amarelo) - 40%
      else 3                                                                                           // Normal (Verde)
  end as PesadoLivresCriticality,
  @EndUserText.label: 'Criado Por'
  @Semantics.user.createdBy: true
  local_created_by as CreatedBy,
  @EndUserText.label: 'Data de Criação'
  @Semantics.systemDateTime.createdAt: true
  local_created_at as CreatedAt,
  @EndUserText.label: 'Última Modificação Por'
  @Semantics.user.lastChangedBy: true
  local_last_changed_by as LastChangedBy,
  @EndUserText.label: 'Data da Última Modificação'
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
