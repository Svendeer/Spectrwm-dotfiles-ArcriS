#!/bin/bash
# Install my dotfiles for spectrwm

intro(){
	echo " --------------------------------------------------   --------------   --------------------------------------------"
	echo "| ____                  _      __        ____  __  | | ____         | | ____                     _                 |"
	echo "|/ ___| _ __   ___  ___| |_ _ _\ \      / /  \/  | | || __ ) _   _  | |/ ___|_   _____ _ __   __| | ___  ___ _ __  |"
	echo "|\___ \| '_ \ / _ \/ __| __| '__\ \ /\ / /| |\/| | | ||  _ \| | | | | |\___ \ \ / / _ \ '_ \ / _  |/ _ \/ _ \ '__| |"
	echo "| ___) | |_) |  __/ (__| |_| |   \ V  V / | |  | | | || |_) | |_| | | | ___) \ V /  __/ | | | (_| |  __/  __/ |    |"
	echo "||____/| .__/ \___|\___|\__|_|    \_/\_/  |_|  |_| | ||____/ \__, | | ||____/ \_/ \___|_| |_|\__,_|\___|\___|_|    |"
	echo "|      |_|                                         | |       |___/  | |											 |"
	echo " --------------------------------------------------   --------------   --------------------------------------------"

	sleep 2
}

installRequeriments(){
	echo "Instalando requerimentos previos..."
	sleep 1

	sudo pacman -S spectrwm xlockmore xterm pamixer light pcmanfm scrot rofi alacritty w3m feh --needed
}

setConfigs(){

    echo "Aplicando configuraciones iniciales para el gestor de ventanas."
    echo "Lea el fichero '.spectrwm.conf' para poner atajos, comandos y programas personalizados."
    echo "Revisa el fichero 'manual-explicativo.txt' para una explicacioón al respecto."
    sleep 1

	cp -v .spectrwm.conf $HOME
	cp -v .spectrwm_es.conf $HOME
	cp -v Baraction.sh $HOME/.config
    cp manual-explicativo.txt $HOME
}

setBashrc(){
    echo "Ahora, vamos a aplicar el tema del prompt bash."
    echo "Dicho tema, requiere de las fuentes Hack Nerd Font, las cuales se instalarán despues."
    sleep 1

    cp -v .bashrc $HOME/.bashrc
    cp -rv gitstatus $HOME/.gitstatus 
}

setFonts(){
    echo "Instalando fuentes necesarias. Esto requiere acciones de superusuario."
    sleep 1

    sudo cp -v fonts/* /usr/share/fonts
    
}

setTerminals(){
    echo "Aplicaremos las configuraciones de las terminales, en este caso, ST y Alacritty."
    sleep 1

    cp -rv alacritty/alacritty.yml ~/.config/alacritty
    cd st-0.8.4 && make && sudo make clean install
}

setRangerConfig(){
    echo "Config para Ranger, esto necesita tener instalado w3m."
    sleep 1

    cp -rv ranger ~/.config/
}

setVim(){
    echo "Si usas vim, ahí va una ayudita ;)"
    sleep 1

    cp -rv .vimrc $HOME
    cp -v .vim $HOME
}

setArchFetch(){
    echo "Aporte: un pequeño fetch para lucir tu terminal ;)."
    cp -v ArchFetch.sh ~/.config
}

main(){
    echo "$(intro) $(installRequeriments) $(setConfigs) $(setBashrc) $(setFonts) $(setTerminals) $(setRangerConfig) $(setVim) $(setArchFetch)"
}

echo $(main)
