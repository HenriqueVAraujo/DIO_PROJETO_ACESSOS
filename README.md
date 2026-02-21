# Projeto de Banco de Dados: Otimização, Segurança e Automação

Este repositório apresenta soluções avançadas em SQL desenvolvidas para cenários de Company e E-commerce. O foco do projeto é a implementação de estruturas que garantam a integridade dos dados, performance em consultas complexas e automação de processos.

## Estrutura do Projeto

O projeto está dividido em dois scripts principais:

### Parte 1: Performance e Controle de Acesso
Localizado no arquivo `parte1.sql`, este script aborda:
* **Indexação**: Criação de índices B-Tree para otimização de JOINs e filtros de busca em grandes volumes de dados.
* **Views**: Implementação de visualizações para abstração de complexidade, permitindo que usuários visualizem relatórios consolidados sem acesso direto às tabelas base.
* **Segurança (DCL)**: Gestão de privilégios de usuários, diferenciando permissões entre níveis hierárquicos (Gerente vs. Funcionário).

### Parte 2: Automação e Integridade
Localizado no arquivo `parte2.sql`, este script aborda:
* **Stored Procedures**: Centralização da lógica de CRUD (Create, Read, Update, Delete) com variáveis de controle e estruturas condicionais (CASE/IF).
* **Triggers**: Gatilhos para auditoria e persistência, garantindo que exclusões de usuários sejam arquivadas e que atualizações salariais sigam regras de negócio estritas.

## Decisões Técnicas

* **Uso de B-Tree**: Escolhido para os índices devido à alta eficiência em operações de comparação e busca por intervalo.
* **Princípio do Menor Privilégio**: As permissões de usuários foram restringidas via Views para evitar a exposição desnecessária de dados sensíveis.
* **Triggers de Auditoria**: Implementados para garantir a rastreabilidade das alterações no banco de dados sem intervenção manual.

## Como Utilizar

1. Execute o script `parte1.sql` para preparar o ambiente de otimização e permissões.
2. Execute o script `parte2.sql` para instalar as rotinas de automação (Procedures e Triggers).
3. Utilize o comando `CALL` para interagir com as procedures de manipulação de dados.
