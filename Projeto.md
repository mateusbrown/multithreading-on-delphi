# Projeto: Monitor de Recursos do Sistema (Delphi Multithread)

## Objetivo

Criar uma aplicação que monitore em tempo real o uso de recursos do sistema operacional, como CPU, memória RAM, disco e rede, utilizando threads para coletar cada tipo de informação simultaneamente.

## Funcionalidades

- **Coleta Paralela dos Dados**

  - Uma thread para monitorar o uso da CPU.
  - Uma thread para monitorar o uso da memória RAM.
  - Uma thread para monitorar o disco (espaço livre/ocupado, uso de I/O).
  - Uma thread para monitorar a rede (velocidade de download/upload, pacotes enviados/recebidos).

- **Interface Gráfica Responsiva**

  - Um painel para cada recurso, mostrando gráficos ou barras de progresso em tempo real.
  - Atualização periódica (por exemplo, a cada 1 segundo) dos dados exibidos.

- **Configuração de Intervalos**

  - Permitir ao usuário alterar o intervalo de atualização dos dados (ex: 500ms, 1s, 5s).

- **Histórico**

  - Armazenar e exibir histórico dos dados coletados (ex: últimos 5 minutos).

- **Alertas**
  - Notificar o usuário se algum recurso ultrapassar um limite configurado (ex: CPU > 90%).

## Como Exercitar Multithreading

- Crie uma classe para cada tipo de monitoramento, herdando de `TThread`.
- Implemente sincronização para atualizar a interface gráfica sem causar travamentos (ex: usando `Synchronize` ou `TThread.Queue`).
- Evite conflitos de acesso a dados compartilhados usando mecanismos como `CriticalSection`, caso necessário.
- Permita iniciar/parar cada thread separadamente para testar cenários de concorrência e impacto no desempenho.

## Exemplos de Componentes Delphi Úteis

- `TThread`: para criar threads.
- `TTimer`: para atualizações periódicas.
- `TChart` ou `TProgressBar`: para exibir os dados.
- `TMemo` ou `TStringGrid`: para mostrar histórico.

## Dicas de Implementação

- Use performance counters do Windows (ex: via Windows API ou WMI) para coletar dados.
- Teste o comportamento do app com diferentes números de threads.
- Implemente logs para identificar possíveis race conditions ou problemas de sincronização.
- Experimente pausar, retomar e finalizar threads dinamicamente.
