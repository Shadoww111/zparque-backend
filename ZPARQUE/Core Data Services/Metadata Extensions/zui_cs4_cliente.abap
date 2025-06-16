@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Cliente', 
    typeNamePlural: 'Clientes',
    title: { type: #STANDARD, value: 'Nome' },
    description: { type: #STANDARD, value: 'IdCliente' }
  },
  presentationVariant: [{
    sortOrder: [{
      by: 'IdCliente',
      direction: #DESC
    }],
    visualizations: [{
      type: #AS_LINEITEM
    }]
  }]
}
annotate view ZC_CS4_Cliente with {
  @UI.facet: [
    { 
      id: 'ClienteDetails', 
      purpose: #STANDARD, 
      type: #COLLECTION, 
      label: 'Cliente', 
      position: 10 
    },
    { 
      id: 'BasicData', 
      parentId: 'ClienteDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Dados Básicos', 
      position: 10, 
      targetQualifier: 'BasicData' 
    },
    { 
      id: 'ContactData', 
      parentId: 'ClienteDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Contacto', 
      position: 20, 
      targetQualifier: 'ContactData' 
    },
    { 
      id: 'Veiculos', 
      purpose: #STANDARD, 
      type: #LINEITEM_REFERENCE, 
      label: 'Veículos', 
      position: 30, 
      targetElement: '_Veiculos' 
    }
  ]

  @UI: {
    lineItem: [{ position: 10, importance: #HIGH, label: 'ID Cliente' }],
    identification: [{ position: 10, label: 'ID Cliente' }],
    selectionField: [{ position: 10 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 10, label: 'ID Cliente' }]
  IdCliente;

  @UI: {
    lineItem: [{ position: 20, importance: #HIGH, label: 'Nome' }],
    identification: [{ position: 20, label: 'Nome' }],
    selectionField: [{ position: 20}]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 20, label: 'Nome' }]
  Nome;

  @UI: {
    lineItem: [{ position: 30, importance: #MEDIUM, label: 'NIF' }],
    identification: [{ position: 30, label: 'NIF' }],
    selectionField: [{ position: 30}]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 30, label: 'NIF' }]
  Nif;

  @UI: {
    lineItem: [{ position: 50, importance: #MEDIUM, label: 'Email' }],
    identification: [{ position: 50, label: 'Email' }]
  }
  @UI.fieldGroup: [{ qualifier: 'ContactData', position: 10, label: 'Email' }]
  Email;

  @UI: {
    lineItem: [{ position: 60, importance: #MEDIUM, label: 'Telefone' }],
    identification: [{ position: 60, label: 'Telefone' }]
  }
  @UI.fieldGroup: [{ qualifier: 'ContactData', position: 20, label: 'Telefone' }]
  Telefone;

  @UI: {
    lineItem: [{ position: 70, importance: #MEDIUM, label: 'Tipo Cliente' }],
    identification: [{ position: 70, label: 'Tipo Cliente' }],
    selectionField: [{ position: 40}]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 40, label: 'Tipo Cliente' }]
  IdTipoCliente;
  
  @UI: {
    lineItem: [{ position: 75, importance: #MEDIUM, label: 'Descrição Tipo' }]
  }
  @UI.hidden: true
  TipoClienteDescricao;

  @UI: {
    lineItem: [{ position: 80, importance: #MEDIUM, label: 'Ativo' }],
    identification: [{ position: 80, label: 'Ativo' }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 50, label: 'Ativo' }]
  Ativo;
}