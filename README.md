# MouseMover

O MouseMover é um script PowerShell que simula um movimento minimo do mouse quando o mesmo fica ocioso por um determinado tempo. Isso evita que o computador entre em modo de espera ou hibernacao.

## Como usar

### Passo 1: Download

Baixe o script [MouseMover.ps1](https://github.com/nicolasaigner/move-mouse-windows) em seu computador.

### Passo 2: Executar

Abra o PowerShell e navegue até o local onde o script foi baixado. Execute o script com o comando:

```powershell	
.\MouseMover.ps1
```

## Rodar na inicializacao do Windows

Para executar o script na inicializacao do Windows, siga os seguintes passos:

1. Pressione as teclas Win + R para abrir o comando Executar
2. Digite shell:startup e pressione Enter
3. Crie um atalho para o arquivo MouseMover.ps1 na pasta que foi aberta
4. Clique com o botão direito do mouse sobre o atalho criado e selecione Propriedades
5. Na janela de propriedades, adicione o argumento -WindowStyle Hidden -ExecutionPolicy Bypass -File antes do caminho do script no campo Destino. O campo deve ficar assim:

```
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Caminho\Para\MouseMover.ps1"
```
Lembre-se de substituir "C:\Caminho\Para\MouseMover.ps1" pelo caminho onde o arquivo MouseMover.ps1 esta localizado em seu computador.

Marque a opcao "Executar como administrador".
Clique em OK para salvar as alterações.
O atalho sera executado como administrador na proxima inicializacao do Windows.
### Parametros

O script aceita os seguintes parametros:

- **IDLETIME:** tempo em segundos para que o mouse seja considerado ocioso (padrão: 3).
- **Debug:** habilita o modo de depuracao do PowerShell.

Para definir um valor diferente para o parametro IDLETIME, utilize o comando:

```powershell	
.\MouseMover.ps1 -IDLETIME <valor_em_segundos>
```


### Observações

- O script deve ser executado com privilégios de administrador para que possa simular o movimento do mouse.
- O script não funciona em sessões de area de Trabalho Remota.
- O script não funciona quando a tela do computador esta desligada.
- Certifique-se de que o PowerShell está configurado para permitir a execução de scripts. Se você não puder executar o script devido a restrições de segurança, poderá alterar temporariamente a política de execução do PowerShell usando o comando Set-ExecutionPolicy RemoteSigned. Isso permitirá a execução de scripts localmente, mas pode apresentar riscos de segurança, portanto, lembre-se de retornar à política anterior após a execução do script.

## Licença

Este projeto esta licenciado sob a licença MIT. Consulte o arquivo [LICENSE](https://github.com/nicolasaigner/move-mouse-windows/blob/main/license) para mais detalhes.
