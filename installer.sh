#!/bin/bash
# Install my dotfiles for spectrwm

intro(){
	echo " ----------------------------------------------------------------------------------------------------------------"
	echo "| ____                  _      __        ____  __    ____           ____                     _                  |"
	echo "|/ ___| _ __   ___  ___| |_ _ _\ \      / /  \/  |  | __ ) _   _   / ___|_   _____ _ __   __| | ___  ___ _ __   |"
	echo "|\___ \| '_ \ / _ \/ __| __| '__\ \ /\ / /| |\/| |  |  _ \| | | |  \___ \ \ / / _ \ '_ \ / _  |/ _ \/ _ \ '__|  |"
	echo "| ___) | |_) |  __/ (__| |_| |   \ V  V / | |  | |  | |_) | |_| |   ___) \ V /  __/ | | | (_| |  __/  __/ |   _ |"
	echo "||____/| .__/ \___|\___|\__|_|    \_/\_/  |_|  |_|  |____/ \__, |  |____/ \_/ \___|_| |_|\__,_|\___|\___|_|  (_)|"
	echo "|      |_|                                                 |___/   											  |"
	echo " ----------------------------------------------------------------------------------------------------------------"

	sleep 2
}

installWindowManager(){
	echo "Instalando requerimentos previos..."
	sleep 2

	sudo pacman -S spectrwm xlockmore xterm pamixer light pcmanfm scrot rofi alacritty w3m feh git --needed --noconfirm
}

setConfigs(){

    echo "Aplicando configuraciones iniciales para el gestor de ventanas."
    echo "Lea el fichero '.spectrwm.conf' para poner atajos, comandos y programas personalizados."
    echo "Revisa el fichero 'manual-explicativo.txt' para una explicacioón al respecto."
    sleep 2
    
	cp -v .spectrwm.conf $HOME
	cp -v .spectrwm_es.conf $HOME
	cp -v Baraction.sh $HOME/.config
    cp manual-explicativo-spectrwm.txt $HOME
}

setFonts(){
    echo "Instalando fuentes necesarias. Esto requiere acciones de superusuario."
    sleep 2
    sudo cp -v fonts/* /usr/share/fonts
    
}

setTerminals(){
    echo "Aplicaremos las configuraciones de las terminales, en este caso, ST y Alacritty."
    sleep 2
    cp -rv alacritty/alacritty.yml ~/.config/alacritty
    cd st-0.8.4 && make && sudo make clean install
}

setRangerConfig(){
    echo "Config para Ranger, esto necesita tener instalado w3m."
    sleep 2
    cp -rv ranger ~/.config/
}

setVim(){
    echo "Si usas vim, ahí va una ayudita ;)"
    sleep 2
    cp -rv .vimrc $HOME
    cp -v .vim $HOME
}

installProgramsAdittionals(){
    echo "Instalaremos programas adicionales: "
    sudo pacman -S telegram-desktop zsh papirus-icon-theme alsa-utils ueberzug ttf-dejavu firefox neofetch lightdm lightdm-gtk-greeter --needed --noconfirm
    sudo systemctl enable lightdm.service
    sleep 2
}

finalMessage(){
    clear && neofetch
    sleep 3
    echo "Enhorabuena, has finalizado la instalación y configuración de SpectrWM. ¡Bienvenido a Arch Linux!"
    sleep 3
    echo "Reiniciando..."
    reboot
}

main(){
    echo "$(intro) $(installWindowManager) $(setConfigs) $(setFonts) $(setTerminals) $(setRangerConfig) $(setVim) $(installProgramsAdittionals) $(finalMessage)"
}

echo $(main)
