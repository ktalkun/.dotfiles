#!/bin/sh
# shell script to add RAM-usage to i3status
# needs sed, free and bc
## config
# status command has to be this script
## i3status.conf
# showing cpu_usage has to be enabled (because ram_usage is prepended to that with sed...)
# output_format has to be set to "i3bar"

WIRELESS=wlp2s0
ETH=enp3s0

i3status -c $1  | while :
do
	read line
	
	# if [ -e /sys/class/net/$ETH/operstate ] && [ `cat /sys/class/net/$ETH/operstate` == "up" ]; then
	#     ETHR2=`cat /sys/class/net/$ETH/statistics/rx_bytes`
	#     ETHT2=`cat /sys/class/net/$ETH/statistics/tx_bytes`
	#     ETHTBPS=`expr $ETHT2 - $ETHT1`
	#     ETHRBPS=`expr $ETHR2 - $ETHR1`
	#     ETHTKBPS=`expr $ETHTBPS / 1024`
	#     ETHRKBPS=`expr $ETHRBPS / 1024`
	
	#     ETHR1=$ETHR2
	#     ETHT1=$ETHT2
	#     sedeth="s/\(\"name\":\"ethernet\",\"instance\":\"$ETH\".*)\)\(\"}\)/\1 D $ETHRKBPS U $ETHTKBPS\2/"
	#     line=`echo $line | sed -e "$sedeth"`
	# fi
	
	# if [ -e /sys/class/net/$WIRELESS/operstate ] && [ `cat /sys/class/net/$WIRELESS/operstate` == "up" ]; then
	#     WLANR2=`cat /sys/class/net/$WIRELESS/statistics/rx_bytes`
	#     WLANT2=`cat /sys/class/net/$WIRELESS/statistics/tx_bytes`
	#     WLANTBPS=`expr $WLANT2 - $WLANT1`
	#     WLANRBPS=`expr $WLANR2 - $WLANR1`
	#     WLANTKBPS=`expr $WLANTBPS / 1024`
	#     WLANRKBPS=`expr $WLANRBPS / 1024`
	
	#     WLANR1=$WLANR2
	#     WLANT1=$WLANT2
	#     sedwlan="s/\(\"name\":\"wireless\",\"instance\":\"$WIRELESS\".*)\)\(\"}\)/\1 D $WLANRKBPS U $WLANTKBPS\2/"
	#     line=`echo $line | sed -e "$sedwlan"`
	# fi
	
#	 ______        ___    ____  
#	/ ___\ \      / / \  |  _ \ 
#	\___ \\ \ /\ / / _ \ | |_) |
#	 ___) |\ V  V / ___ \|  __/ 
#	|____/  \_/\_/_/   \_\_|    
#	                            

#	swap=`free -kh | grep Swap | awk '{print $3}'`
#	swap_module_name="swap_usage"
#	swap_before="cpu_usage"
#	swap_markup="\"markup\":\"pango\""
#	swap_full_text="\"full_text\":\"<span background="\'\#59c1ce\'"> SWAP: ${swap} <\/span>\""
#	swap_separator="\"separator\":false"
#	sedline="s/\"${swap_before}\"/\"${swap_module_name}\",${swap_markup},${swap_full_text},${swap_separator}},{\"name\":\"${swap_before}\"/"
#	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`

#	__        _____ _   _ ____ ___ _   _ ____
#	\ \      / /_ _| \ | | __ )_ _| \ | |  _ \
#	 \ \ /\ / / | ||  \| |  _ \| ||  \| | | | |
#	  \ V  V /  | || |\  | |_) | || |\  | |_| |
#	   \_/\_/  |___|_| \_|____/___|_| \_|____/
#	
	winbind=`systemctl status winbind.service | grep "Active" | awk -F" " '{ print $2}'`
	winbind_color="#dddddd"
	if [ "$winbind" = "inactive" ] || [ "$winbind" = "deactivating" ]; then winbind_color="#f59335"; fi
	winbind_module_name="winbind_status"
	winbind_before="disk_info"
	winbind_markup="\"markup\":\"pango\""
	winbind_full_text="\"full_text\":\"<span background="\'$winbind_color\'"> W <\/span>\""
	winbind_separator="\"separator\":false"
	sedline="s/\"${winbind_before}\"/\"${winbind_module_name}\",${winbind_markup},${winbind_full_text},${winbind_separator}},{\"name\":\"${winbind_before}\"/"
	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`



#	__        ______   _
#	\ \      / /  _ \ / \
#	 \ \ /\ / /| |_) / _ \
#	  \ V  V / |  __/ ___ \
#	   \_/\_/  |_| /_/   \_\
#	
#	 ____  _   _ ____  ____  _     ___ ____    _    _   _ _____
#	/ ___|| | | |  _ \|  _ \| |   |_ _/ ___|  / \  | \ | |_   _|
#	\___ \| | | | |_) | |_) | |    | | |     / _ \ |  \| | | |
#	 ___) | |_| |  __/|  __/| |___ | | |___ / ___ \| |\  | | |
#	|____/ \___/|_|   |_|   |_____|___\____/_/   \_\_| \_| |_|
#
	wpa_supplicant=`systemctl status wpa_supplicant.service | grep "Active" | awk -F" " '{ print $2}'`
	wpa_supplicant_color="#dddddd"
	if [ "$wpa_supplicant" = "inactive" ] || [ "$wpa_supplicant" = "deactivating" ]; then wpa_supplicant_color="#f59335"; fi
	wpa_supplicant_module_name="wpa_supplicant_status"
	wpa_supplicant_before="disk_info"
	wpa_supplicant_markup="\"markup\":\"pango\""
	wpa_supplicant_full_text="\"full_text\":\"<span background="\'$wpa_supplicant_color\'"> W <\/span>\""
	wpa_supplicant_separator="\"separator\":false"
	sedline="s/\"${wpa_supplicant_before}\"/\"${wpa_supplicant_module_name}\",${wpa_supplicant_markup},${wpa_supplicant_full_text},${wpa_supplicant_separator}},{\"name\":\"${wpa_supplicant_before}\"/"
	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`


