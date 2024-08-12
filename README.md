# LocalizaLabs Challenge

Desafio proposto pela LocalizaLabs. 

## Descrição do Projeto

- **Objetivo:** Subir uma infra na AWS para abrigar uma aplicação simples em micro serviço.
- **Tecnologias Utilizadas:** Terraform, python, flask, bash, awscli, github e github actions

## GitHub Actions

O projeto utiliza GitHub Actions para automação. Sempre que um push é feito para a branch `main`, o fluxo de trabalho do GitHub Actions é executado automaticamente. Isso inclui:

- **Testes Automatizados:** Verifica se o código funciona conforme esperado, sintaxe e faz testes de segurança staticos (SAST)
- **Build e Deploy:** Compila o código e realiza o deploy, se configurado.

## Como Funciona

1. **Criação de Ticket:**
   - Antes de começar, abra um ticket com a descrição da issue ou da feature que você vai trabalhar.

2. **Criação de Branch:**
   - Baseado no que vai fazer, crie uma branch seguindo o padrão `ticket-{hotfix ou issue}`. 
     - Exemplo para um hotfix: `DevOps-1234/hotfix - descrição`
     - Exemplo para uma issue: `DevOps-1234/issue - descrição`

3. **Desenvolvimento:**
   - Faça alterações no código na branch que criou.
   - Faça o commit das suas alterações. (Não esqueça de informar o que fez, isso ajuda a aprovar a pr mais rápido.)

4. **Criação de Pull Request:**
   - Abra a pr para a branch `main`.
   - A pr deve ser revisada e aprovada por um grupo específico de usuários com permissão para aprovação. Nem todos têm a permissão para aprovar pr's.

5. **Aprovação e Merge:**
   - Após a aprovação, a pr deve ser mergeada na branch `main`.

6. **Ação Automática:**
   - Após o merge, o GitHub Actions executará automaticamente o CI/CD configurado, testes automatizados, build e deploy.
