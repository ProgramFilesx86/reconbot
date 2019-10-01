#!/bin/bash

source ShellBot.sh

ShellBot.init --token $token --monitor --flush --return map
ShellBot.username

#_____ _   _ _   _  ____ ___  _____ ____  
#|  ___| | | | \ | |/ ___/ _ \| ____/ ___| 
#| |_  | | | |  \| | |  | | | |  _| \___ \ 
#|  _| | |_| | |\  | |__| |_| | |___ ___) |
#|_|    \___/|_| \_|\____\___/|_____|____/ 

unset botao

botao='
["/set-targert","/nmap","/inurl"],
["/theharvester","/shodan","/whois"],
["karma","/sherlok","/pwnedornot"],
["/dorks","/admin","/comandos","/show-target"]
'

btn_people='
["/karma","/sherlok","/pwnedornot"]
'
btn_computer='
["/nmap","/inurl","/theharvester"],
["/shodan","/whois"] 
'

btn_target='["People 👨‍💻","Computer 🖥"]'

btn_cleam='
["Cleam Target - People"],
["Cleam Target - Computer"],
["Cleam All","Cleam Args"]
'

keyboard="$(ShellBot.ReplyKeyboardMarkup --button 'botao' --one_time_keyboard true)"
keyboard_computer="$(ShellBot.ReplyKeyboardMarkup --button 'btn_computer' --one_time_keyboard true)"
keyboard_people="$(ShellBot.ReplyKeyboardMarkup --button 'btn_people' --one_time_keyboard true)"

