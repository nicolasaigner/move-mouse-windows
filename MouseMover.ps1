[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)] # Parametro opcional que define o tempo de inatividade em segundos
    [int]$IDLETIME = 3
)
Add-Type -AssemblyName System.Windows.Forms


$VerbosePreference = "SilentlyContinue" # Define a preferência de saida verbose como SilentlyContinue

if ($PSBoundParameters.ContainsKey('Debug')) {
    $VerbosePreference = "Continue" # Se o parametro Debug estiver definido, define a preferência de saida verbose como Continue
}

# Script está sendo executado a partir do arquivo .ps1
$LogPath = Join-Path $pwd "MouseMover_$((Get-Date).ToString('yyyyMMdd_HHmmss')).log"
# Cria o arquivo de log se não existir
if (!(Test-Path $LogPath)) {
  New-Item -ItemType File -Path $LogPath | Out-Null
}

# Define um tamanho de buffer para a saída de log
$bufferSize = 1MB

# Abre o arquivo de log para escrita
$logFile = [System.IO.StreamWriter]::new($LogPath, $true, [System.Text.Encoding]::UTF8, $bufferSize)



# Define a configuracao de verbose para mostrar mais informacoes no console.
$VerbosePreference = "Continue"

# Adiciona as declaracoes de tipos necessarias para a interacao com o Windows API.
Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public static class User32 {
        [DllImport("user32.dll")]
        public static extern bool GetCursorPos(out POINT lpPoint);
    }
    public struct POINT {
        public int X;
        public int Y;
    }
"@

# Define um tamanho de movimento inicial aleatorio entre 1 e 200 pixels.
$MOVEMENTSIZE = Get-Random -Minimum 1 -Maximum 200

# Mostra uma mensagem de log para indicar que o script foi iniciado e com qual tempo de ociosidade e tamanho de movimento.
Write-Verbose "Iniciando script para movimentar o mouse a cada $IDLETIME segundos com tamanho de movimento aleatorio inicial de $MOVEMENTSIZE pixels."
# Escreve a mensagem de log no arquivo
$logFile.WriteLine("$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss')): Iniciando script para movimentar o mouse a cada $IDLETIME segundos com tamanho de movimento aleatorio inicial de $MOVEMENTSIZE pixels.")
$logFile.Flush()
# Aguarda o tempo de ociosidade antes de iniciar a movimentacao do mouse.
Start-Sleep -Seconds $IDLETIME

# Define as coordenadas X e Y iniciais como zero.
$point_x = 0
$point_y = 0

# Loop infinito que sera executado enquanto o script estiver rodando.
while ($true) {

  # Obtem a posicao atual do cursor do mouse.
  $point = New-Object POINT
  [void][User32]::GetCursorPos([ref]$point)

  # Armazena as coordenadas X e Y atuais do mouse.
  $point_x = $point.X
  $point_y = $point.Y

  # Define um tamanho de movimento aleatorio para cada loop do script.
  # Se o tamanho de movimento for maior que 100, o movimento sera para frente (soma).
  if ($MOVEMENTSIZE -gt 100) {
    $MOVEMENTSIZE = Get-Random -Minimum 100 -Maximum 200
    $newLocalX = $point_x + $MOVEMENTSIZE
    $newLocalY = $point_y + $MOVEMENTSIZE
  # Se o tamanho de movimento for menor ou igual a 100, o movimento sera para tras (subtracao).
  } else {
    $MOVEMENTSIZE = Get-Random -Minimum 1 -Maximum 100
    $newLocalX = $point_x - $MOVEMENTSIZE
    $newLocalY = $point_y - $MOVEMENTSIZE
  }

  # Mostra o tamanho de movimento aleatorio gerado para cada loop do script.
  # Write-Verbose "Movement Size: $MOVEMENTSIZE"

  # Se o mouse estiver parado ha mais de $IDLETIME segundos e ainda estiver na mesma posicao que estava na ultima verificacao.
  if (($idleTime / 1000) -ge $IDLETIME && $point.X -eq $point_x && $point.Y -eq $point_y) {
    # Verifica se o mouse esta parado ha mais de $IDLETIME segundos e ainda esta na mesma posicao
    Write-Verbose "Mouse inativo em X: $point_x Y: $point_y por $IDLETIME segundos, movendo o mouse. X: $newLocalX Y: $newLocalY"
    $logFile.WriteLine("$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss')): Mouse inativo em X: $point_x Y: $point_y por $IDLETIME segundos, movendo o mouse. X: $newLocalX Y: $newLocalY")
    $logFile.Flush()
    # Escreve uma mensagem de verbose indicando que o mouse esta inativo e que o movimento esta sendo realizado
    $newX = [Math]::Min([Math]::Max(0, $newLocalX), [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width)
    $newY = [Math]::Min([Math]::Max(0, $newLocalY), [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height)
    # Define a nova posicao do mouse, certificando-se de que esteja dentro dos limites da tela
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($newX, $newY)
    # Move o cursor para a nova posicao
    Start-Sleep -Seconds $IDLETIME
    # Aguarda por mais $IDLETIME segundos antes de fazer a proxima verificacao
  } else {
    $IDLETIME = $IDLETIME
    Write-Verbose "Mouse ativo em X = $($point.X), Y = $($point.Y), aguardando $IDLETIME segundos."
    $logFile.WriteLine("$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss')): Mouse ativo em X = $($point.X), Y = $($point.Y), aguardando $IDLETIME segundos.")
    $logFile.Flush()
    # Escreve uma mensagem de verbose indicando que o mouse esta ativo e aguardando a proxima verificacao
    Start-Sleep -Seconds $IDLETIME
    # Aguarda por mais $IDLETIME segundos antes de fazer a proxima verificacao
  }
}
  