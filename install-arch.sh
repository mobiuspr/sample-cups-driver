#!/bin/sh
sudo pacman -Syu nodejs npm cups git
sudo git clone https://github.com/mobiuspr/node-sdk.git /usr/lib/Mobius
curl -L https://raw.githubusercontent.com/mobiuspr/sample-cups-driver/refs/heads/main/mobius > mobius-executable.js
sudo cp ./mobius-executable.js /usr/lib/cups/backend/mobius
rm mobius-executable.js
sudo chmod 755 /usr/lib/cups/backend/mobius
sudo chown root:root /usr/lib/cups/backend/mobius

askYesNo() {
    while true; do
        read -p "$1 [Y/n]: " ynresp
        case $ynresp in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "";;
        esac
    done
}

# function askForLogin() {
#    read -p "Enter your email address: " emailadr
#    echo "$emailadr" > "LOGIN_TMP.txt"
#    sudo cp LOGIN_TMP.txt /usr/lib/Mobius/email.txt
#    rm LOGIN_TMP.txt
#    read -p "Enter your password: " password
#    echo "$password" > "LOGIN_TMP.txt"
#    sudo cp LOGIN_TMP.txt /usr/lib/Mobius/password.txt
#    rm LOGIN_TMP.txt
#}

if askYesNo "Do you want to add your username and password now?"; then
    read -p "You'll have to edit the source manually. Press enter to edit (in nano): "
    sudo pacman -S nano
    nano /usr/lib/cups/backend/mobius
    if askYesNo "We installed nano to allow you to add your login information, do you want to uninstall it?"; then
        sudo pacman -R nano --noconfirm
    fi
else
    echo "You can always manually edit /usr/lib/cups/backend/mobius to add login info with your editor of choice."
fi

if askYesNo "We installed git to download Mobius, do you want to uninstall it?"; then
    sudo pacman -R git --noconfirm
fi

if askYesNo "Do you want to restart your computer now?"; then
    sudo shutdown -r now
else
    echo "Successfully installed Mobius!"
fi
