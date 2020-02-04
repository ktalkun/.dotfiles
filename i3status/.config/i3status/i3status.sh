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