#	 _   _ _____ _______        _____  ____  _  __
#	| \ | | ____|_   _\ \      / / _ \|  _ \| |/ /
#	|  \| |  _|   | |  \ \ /\ / / | | | |_) | ' /
#	| |\  | |___  | |   \ V  V /| |_| |  _ <| . \
#	|_| \_|_____| |_|    \_/\_/  \___/|_| \_\_|\_\
#	
#	 __  __    _    _   _    _    ____ _____ ____
#	|  \/  |  / \  | \ | |  / \  / ___| ____|  _ \
#	| |\/| | / _ \ |  \| | / _ \| |  _|  _| | |_) |
#	| |  | |/ ___ \| |\  |/ ___ \ |_| | |___|  _ <
#	|_|  |_/_/   \_\_| \_/_/   \_\____|_____|_| \_\
#	
	network_manager=`systemctl status NetworkManager.service | grep "Active" | awk -F" " '{ print $2}'`
	network_manager_color="#dddddd"
	if [ "$network_manager" = "inactive" ] || [ "$network_manager" = "deactivating" ]; then network_manager_color="#f59335"; fi
	network_manager_module_name="network_manager_status"
	network_manager_before="disk_info"
	network_manager_markup="\"markup\":\"pango\""
	network_manager_full_text="\"full_text\":\"<span background="\'$network_manager_color\'"> N <\/span>\""
	network_manager_separator="\"separator\":false"
	sedline="s/\"${network_manager_before}\"/\"${network_manager_module_name}\",${network_manager_markup},${network_manager_full_text},${network_manager_separator}},{\"name\":\"${network_manager_before}\"/"
	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`


#	 ____  _   _    _    ____  ____
#	/ ___|| \ | |  / \  |  _ \|  _ \
#	\___ \|  \| | / _ \ | |_) | | | |
#	 ___) | |\  |/ ___ \|  __/| |_| |
#	|____/|_| \_/_/   \_\_|   |____/
#	
	snapd=`systemctl status snapd.service | grep "Active" | awk -F" " '{ print $2}'`
	snapd_color="#dddddd"
	if [ "$snapd" = "inactive" ] || [ "$snapd" = "deactivating" ]; then snapd_color="#f59335"; fi
	snapd_module_name="snapd_status"
	snapd_before="disk_info"
	snapd_markup="\"markup\":\"pango\""
	snapd_full_text="\"full_text\":\"<span background="\'$snapd_color\'"> S <\/span>\""
	snapd_separator="\"separator\":false"
	sedline="s/\"${snapd_before}\"/\"${snapd_module_name}\",${snapd_markup},${snapd_full_text},${snapd_separator}},{\"name\":\"${snapd_before}\"/"
	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`

#	 ____   ___   ____ _  _______ ____
#	|  _ \ / _ \ / ___| |/ / ____|  _ \
#	| | | | | | | |   | ' /|  _| | |_) |
#	| |_| | |_| | |___| . \| |___|  _ <
#	|____/ \___/ \____|_|\_\_____|_| \_\
#	
	docker=`systemctl status docker.service | grep "Active" | awk -F" " '{ print $2}'`
	docker_color="#dddddd"
	if [ "$docker" = "inactive" ] || [ "$docker" = "deactivating" ]; then docker_color="#f59335"; fi
	docker_module_name="docker_status"
	docker_before="disk_info"
	docker_markup="\"markup\":\"pango\""
	docker_full_text="\"full_text\":\"<span background="\'$docker_color\'"> D <\/span>\""
	docker_separator="\"separator\":false"
	sedline="s/\"${docker_before}\"/\"${docker_module_name}\",${docker_markup},${docker_full_text},${docker_separator}},{\"name\":\"${docker_before}\"/"
	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`

	
#	 ____      _    __  __ 
#	|  _ \    / \  |  \/  |
#	| |_) |  / _ \ | |\/| |
#	|  _ <  / ___ \| |  | |
#	|_| \_\/_/   \_\_|  |_|
#	                      

	# Имя модуля, перед которым нужно вставлять
	ram=`free -kh | grep Mem | awk '{print $3}'`
	ram_module_name="ram_usage"
	ram_before="cpu_usage"
	ram_markup="\"markup\":\"pango\""
	ram_full_text="\"full_text\":\"<span background="\'\#59c1ce\'">  ${ram} <\/span>\""
	ram_separator="\"separator\":false"
	sedline="s/\"${ram_before}\"/\"${ram_module_name}\",${ram_markup},${ram_full_text},${ram_separator}},{\"name\":\"${ram_before}\"/"
	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`
	
