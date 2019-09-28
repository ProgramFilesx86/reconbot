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

keyboard="$(ShellBot.ReplyKeyboardMarkup --button 'botao' --one_time_keyboard true)"

while :
do

    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
    for id in $(ShellBot.ListUpdates)
    do

	(
	[[ ${message_chat_type[$id]} != private ]] && continue
	mkdir /tmp/${message_from_id[$id]}
        target_dir=/tmp/${message_from_id[$id]}/target
        target=$(< $target_dir)
	arg_nmap_dir=/tmp/${message_from_id[$id]}/nmap-agr
	
	case ${message_text[$id]} in
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

		'/botoes')
		ShellBot.sendMessage 	--chat_id ${message_from_id[$id]} 	\
					--text "Lista de atalhos" 		\
        				--reply_markup "$keyboard" 		\
					--parse_mode markdown
		;;

		'/advanced')
		ShellBot.sendMessage	--chat_id ${message_from_id[$id]} 	\
					--text "Qual comando quer ?" 		\
					--reply_markup "$(ShellBot.ForceReply)"
		;;

		'/set-target')
		echo $message_text | awk '{print $2}' > $target_dir		
		ShellBot.sendMessage 	--chat_id $message_chat_id 		\
				     	--text "Qual target ?"			\
					--reply_markup "$(ShellBot.ForceReply)"
		;;

		'/show-target')
		ShellBot.sendMessage 	--chat_id $message_chat_id 		\
				     	--text "Target = $target"
		;;

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

		esac
	fi
	) &
	done
done
