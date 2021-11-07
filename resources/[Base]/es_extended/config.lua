Config                      = {}
Config.Locale               = 'en'

Config.Accounts             = { 'bank', 'black_money' }
Config.AccountLabels        = { bank = _U('bank'), black_money = _U('black_money') }

Config.EnableSocietyPayouts = true -- pagar o salario do jogador com dinheiro da sociedade? Requerimento: esx_society
Config.ShowDotAbovePlayer   = false
Config.DisableWantedLevel   = true
Config.EnableHud            = false -- ativar o hud padrão? Exibir trabalho e contas atuais (dinheiro sujo, banco e dinheiro)

Config.PaycheckInterval     = 7 * 60000
Config.MaxPlayers           = GetConvarInt('sv_maxclients', 255) -- defina este valor para 255 se estiver executando o OneSync

Config.EnableDebug          = false
