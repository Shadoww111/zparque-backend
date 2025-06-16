# zparque-backend 🚗📦

Este repositório contém a parte **backend** do projeto **ZParque**, desenvolvido no contexto de um estágio, com o objetivo de gerir um parque de estacionamento de forma eficiente e automatizada.

## 📌 Descrição do Projeto

O sistema permite o controlo e gestão de entradas e saídas de viaturas, cálculo de custos, gestão de clientes e verificação da disponibilidade de lugares, com base nas seguintes regras:

- Controlo de entradas e saídas
- Cálculo automático do custo de estacionamento (dependente do tipo de cliente e veículo)
- Gestão de clientes e respetivos veículos
- Gestão da ocupação do parque por tipo de viatura:
  - 65 Lugares para veículos ligeiros
  - 20 Lugares para motociclos
  - 15 Lugares para veículos pesados

### Tipos de Veículos
- Ligeiro
- Motociclo
- Pesado

### Tipos de Cliente
- Clientes com diferentes níveis de desconto, dependente do tipo de veículo associado

## ⚙️ Tecnologias Utilizadas

- **SAP ABAP** (lógica de backend)
- Integração com **SAP Fiori** (no frontend)
- Arquitetura orientada a objetos

> Este repositório representa apenas o **backend** do sistema. A parte **frontend** será implementada em SAP Fiori (Launchpad) com várias aplicações para interação com os dados.

## 🧩 Funcionalidades Backend

- 📥 Registo de entrada de viaturas
- 📤 Registo de saída e cálculo do custo de estadia
- 👤 Gestão de clientes e veículos
- 🅿️ Gestão de disponibilidade de lugares por tipo de veículo
- 💰 Aplicação de descontos com base no tipo de cliente e veículo
- 📊 Geração de dados para relatórios de faturação (para visualização no frontend)

## 📁 Estrutura do Projeto

A estrutura do projeto segue boas práticas de organização no desenvolvimento em ABAP, com separação de responsabilidades e modularidade no código.

## 🚧 Funcionalidades Bónus Planeadas (se houver tempo)

- Geração de fatura em PDF no momento da saída
- Visualização de mapa do parque com lugares ocupados e livres
- Gestão de lugares com carregador elétrico (incluindo cálculo de consumo de energia)

## 📄 Licença

Este projeto é apenas para fins educativos e de demonstração no contexto de estágio.

---

