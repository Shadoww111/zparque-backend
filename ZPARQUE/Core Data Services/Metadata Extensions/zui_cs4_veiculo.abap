@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Veículo', 
    typeNamePlural: 'Veículos',
    title: { type: #STANDARD, value: 'Matricula' },
    description: { type: #STANDARD, value: 'Marca' }
  }
}
annotate view ZC_CS4_Veiculo with {
  @UI.facet: [
    { 
      id: 'VeiculoDetails', 
      purpose: #STANDARD, 
      type: #COLLECTION, 
      label: 'Veículo', 
      position: 10 
    },
    { 
      id: 'BasicData', 
      parentId: 'VeiculoDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Dados Básicos', 
      position: 10, 
      targetQualifier: 'BasicData' 
    }
  ]

  @UI: {
    lineItem: [{ position: 10, importance: #HIGH, label: 'ID Veículo' }],
    identification: [{ position: 10, label: 'ID Veículo' }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 10, label: 'ID Veículo' }]
  IdVeiculo;

  @UI: {
    lineItem: [{ position: 20, importance: #HIGH, label: 'Matrícula' }],
    identification: [{ position: 20, label: 'Matrícula' }],
    selectionField: [{ position: 10 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 20, label: 'Matrícula' }]
  Matricula;

  @UI: {
    lineItem: [{ position: 30, importance: #MEDIUM, label: 'Marca' }],
    identification: [{ position: 30, label: 'Marca' }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 30, label: 'Marca' }]
  Marca;

  @UI: {
    lineItem: [{ position: 40, importance: #MEDIUM, label: 'Modelo' }],
    identification: [{ position: 40, label: 'Modelo' }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 40, label: 'Modelo' }]
  Modelo;

  @UI: {
    lineItem: [{ position: 50, importance: #MEDIUM, label: 'Tipo Veículo' }],
    identification: [{ position: 50, label: 'Tipo Veículo' }],
    selectionField: [{ position: 20 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 50, label: 'Tipo Veículo' }]
  IdTipoVeiculo;
  
  @UI: {
    lineItem: [{ position: 55, importance: #MEDIUM, label: 'Descrição Tipo' }]
  }
    @UI.hidden: true
  
  TipoVeiculoDescricao;

  @UI: {
    lineItem: [{ position: 60, importance: #HIGH, label: 'Cliente' }],
    identification: [{ position: 60, label: 'Cliente' }],
    selectionField: [{ position: 30 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 60, label: 'Cliente' }]
  IdCliente;
@UI: {
  lineItem: [{ position: 65, importance: #MEDIUM, label: 'Nome Cliente' }]
}
@UI.hidden: true

ClienteNome;
  @UI: {
    lineItem: [{ position: 70, importance: #MEDIUM, label: 'Elétrico' }],
    identification: [{ position: 70, label: 'Elétrico' }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 70, label: 'Elétrico' }]
  Eletrico;
}