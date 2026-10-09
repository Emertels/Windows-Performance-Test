@echo off
setlocal DisableDelayedExpansion
rem Keep the assessment in this console; WinSAT itself is started hidden below.
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$file='%~f0';$lines=[IO.File]::ReadAllLines($file);$marker=[Array]::IndexOf($lines,'#PS_PAYLOAD');if($marker -lt 0){exit 3};$payload=$lines[($marker+1)..($lines.Length-1)] -join [Environment]::NewLine;& ([scriptblock]::Create($payload))"
set "RESULT=%ERRORLEVEL%"
exit /b %RESULT%
#PS_PAYLOAD
$ErrorActionPreference='Stop'
$culture=[Globalization.CultureInfo]::CurrentUICulture.Name
$lang=switch -Regex ($culture) {
    '^pt' {'pt-BR';break} '^es' {'es';break} '^fr' {'fr';break} '^de' {'de';break}
    '^it' {'it';break} '^ja' {'ja';break} '^ko' {'ko';break}
    '^zh-(TW|HK|MO)' {'pt-BR';break} '^(zh|cmn)' {'zh-CN';break}
    '^ru' {'ru';break} default {'pt-BR'}
}
$text=@{
    'pt-BR'=@('AVALIAÇÃO DE DESEMPENHO DO WINDOWS','Sessão iniciada','Idioma detectado','Iniciando a avaliação. A tela pode piscar e o processo pode levar alguns minutos.','Falha ao executar o WinSAT','CPU','Memória','Gráficos da área de trabalho','Gráficos 3D/jogos','Disco principal','Pontuação base','Não foi possível ler as pontuações. Execute no Windows com suporte ao WinSAT.','Pressione Enter para fechar.')
    en=@('WINDOWS PERFORMANCE ASSESSMENT','Session started','Detected language','Starting the assessment. The display may flicker and the process can take a few minutes.','WinSAT failed to run','CPU','Memory','Desktop graphics','3D/gaming graphics','Primary disk','Base score','Could not read scores. Run on a Windows version that supports WinSAT.','Press Enter to close.')
    es=@('EVALUACIÓN DEL RENDIMIENTO DE WINDOWS','Sesión iniciada','Idioma detectado','Iniciando la evaluación. La pantalla puede parpadear y tardar unos minutos.','Error al ejecutar WinSAT','CPU','Memoria','Gráficos de escritorio','Gráficos 3D/juegos','Disco principal','Puntuación base','No se pudieron leer las puntuaciones. Ejecute en una versión de Windows compatible con WinSAT.','Pulse Enter para cerrar.')
    fr=@('ÉVALUATION DES PERFORMANCES DE WINDOWS','Session démarrée','Langue détectée','Démarrage de l''évaluation. L''écran peut clignoter et l''opération prendre quelques minutes.','Échec de WinSAT','Processeur','Mémoire','Graphismes du bureau','Graphismes 3D/jeux','Disque principal','Score de base','Impossible de lire les scores. Exécutez sur une version de Windows compatible avec WinSAT.','Appuyez sur Entrée pour fermer.')
    de=@('WINDOWS-LEISTUNGSBEWERTUNG','Sitzung gestartet','Erkannte Sprache','Bewertung wird gestartet. Der Bildschirm kann flackern; der Vorgang dauert möglicherweise einige Minuten.','WinSAT konnte nicht ausgeführt werden','CPU','Arbeitsspeicher','Desktopgrafik','3D-/Spielegrafik','Systemlaufwerk','Basiswert','Werte konnten nicht gelesen werden. Führen Sie das Programm auf einer WinSAT-kompatiblen Windows-Version aus.','Zum Schließen die Eingabetaste drücken.')
    it=@('VALUTAZIONE PRESTAZIONI DI WINDOWS','Sessione avviata','Lingua rilevata','Avvio della valutazione. Lo schermo potrebbe lampeggiare e l''operazione richiedere alcuni minuti.','Esecuzione di WinSAT non riuscita','CPU','Memoria','Grafica desktop','Grafica 3D/giochi','Disco principale','Punteggio base','Impossibile leggere i punteggi. Esegui su una versione di Windows che supporta WinSAT.','Premi Invio per chiudere.')
    ja=@('Windows パフォーマンス評価','セッション開始','検出された言語','評価を開始します。画面がちらつく場合があり、数分かかることがあります。','WinSAT の実行に失敗しました','CPU','メモリ','デスクトップ グラフィックス','3D/ゲーム グラフィックス','システム ディスク','基本スコア','スコアを読み取れません。WinSAT 対応の Windows で実行してください。','Enter キーを押して閉じます。')
    ko=@('Windows 성능 평가','세션 시작','감지된 언어','평가를 시작합니다. 화면이 깜박일 수 있으며 몇 분 정도 걸릴 수 있습니다.','WinSAT 실행 실패','CPU','메모리','데스크톱 그래픽','3D/게임 그래픽','기본 디스크','기본 점수','점수를 읽을 수 없습니다. WinSAT을 지원하는 Windows에서 실행하세요.','Enter 키를 눌러 닫으세요.')
    'zh-CN'=@('Windows 性能评估','会话开始时间','检测到的语言','正在开始评估。屏幕可能闪烁，过程可能需要几分钟。','WinSAT 运行失败','处理器','内存','桌面图形','3D/游戏图形','主磁盘','基本分数','无法读取分数。请在支持 WinSAT 的 Windows 版本上运行。','按 Enter 关闭。')
    ru=@('ОЦЕНКА ПРОИЗВОДИТЕЛЬНОСТИ WINDOWS','Сеанс начат','Обнаруженный язык','Запуск оценки. Экран может мигать, процесс может занять несколько минут.','Не удалось запустить WinSAT','Процессор','Память','Графика рабочего стола','Графика 3D/игр','Основной диск','Базовая оценка','Не удалось прочитать оценки. Запустите в версии Windows с поддержкой WinSAT.','Нажмите Enter, чтобы закрыть.')
}
$labels=$text[$lang]
$versionLabel=@{'pt-BR'='Versão';en='Version';es='Versión';fr='Version';de='Version';it='Versione';ja='バージョン';ko='버전';'zh-CN'='版本';ru='Версия'}[$lang]
$started=Get-Date
try { [Console]::OutputEncoding=[Text.UTF8Encoding]::new($false) } catch {}
Write-Host $labels[0] -ForegroundColor Cyan
Write-Host ("{0}: 1.0.0" -f $versionLabel)
Write-Host ("{0}: {1}" -f $labels[1],$started.ToString('yyyy-MM-dd HH:mm:ss'))
Write-Host ("{0}: {1} ({2})" -f $labels[2],$lang,$culture)
Write-Host $labels[3] -ForegroundColor Yellow
try {
    $winSatPath=Join-Path $env:windir 'System32\WinSAT.exe'
    if (-not (Test-Path -LiteralPath $winSatPath) -and (Test-Path -LiteralPath (Join-Path $env:windir 'Sysnative\WinSAT.exe'))) {
        $winSatPath=Join-Path $env:windir 'Sysnative\WinSAT.exe'
    }
    if (-not (Test-Path -LiteralPath $winSatPath)) { throw $labels[4] }
    $process=Start-Process -FilePath $winSatPath -ArgumentList 'formal' -WindowStyle Hidden -PassThru -Wait
    if ($process.ExitCode -ne 0) { throw $labels[4] }
    $score=Get-CimInstance Win32_WinSAT -ErrorAction Stop
    if (-not $score) { throw $labels[11] }
    Clear-Host
    Write-Host ('='*48) -ForegroundColor DarkGray
    Write-Host $labels[0] -ForegroundColor Cyan
    Write-Host ("{0}: 1.0.0" -f $versionLabel)
    Write-Host ("{0}: {1}" -f $labels[1],$started.ToString('yyyy-MM-dd HH:mm:ss'))
    Write-Host ("{0}: {1} ({2})" -f $labels[2],$lang,$culture)
    Write-Host ("{0,-25} {1}" -f $labels[5],$score.CPUScore)
    Write-Host ("{0,-25} {1}" -f $labels[6],$score.MemoryScore)
    Write-Host ("{0,-25} {1}" -f $labels[7],$score.GraphicsScore)
    Write-Host ("{0,-25} {1}" -f $labels[8],$score.D3DScore)
    Write-Host ("{0,-25} {1}" -f $labels[9],$score.DiskScore)
    Write-Host ("{0,-25} {1}" -f $labels[10],$score.WinSPRLevel) -ForegroundColor Green
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}
Read-Host $labels[12] | Out-Null
