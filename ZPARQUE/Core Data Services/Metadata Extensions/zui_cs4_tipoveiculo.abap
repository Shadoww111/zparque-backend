@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Tipo de Veículo', 
    typeNamePlural: 'Tipos de Veículos',
    title: { type: #STANDARD, value: 'Descricao' },
    description: { type: #STANDARD, value: 'IdTipo' }
  }
}
annotate view ZC_CS4_TipoVeiculo with {
  @UI.facet: [
    { 
      id: 'TipoVeiculoDetails', 
      purpose: #STANDARD, 
      type: #COLLECTION, 
      label: 'Tipo de Veículo', 
      position: 10 
    },
    { 
      id: 'BasicData', 
      parentId: 'TipoVeiculoDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Dados Básicos', 
      position: 10, 
      targetQualifier: 'BasicData' 
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
    lineItem: [{ position: 30, importance: #MEDIUM, label: 'Preço por Hora' }],
    identification: [{ position: 30, label: 'Preço por Hora' }]
  }
 @UI.fieldGroup: [{ qualifier: 'BasicData', position: 30, label: 'Preço por Hora' }]
  PrecoHora;

  @UI: {
    lineItem: [{ position: 40, importance: #MEDIUM, label: 'Moeda' }],
    identification: [{ position: 40, label: 'Moeda' }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 40, label: 'Moeda' }]
  Moeda;
}