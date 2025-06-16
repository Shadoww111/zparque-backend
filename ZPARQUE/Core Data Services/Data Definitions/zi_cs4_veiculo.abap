@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for Veiculo'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CS4_Veiculo
  as select from zdt_veiculo as Veiculo
  association to parent ZI_CS4_Cliente as _Cliente on $projection.IdCliente = _Cliente.IdCliente
  association [1..1] to ZI_CS4_TipoVeiculo as _TipoVeiculo on $projection.IdTipoVeiculo = _TipoVeiculo.IdTipo
{
  @EndUserText.label: 'ID do Veículo'
  key Veiculo.id_veiculo as IdVeiculo,
  @EndUserText.label: 'Matrícula'
  Veiculo.matricula as Matricula,
  @EndUserText.label: 'Marca'
  Veiculo.marca as Marca,
  @EndUserText.label: 'Modelo'
  Veiculo.modelo as Modelo,
  @EndUserText.label: 'Tipo de Veículo'
  @ObjectModel.text.element: ['TipoVeiculoDescricao']
  Veiculo.id_tipo_veiculo as IdTipoVeiculo,
  @EndUserText.label: 'Descrição Tipo Veículo'
  _TipoVeiculo.Descricao as TipoVeiculoDescricao,
  @EndUserText.label: 'Cliente'
  @ObjectModel.text.element: ['ClienteNome']
  Veiculo.id_cliente as IdCliente,
  @EndUserText.label: 'Nome do Cliente'
  _Cliente.Nome as ClienteNome,
  @EndUserText.label: 'Elétrico'
  Veiculo.eletrico as Eletrico,
   @Semantics.user.createdBy: true
  @EndUserText.label: 'Criado Por'
  local_created_by as CreatedBy,
  
  @Semantics.systemDateTime.createdAt: true
  @EndUserText.label: 'Criado Em'
  local_created_at as CreatedAt,
  
  @Semantics.user.lastChangedBy: true
  @EndUserText.label: 'Alterado Por'
  local_last_changed_by as LastChangedBy,
  
  @Semantics.systemDateTime.lastChangedAt: true
  @EndUserText.label: 'Alterado Em'
  last_changed_at as LastChangedAt,
  
  
  /* Associations */
  _Cliente,
  _TipoVeiculo
}
