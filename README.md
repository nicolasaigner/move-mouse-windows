# MouseMover

O MouseMover é um script PowerShell que simula um movimento mínimo do mouse quando o mesmo fica ocioso por um determinado tempo. Isso evita que o computador entre em modo de espera ou hibernação.

## Como usar

### Passo 1: Download

Baixe o script [MouseMover.ps1](https://github.com/nicolasaigner/move-mouse-windows) em seu computador.

### Passo 2: Executar

Abra o PowerShell e navegue até o local onde o script foi baixado. Execute o script com o comando:

```powershell	
.\MouseMover.ps1
```


O script será executado em segundo plano e moverá o mouse quando necessário.

### Parâmetros

O script aceita os seguintes parâmetros:

- **IDLETIME:** tempo em segundos para que o mouse seja considerado ocioso (padrão: 3).
- **Debug:** habilita o modo de depuração do PowerShell.

Para definir um valor diferente para o parâmetro IDLETIME, utilize o comando:

```powershell	
.\MouseMover.ps1 -IDLETIME <valor_em_segundos>
```


### Observações

- O script deve ser executado com privilégios de administrador para que possa simular o movimento do mouse.
- O script não funciona em sessões de Área de Trabalho Remota.
- O script não funciona quando a tela do computador está desligada.

## Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