while :
do

    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
    for id in $(ShellBot.ListUpdates)
    do

	(
	[[ ${message_chat_type[$id]} != private ]] && continue
	mkdir /tmp/${message_from_id[$id]}
        target_dir=/tmp/${message_from_id[$id]}/target
        target_dir_p=/tmp/${message_from_id[$id]}/target_people
        target=$(< $target_dir)
	target_p=$(< $target_dir_p)
	arg_nmap_dir=/tmp/${message_from_id[$id]}/nmap-agr
	
	case ${message_text[$id]} in
		'/start')
        	 msg="Salve *$message_from_username* , Bora fazer um recon ?\n"
       	 	 msg+="Da uma olhada nas info em  /comandos."
       		 ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
		 			--text "$(echo -e $msg)"		\
					--parse_mode markdown
		;;

		'/help')
        	 msg="Salve *$message_from_username* , Bora fazer um recon ?\n"
       	 	 msg+="Da uma olhada nas info em  /comandos."
       		 ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
		 			--text "$(echo -e $msg)"		\
					--parse_mode markdown
		;;

		"/nmap "*) 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Target - $message_text Aguarde =)"   
		nmap_result=$(nmap $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$nmap_result"  
		;; 

		'/nmap')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing NMAP - Target $target Aguarde =)"   
		nmap_result=$(nmap $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$nmap_result"  
		;;

		"/theharvester "*) 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Target - $message_text Aguarde =)"   
		theharvester_result=$(theharvester -d $message_text -l 100 -b google)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$theharvester_result"  
		;;

		'/theharvester')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Target - $target Aguarde =)"   
		theharvester_result=$(theharvester -d  $target -l 100 -b google)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$theharvester_result"  
		;;

		"/inurl "*)
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Dork - $message_text Aguarde =)"   
		inurl_result=$(inurl $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$inurl_result"  
		;;

		"/whois "*) 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "WHOIS - $message_text Aguarde =)"   
		whois_result=$(whois $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$whois_result"  
		;;

		'/whois')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing WHOIS- Target $target Aguarde =)"   
		whois_result=$(whois $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$whois_result"  
		;;

		'/shodan')
		shodan init $shodan_key
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing Shodan- $target Aguarde =)"   
		shodan_result=$(shodan host $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$shodan_result"  
		;;

		"/shodan "*)
		shodan init $shodan_key
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing Shodan $message_text Aguarde =)"   
		shodan_result=$(shodan host $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$shodan_result"  
		;;

		'/karma')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing Karma - $target_p Aguarde =)"   
		karma_result=$(karma target $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$karma_result"  
		;;

		"/karma "*)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing Karma - $message_text Aguarde =)"   
		karma_result=$(karma target $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$karma_result"  
		;;

		'/sherlock')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing sherlock - $target_p Aguarde =)"   
		sherlock_result=$(sherlock $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$sherlock_result"  
		;;

		"/sherlock "*)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing sherlock - $message_text Aguarde =)"   
		sherlock_result=$(sherlock $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$sherlock_result"  
		;;

		'/pwnedornot')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing pwnedornot - $target_p Aguarde =)"   
		pwnedornot_result=$(pwnedornot.py -e $target)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$pwnedornot_result"  
		;;

		"/pwnedornot "*)	
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Executing pwnedornot - $message_text Aguarde =)"   
		pwnedornot_result=$(pwnedornot.py -e $message_text)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$pwnedornot_result"  
		;;


		'/dorks')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Lista TOP DORKS"   
		dorks_result=$(cat dorks.list)
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "$dorks_result"  
		;;

		'/comandos')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]}	\
					--text "$(echo -e /nmap   - \\n		\
							  /kill   - \\n 	\
							  /inurl  - \\n 	\
							  /dorks  - \\n 	\
							  /whois  - \\n 	\
							  /theharvester  - \\n	\
							  /botoes - \\n		\
							  /botoes2 - \\n	\
							  /set-target - \\n	\
							  /show-target - \\n	\
						)"
		;;

		'/admin')
		message_text=$(echo "$message_text" | awk '{print $2,$3}') 
		$message_text > log 2> log
		ShellBot.sendMessage 	--chat_id $message_chat_id 		\
					--text "Comando executado"
		ShellBot.sendMessage 	--chat_id $message_chat_id 		\
					--text "$(echo -e "<b>log do comando $message_text</b>\n\n")" \
					--parse_mode html
		ShellBot.sendMessage 	--chat_id $message_chat_id 		\
					--text "$(cat log)"
		> log
		;;

		'/btn-all')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "All shortcuts" 		\
        				--reply_markup "$keyboard" 		\
					--parse_mode markdown
		;;

		'/btn_people')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Shortcuts for peoples" 		\
        				--reply_markup "$keyboard_people" 	\
					--parse_mode markdown
		;;

		'/btn_computer')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Shortcurts for computer" 	\
        				--reply_markup "$keyboard_computer" 	\
					--parse_mode markdown
		;;
		'/advanced')
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
					--text "Qual comando quer ?" 		\
					--reply_markup "$(ShellBot.ForceReply)"
		;;

		'/set-target')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 		\
				     	--text "Qual target ?"			\
					--reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'btn_target')" \
		;;

		'/show-computer')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 		\
				     	--text "Target = $target"
		;;

		'/show-people')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 		\
				     	--text "Target = $target_p"
		;;

		*"People 👨‍💻"*)
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
					--text 'PEOPLE - Qual email ou Username? ' \
					--reply_markup "$(ShellBot.ForceReply)"
		unset btn_target 
		;;

		*"Computer 🖥"*)
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]}  	\
					--text 'COMPUTER - Qual IP ou dominio? ' \
					--reply_markup "$(ShellBot.ForceReply)"
		unset btn_target 
		;;

		'/cleam')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "OQ quer limpar?"		\
					--reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'btn_cleam')" 
		;;

		'Cleam Target - People')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "Target People limpo"		\
					--reply_markup "$(ShellBot.ReplyKeyboardRemove)" \
					--parse_mode markdown
		> $target_dir_p

		;;

		'Cleam Target - Computer')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "Target Computer limpo"		\
					--reply_markup "$(ShellBot.ReplyKeyboardRemove)" \
					--parse_mode markdown
		> $target_dir
		;;

		'Cleam All')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "All clear"			\
					--reply_markup "$(ShellBot.ReplyKeyboardRemove)" \
					--parse_mode markdown
		> $target_dir_p
		> $target_dir
		> $arg_nmap_dir
		;;

		'Cleam Args')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
				     	--text "Args limpos"			\
					--reply_markup "$(ShellBot.ReplyKeyboardRemove)" \
					--parse_mode markdown
		> $arg_nmap_dir		
		;;

		/*)	
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 		\
				     	--text "Comando invalido ver em /comandos"

	esac

	if [[ ${message_reply_to_message_message_id[$id]} ]]; then
		case $message_text in
			"nmap"*)		
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "Quais parametros para o NMAP" 	\
						--reply_markup "$(ShellBot.ForceReply)"
			;;
			'theharvester')
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text 'HARVESTER' 			\
						--reply_markup "$(ShellBot.ForceReply)"
			;;
		esac
		case ${message_reply_to_message_text[$id]} in
			*"NMAP"*)
			echo $message_text > $arg_nmap_dir
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "seus args são $message_text" 	\
			;;

			*"target"*)
			echo $message_text > $target_dir
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "Target = $message_text" 	\
			;;
			'PEOPLE - Qual email ou Username?')
			echo $message_text > $target_dir_p
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "Target = $message_text" 	\
        					--reply_markup "$keyboard_people" 	\
						--parse_mode markdown
			;;

			'COMPUTER - Qual IP ou dominio?') 
			echo $message_text > $target_dir
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
						--text "Target = $message_text" 	\
        					--reply_markup "$keyboard_computer" 	\
						--parse_mode markdown
			;;

		esac
	fi
	) &
	done
done