#	 ____  ____  ___ ____ _   _ _____ _   _ _____ ____ ____  
#	| __ )|  _ \|_ _/ ___| | | |_   _| \ | | ____/ ___/ ___| 
#	|  _ \| |_) || | |  _| |_| | | | |  \| |  _| \___ \___ \ 
#	| |_) |  _ < | | |_| |  _  | | | | |\  | |___ ___) |__) |
#	|____/|_| \_\___\____|_| |_| |_| |_| \_|_____|____/____/ 
#	                                                         

	brightness=`xbacklight | sed "s/\..*/%/"`
	brightness_module_name="brightness"
	brightness_before="volume"
	brightness_markup="\"markup\":\"pango\""
	brightness_full_text="\"full_text\":\"<span background="\'\#ebcb8b\'">  ${brightness} <\/span>\""
	brightness_separator="\"separator\":false"
	sedline="s/\"${brightness_before}\"/\"${brightness_module_name}\",${brightness_markup},${brightness_full_text},${brightness_separator}},{\"name\":\"${brightness_before}\"/"
	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`

#	 ____   ___  _   _ _   _ ____     ____    _    ____ _____ _   _ ____  _____ 
#	/ ___| / _ \| | | | \ | |  _ \   / ___|  / \  |  _ \_   _| | | |  _ \| ____|
#	\___ \| | | | | | |  \| | | | | | |     / _ \ | |_) || | | | | | |_) |  _|  
#	 ___) | |_| | |_| | |\  | |_| | | |___ / ___ \|  __/ | | | |_| |  _ <| |___ 
#	|____/ \___/ \___/|_| \_|____/   \____/_/   \_\_|    |_|  \___/|_| \_\_____|
#	                                                                            
	
	sound_capture=" `amixer get Capture | tail -n 1 | awk '{print $5}' | sed "s/\[//"| sed "s/\]//"`"
	sound_capture_state=`amixer get Capture | tail -n 1 | awk '{print $6}' | sed "s/\[//"| sed "s/\]//"`
	sound_on_color="\#ebcb8b"
	sound_off_color="\#f59335"
	sound_color=${sound_on_color}
	if [ "$sound_capture_state" = "off" ]; then
	        sound_capture=""
		sound_color=${sound_off_color}
	fi
	sound_capture_module_name="sound_capture"
	sound_capture_before="volume"
	sound_capture_markup="\"markup\":\"pango\""
	sound_capture_full_text="\"full_text\":\"<span background="\'${sound_color}\'"> ${sound_capture} <\/span>\""
	sound_capture_separator="\"separator\":false"
	sedline="s/\"${sound_capture_before}\"/\"${sound_capture_module_name}\",${sound_capture_markup},${sound_capture_full_text},${sound_capture_separator}},{\"name\":\"${sound_capture_before}\"/"
	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`
	
#	 _   _ ____ _____ ___ __  __ _____ 
#	| | | |  _ \_   _|_ _|  \/  | ____|
#	| | | | |_) || |  | || |\/| |  _|  
#	| |_| |  __/ | |  | || |  | | |___ 
#	 \___/|_|    |_| |___|_|  |_|_____|
#	                                   
	
#	uptime=`uptime | awk '{print $3 " " $4}' | sed 's/,//'`
#	uptime_module_name="uptime"
#	uptime_before="battery"
#	uptime_markup="\"markup\":\"pango\""
#	uptime_full_text="\"full_text\":\"<span background="\'\#2d567c\'"> UPTIME: ${uptime} <\/span>\""
#	uptime_separator="\"separator\":false"
#	sedline="s/\"${uptime_before}\"/\"${uptime_module_name}\",${uptime_markup},${uptime_full_text},${uptime_separator}},{\"name\":\"${uptime_before}\"/"
#	line=`echo $line | sed -e "$sedline" | sed -e "s/% \"/%\"/"`
	
	




	#remove colons
	colonline='s/\([a-zA-Z]\):/\1/g'
	final=`echo $line | sed -e "$colonline"`
	
	echo "$final" || exit 1
done
