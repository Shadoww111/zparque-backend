@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Tipo de Cliente', 
    typeNamePlural: 'Tipos de Clientes',
    title: { type: #STANDARD, value: 'Descricao' },
    description: { type: #STANDARD, value: 'IdTipo' }
  }
}
annotate view ZC_CS4_TipoCliente with {
  @UI.facet: [
    { 
      id: 'TipoClienteDetails', 
      purpose: #STANDARD, 
      type: #COLLECTION, 
      label: 'Tipo de Cliente', 
      position: 10 
    },
    { 
      id: 'BasicData', 
      parentId: 'TipoClienteDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Dados Básicos', 
      position: 10, 
      targetQualifier: 'BasicData' 
    },
    { 
      id: 'DescontoData', 
      parentId: 'TipoClienteDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Descontos', 
      position: 20, 
      targetQualifier: 'DescontoData' 
    }
  ]

  @UI: {
    lineItem: [{ position: 10, importance: #HIGH, label: 'ID Tipo' }],
    identification: [{ position: 10, label: 'ID Tipo' }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 10, label: 'ID Tipo' }]
  IdTipo;

  @UI: {
    lineItem: [{ position: 20, importance: #HIGH, label: 'Descrição' }],
    identification: [{ position: 20, label: 'Descrição' }],
    selectionField: [{ position: 10 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 20, label: 'Descrição' }]
  Descricao;

  @UI: {
    lineItem: [{ position: 30, importance: #MEDIUM, label: 'Desconto Ligeiro (%)' }],
    identification: [{ position: 30, label: 'Desconto Ligeiro (%)' }]
  }
  @UI.fieldGroup: [{ qualifier: 'DescontoData', position: 10, label: 'Desconto Ligeiro (%)' }]
  DescontoLigeiro;

  @UI: {
    lineItem: [{ position: 40, importance: #MEDIUM, label: 'Desconto Moto (%)' }],
    identification: [{ position: 40, label: 'Desconto Moto (%)' }]
  }
  @UI.fieldGroup: [{ qualifier: 'DescontoData', position: 20, label: 'Desconto Moto (%)' }]
  DescontoMoto;

  @UI: {
    lineItem: [{ position: 50, importance: #MEDIUM, label: 'Desconto Pesado (%)' }],
    identification: [{ position: 50, label: 'Desconto Pesado (%)' }]
  }
  @UI.fieldGroup: [{ qualifier: 'DescontoData', position: 30, label: 'Desconto Pesado (%)' }]
  DescontoPesado;
}