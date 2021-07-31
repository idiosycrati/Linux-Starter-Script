#!/bin/bash

declare -a c;


ins=("Utilities" "VSCode" "Atom" "Discord")

printf "Choose installers: e.g. 1,2,3,4\n";

a=1;
for i in "${ins[@]}"
do

	printf "| [$a]${i} ";
    a=$((a+1));
done

printf "| \n";

read  j;

read -p "Enter Password: (leave it blank if not applicable, wrong password will cause the script to stop) " -s p 


t="";


for (( i=0; i<${#j}; i++ )); do
if [ ${j:$i:1} != "," ]  
then
    t+=${j:$i:1}
    if [ $i = $((${#j}-1)) ]  
    then
    c+=("$t");
    fi
elif [ ${j:$i:1} = "," ] && [ ! -z $t ]
then
    c+=("$t");
    t="";
 fi
done
 


for i in "${c[@]}"; do 


# Update
        echo "\nUpdating..."
        echo $p | sudo -kS apt update -yy;
        echo $p | sudo -kS apt install gdebi-core wget -yy;

        if [ $i = "1" ]  
        then
            echo "\nINSTALLING UTILITIES...\n";
            echo $p | sudo -kS install glances -yy ;
            echo $p | sudo -kS apt install psensor -yy ; 
            echo $p | sudo -kS apt install tilda -yy;
            echo $p | sudo -kS apt install terminator -yy;
            echo $p | sudo -kS apt install dconf-editor -yy;
            echo $p | sudo -kS apt install gnome-tweak-tool -yy;
            echo $p | sudo -kS apt install alacarte -yy;
            echo $p | sudo -kS apt install curl -yy;
            

        elif [ $i = "2" ]
        then

            cd;
            mkdir installers;
            cd installers;

            echo "\nINSTALLING VSCode...\n";

            wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg;
            echo $p | sudo -kS install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/;
            echo $p | sudo -kS sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list';
            rm -f packages.microsoft.gpg;

            echo $p | sudo -kS apt install apt-transport-https;
            echo $p | sudo -kS apt update;
            echo $p | sudo -kS apt install code;

        
        elif [ $i = "3" ]
        then

            echo "\nINSTALLING Atom...\n";

            wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -;
            echo $p | sudo -kS sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list';
            echo $p | sudo -kS apt update;
            echo $p | sudo -kS apt install atom;

        elif [ $i = "4" ]
        then

            echo "\nINSTALLING Discord...\n";

            wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb";
          


        elif [ $i = "5" ]
        then
            echo "\nINSTALLING Postman...\n";
            
            wget -O ~/postman.tar.gz "https://dl.pstmn.io/download/latest/linux64";       
            echo $p | sudo -kS dpkg -i *.deb;

        
        elif [ $i = "6" ]
        then

            echo "\nINSTALLING Chrome...\n";

            echo $p | sudo -kS dpkg -i *.deb;
            wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;


        cd;
        rm -r installers;


        fi

done

