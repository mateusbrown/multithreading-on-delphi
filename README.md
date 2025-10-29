# MonitorRecursosSistema

Este projeto é um monitor de recursos do sistema desenvolvido em Delphi, utilizando multithreading para coleta e visualização em tempo real de métricas do computador. É parte do repositório [mateusbrown/multithreading-on-delphi](https://github.com/mateusbrown/multithreading-on-delphi).

## Funcionalidades

- **Monitoramento de CPU:** Percentual de uso da CPU, atualizado em intervalos regulares.
- **Monitoramento de Memória:** Percentual de uso da memória RAM.
- **Monitoramento de Disco:** Bytes lidos e escritos em discos físicos.
- **Monitoramento de Rede:** Bytes transmitidos e recebidos por todas as interfaces de rede.
- **Interface Gráfica VCL:** Visualização dos dados em gráficos interativos separados por abas.
- **Multithreading:** As coletas são realizadas em tarefas paralelas, sem bloquear a interface.

## Estrutura dos Arquivos Principais

- `src/MonitorRecursosSistema.dpr`  
  Arquivo principal do projeto, inicializa o formulário principal.

- `src/uMain.pas`  
  Implementa o formulário, lógica dos timers, coleta dos dados e atualização dos gráficos.

- `src/uMain.dfm`  
  Define visualmente a interface: abas para CPU, Memória, Armazenamento e Rede, cada uma com gráficos e datasets próprios.

- `src/uWinUsageHelpers.pas`  
  Funções para obter estatísticas do sistema usando APIs do Windows, como uso de CPU, memória, disco e rede.

- `src/MonitorRecursosSistema.dproj`  
  Metadados do projeto Delphi (configurações de build, plataformas, dependências).

- `src/MonitorRecursosSistema.res`  
  Recursos do aplicativo (ícone, versão, etc).

## Como funciona

1. **Inicialização:**  
   O projeto inicializa o formulário principal e prepara os datasets para cada recurso.

2. **Coleta periódica:**  
   Timers ativam tarefas paralelas (usando `TTask.Run`) para coletar dados do sistema (CPU, Memória, Disco, Rede) sem travar a interface.

3. **Atualização dos gráficos:**  
   Os dados são inseridos nos datasets e exibidos em gráficos (usando TeeChart), mantendo um histórico limitado.

4. **Abas de visualização:**  
   Cada aba mostra um gráfico em tempo real para o respectivo recurso, com uso percentual ou quantidade de bytes.

## Requisitos

- Delphi (VCL, compatível com Windows)
- Permissões administrativas podem ser necessárias para acessar métricas de disco e rede

## Instalação e Execução

1. Clone o repositório:
   ```bash
   git clone https://github.com/mateusbrown/multithreading-on-delphi.git
   ```
2. Abra o projeto `src/MonitorRecursosSistema.dproj` no Delphi.
3. Compile e execute.

## Licença

MIT License

---

Projeto mantido por [mateusbrown](https://github.com/mateusbrown)
