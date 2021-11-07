# es_extended
es_extended é uma estrutura de roleplay para o FiveM. É desenvolvido em cima de [EssentialMode](https://essentialmode.com/) (também conhecido como ES), assim comumente chamado ESX - o **Es**sentialMode **E**xtended framework para FiveM.

### Links e Leia mais
- [Comunidade oficial do discord](https://discord.gg/8zGbh3T)
- [Documentação ESX](https://esx-brasil.github.io/) (incomplete)
- [Documentação ES](https://docs.essentialmode.com/)
- [Referência Nativa FiveM](https://runtime.fivem.net/doc/reference.html)

### Pré-visualização da captura de tela (todo)

![screenshot](http://i.imgur.com/aPFdJl3.jpg)

### Características
- Contas (banco / dinheiro sujo) você também pode adicionar outras contas
- Sistema de inventário avançado (pressione `F2` no jogo)
- sistema de trabalho
- Loadouts e posição sincronizados no banco de dados
- O melhor framework para servidores RP
- sistema i18n (locale)
- Muitos plugins disponíveis

### Requisitos
Essa ordem também se aplica na ordem de inicialização.
- Base events
- [mysql-async](https://github.com/brouznouf/fivem-mysql-async/releases/latest)
- [EssentialMode](https://essentialmode.com/) (es_admin2 included, a basic admin tool)
- [esplugin_mysql](https://forum.fivem.net/t/release-essentialmode-base/3665/1181)
- [async](https://github.com/ESX-Brasil/async/releases/latest)

### Download e Instalação

### Usando [fvm](https://github.com/qlaffont/fvm-installer)
```
fvm install --save --folder=essential esx-brasil/es_extended
fvm install --save --folder=esx esx-brasil/esx_menu_default
fvm install --save --folder=esx esx-brasil/esx_menu_dialog
fvm install --save --folder=esx esx-brasil/esx_menu_list
```

### Usando Git

```
cd resources
git clone https://github.com/ESX-Brasil/es_extended [essential]/es_extended
git clone https://github.com/ESX-Brasil/esx_menu_default [esx]/[ui]/esx_menu_default
git clone https://github.com/ESX-Brasil/esx_menu_dialog [esx]/[ui]/esx_menu_dialog
git clone https://github.com/ESX-Brasil/esx_menu_list [esx]/[ui]/esx_menu_list
```

### Manualmente
- Download https://github.com/ESX-Brasil/es_extended/releases/latest
- Coloque-o no diretório `resource/[essential]`
- Download https://github.com/ESX-Brasil/esx_menu_default/releases/latest
- Coloque-o no diretório `resource/[esx]/[ui]`
- Download https://github.com/ESX-Brasil/esx_menu_dialog/releases/latest
- Coloque-o no diretório `resource/[esx]/[ui]`
- Download https://github.com/ESX-Brasil/esx_menu_list/releases/latest
- Coloque-o no diretório `resource/[esx]/[ui]`

## Instalação
- Importar `es_extended.sql` para seu banco de dados
- Configure seu `server.cfg` para se parecer com isso

```
start baseevents

start mysql-async
start essentialmode
start esplugin_mysql
start es_admin2

start es_extended

start esx_menu_default
start esx_menu_list
start esx_menu_dialog
```

# Discord

[![Join ESX Brasil](https://discordapp.com/api/guilds/432980396070666250/embed.png?style=banner2)](https://discord.gg/8zGbh3T)


# Legal
### License
es_extended - EssentialMode Extended framework for FiveM

Copyright (C) 2015-2018 ESX-Brasil

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
