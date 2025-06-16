# zparque-backend 🚗📦

Este repositório contém a parte **backend** do projeto **ZParque**, desenvolvido no contexto de um estágio. O objetivo é gerir um parque de estacionamento de forma automatizada, eficiente e escalável, com base na plataforma SAP.

## 📌 Descrição do Projeto

O backend é responsável por toda a lógica de negócio e persistência de dados do sistema, incluindo:

- Controlo de entradas e saídas de viaturas
- Cálculo automático do custo de estacionamento
- Aplicação de descontos com base em tipo de cliente e veículo
- Gestão de clientes e respetivos veículos
- Gestão de ocupação do parque por tipo de viatura

A lógica foi implementada em **SAP ABAP**, com exposição via **OData**, permitindo integração direta com as aplicações Fiori no frontend.

## 🚗 Tipos de Veículos

- Ligeiro
- Motociclo
- Pesado

## 👥 Tipos de Cliente

- Clientes com diferentes níveis de desconto
- Descontos aplicados por tipo de veículo associado

## 🅿️ Capacidade do Parque

- 65 Lugares para veículos ligeiros
- 20 Lugares para motociclos
- 15 Lugares para veículos pesados

## ⚙️ Tecnologias Utilizadas

- **SAP ABAP** (lógica de negócio e persistência)
- **OData Services** (exposição da lógica para o frontend)
- Arquitetura orientada a objetos (OO ABAP)

## 🧩 Funcionalidades Disponíveis

- 📥 **Entrada de Viatura**
  - Validação de cliente
  - Alocação automática do lugar
- 📤 **Saída de Viatura**
  - Cálculo do tempo de estadia e custo final
  - Aplicação de descontos
- 👤 **Gestão de Clientes**
  - Dados pessoais e veículos associados
  - Diferenciação por tipo de cliente
- 🅿️ **Gestão de Ocupação**
  - Controlo de lugares disponíveis por tipo
- 💰 **Gestão de Faturação**
  - Cálculo detalhado por tipo de viatura e cliente

## 🚧 Funcionalidades Planeadas (Bónus)

- 📄 Geração de fatura em PDF no momento da saída
- 🗺️ Visualização de mapa do parque (lugares ocupados/livres)
- 🔌 Gestão de lugares com carregador elétrico (custo por consumo de energia)

## 🖇️ Integração com o Frontend

Este backend comunica com as aplicações SAP Fiori presentes no repositório [zparque-frontend](https://github.com/Shadoww111/zparque-frontend), através de serviços OData personalizados.

## 📄 Licença

Este projeto foi desenvolvido no âmbito de um estágio curricular e destina-se a fins educativos e demonstrativos.

---

