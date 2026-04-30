# Vitta Place — Marketplace Multivendedor

## Sobre o projeto

O Vitta Place é um projeto de banco de dados desenvolvido em MySQL para representar a estrutura de um marketplace multivendedor.

O projeto contempla o controle de clientes, vendedores, produtos, pedidos, itens do pedido, pagamentos, taxas, estornos, repasses financeiros, despesas operacionais e apuração de DRE por período.

## Objetivo

O objetivo do projeto é demonstrar a aplicação de modelagem de banco de dados, regras de negócio, Views e Stored Procedures em um cenário próximo de uma operação real de marketplace.

## Tecnologias utilizadas

- MySQL
- MySQL Workbench
- SQL
- Views
- Stored Procedures

## Principais funcionalidades

- Cadastro de clientes
- Cadastro de vendedores
- Cadastro de produtos
- Registro de pedidos
- Controle de itens do pedido
- Registro de pagamentos
- Controle de taxas de pagamento
- Registro de estornos
- Geração de repasses aos vendedores
- Cálculo de comissão do marketplace
- Registro de despesas operacionais
- Apuração de DRE por período
- Auditoria de inconsistências entre produto e vendedor

## Estrutura do projeto

- README.md
- script_vittaplace.sql
- documento_auditoria_vittaplace.docx

## Views implementadas

- vw_resumo_pedido
- vw_produto_vendedor
- vw_repasse_vendedor
- vw_dre_periodo

## Stored Procedures implementadas

- sp_registrar_pagamento_e_repasse
- sp_consultar_dre_periodo
- sp_registrar_despesa_operacional
- sp_auditar_vendedor_produto_item

## Regras de negócio principais

1. Um pedido pode conter produtos de diferentes vendedores.
2. O valor do pedido considera quantidade, preço unitário, desconto e frete.
3. O pagamento confirmado altera o pedido para o status PAGO.
4. O repasse ao vendedor só é gerado após pagamento confirmado.
5. O marketplace retém comissão sobre as vendas.
6. A DRE considera receitas, taxas, estornos, frete subsidiado e despesas operacionais.
7. O vendedor informado no item do pedido deve ser o mesmo vendedor cadastrado no produto.

## Modelo de dados

O modelo de dados foi estruturado com base nas principais entidades de um marketplace multivendedor, contemplando clientes, vendedores, produtos, pedidos, pagamentos, taxas, estornos, repasses e despesas operacionais.

As relações entre as tabelas estão implementadas diretamente no script SQL por meio de chaves primárias e chaves estrangeiras.

## Como executar o projeto

1. Abrir o MySQL Workbench.
2. Criar uma conexão com o MySQL.
3. Abrir o arquivo script_vittaplace.sql.
4. Executar o script completo.
5. Validar as Views e Stored Procedures com as consultas de auditoria.

## Exemplos de consultas

As imagens abaixo demonstram a validação das principais consultas de auditoria do projeto no MySQL Workbench.

## Evidências de execução

As imagens abaixo demonstram a validação das principais consultas de auditoria do projeto no MySQL Workbench.

### Consulta da View DRE por período

[Consulta da View DRE por período] <img width="952" height="218" alt="01_view_dre_periodo" src="https://github.com/user-attachments/assets/46c441f6-47c9-4219-81cf-65599f6711e7" />

### Execução da Stored Procedure de consulta da DRE

[Execução da Stored Procedure de consulta da DRE] <img width="954" height="197" alt="02_procedure_consultar_dre" src="https://github.com/user-attachments/assets/2485306f-9d7b-46f8-a64f-afab07f4cd89" />

