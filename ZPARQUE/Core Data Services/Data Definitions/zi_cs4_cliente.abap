@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_CS4_Cliente
  as select from zdt_cliente as Cliente
  association [1..1] to ZI_CS4_TipoCliente as _TipoCliente on $projection.IdTipoCliente = _TipoCliente.IdTipo
                                                          
  composition [0..*] of ZI_CS4_Veiculo as _Veiculos
{
  @EndUserText.label: 'ID Cliente'
  key Cliente.id_cliente as IdCliente,
  
  @EndUserText.label: 'Nome'
  Cliente.nome as Nome,
  
  @EndUserText.label: 'NIF'
  Cliente.nif as Nif,
  
  @EndUserText.label: 'Email'
  Cliente.email as Email,
  
  @EndUserText.label: 'Telefone'
  Cliente.telefone as Telefone,
  
  @EndUserText.label: 'Tipo Cliente'
  @ObjectModel.text.element: ['TipoClienteDescricao']
  Cliente.id_tipo_cliente as IdTipoCliente,
  
  @EndUserText.label: 'Descrição Tipo Cliente'
  _TipoCliente.Descricao as TipoClienteDescricao,
  
  
  
  @Semantics.user.createdBy: true
  @EndUserText.label: 'Criado Por'
  Cliente.local_created_by as CreatedBy,
  
  @Semantics.systemDateTime.createdAt: true
  @EndUserText.label: 'Criado Em'
  Cliente.local_created_at as CreatedAt,
  
  @Semantics.user.lastChangedBy: true
  @EndUserText.label: 'Alterado Por'
  Cliente.local_last_changed_by as LastChangedBy,
  
  @Semantics.systemDateTime.lastChangedAt: true
  @EndUserText.label: 'Alterado Em'
  Cliente.last_changed_at as LastChangedAt,
  
  /* Associations */
  _TipoCliente,
  _Veiculos
}
