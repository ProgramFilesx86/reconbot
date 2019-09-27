#!/bin/bash

source ShellBot.sh

ShellBot.init --token $token 
ShellBot.username

#_____ _   _ _   _  ____ ___  _____ ____  
#|  ___| | | | \ | |/ ___/ _ \| ____/ ___| 
#| |_  | | | |  \| | |  | | | |  _| \___ \ 
#|  _| | |_| | |\  | |__| |_| | |___ ___) |
#|_|    \___/|_| \_|\____\___/|_____|____/ 


function help () {
	msg="Salve *${callback_query_from_username[$id]}* , bora fazer um recon??\n"
    	msg+="Da uma olhada nas info em  /comandos."
		ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                                                                  --text "Help"
   		ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                 		                                  --text "$(echo -e $msg)" \
                                	 	                  --parse_mode markdown
	}

function comandos () { 
	ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                                                     --text "status"
    	ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                                                     --text "$(echo -e /ip\\n/KILL\\n/status\\n/memoria\\n/lista\\n/idle\\n/botoes)"\
                                                     --parse_mode markdown
	}

unset botao
ShellBot.InlineKeyboardButton --button 'botao' --line 1 --text 'Help'  	--callback_data 'btn_help'      	# valor: btn_help
ShellBot.InlineKeyboardButton --button 'botao' --line 2 --text 'COMANDOS' 	--callback_data 'btn_comandos'    	# varor: btn_about
ShellBot.regHandleFunction    --function help			 		--callback_data btn_help
ShellBot.regHandleFunction    --function comandos 	 		 	--callback_data btn_comandos


unset keyboard1
# Cria o objeto inline_keyboard contendo os elementos armazenados na variável 'botao1'
# É retornada a nova estrutura e armazena em 'keyboard1'.
keyboard1="$(ShellBot.InlineKeyboardMarkup -b 'botao')"

unset botao1

botao1='[
["/help","/nmap","/inurl"],
["/theharvester","/kill","/whois"],
["/botoes","/botoes2","/comandos"],
["/dorks","/admin"]
]'

target_file='/tmp/${message_chat_id[$id]}.target'
target=$(cat $target_file)

keyboard2="$(ShellBot.ReplyKeyboardMarkup --button 'botao1' --one_time_keyboard true)"

while :
do

    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
    # Lista o índice das atualizações
    for id in $(ShellBot.ListUpdates)
    do

	ShellBot.watchHandle --callback_data ${callback_query_data[$id]}

	(
  	if [ "$message_text" = "/help" ]; then
        	 msg="Salve *$message_from_username* , Bora fazer um recon ?\n"
       	 	 msg+="Da uma olhada nas info em  /comandos."
       		 ShellBot.sendMessage --chat_id $message_chat_id --text "$(echo -e $msg)" --parse_mode markdown
    	fi
	if [[ "$message_text" = "/kill "*  ]]; then 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage --chat_id $message_chat_id --text "$message_text"   
		ShellBot.sendMessage --chat_id $message_chat_id --text "PID $message_text Finalizado"  
	fi
	if [[ "$message_text" = "/nmap "*  ]]; then 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage --chat_id $message_chat_id --text "Target - $message_text Aguarde =)"   
		nmap_result=$(nmap $message_text)
		ShellBot.sendMessage --chat_id $message_chat_id --text "$nmap_result"  
	fi
	if [ "$message_text" = "/nmap"  ]; then 
		ShellBot.sendMessage --chat_id $message_chat_id --text "Executing NMAP - Target $(cat $target) Aguarde =)"   
		nmap_result=$(nmap $target)
		ShellBot.sendMessage --chat_id $message_chat_id --text "$nmap_result"  
	fi
	if [[ "$message_text" = "/theharvester "*  ]]; then 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage --chat_id $message_chat_id --text "Target - $message_text Aguarde =)"   
		theharvester_result=$(theharvester -d $message_text -l 100 -b google)
		ShellBot.sendMessage --chat_id $message_chat_id --text "$theharvester_result"  
	fi
	if [ "$message_text" = "/theharvester"  ]; then 
		ShellBot.sendMessage --chat_id $message_chat_id --text "Target - $(cat $target) Aguarde =)"   
		theharvester_result=$(theharvester -d  $target -l 100 -b google)
		ShellBot.sendMessage --chat_id $message_chat_id --text "$theharvester_result"  
	fi
	if [[ "$message_text" = "/inurl "*  ]]; then 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage --chat_id $message_chat_id --text "Dork - $message_text Aguarde =)"   
		inurl_result=$(inurl $message_text)
		ShellBot.sendMessage --chat_id $message_chat_id --text "$inurl_result"  
	fi
	if [[ "$message_text" = "/whois "*  ]]; then 
		message_text=$(echo "$message_text" | awk '{print $2}') 
		ShellBot.sendMessage --chat_id $message_chat_id --text "WHOIS - $message_text Aguarde =)"   
		whois_result=$(whois $message_text)
		ShellBot.sendMessage --chat_id $message_chat_id --text "$whois_result"  
	fi
	if [ "$message_text" = "/whois"  ]; then 
		ShellBot.sendMessage --chat_id $message_chat_id --text "Executing WHOIS- Target $target Aguarde =)"   
		whois_result=$(whois $target)
		ShellBot.sendMessage --chat_id $message_chat_id --text "$whois_result"  
	fi
	if [ "$message_text" = "/dorks" ]; then 
		ShellBot.sendMessage --chat_id $message_chat_id --text "Lista TOP DORKS"   
		dorks_result=$(cat dorks.list)
		ShellBot.sendMessage --chat_id $message_chat_id --text "$dorks_result"  
	fi
	if [ "$message_text" = "/comandos" ]; then
		ShellBot.sendMessage --chat_id $message_chat_id --text "$(echo -e /nmap   - \\n		\
										  /kill   - \\n 	\
										  /inurl  - \\n 	\
										  /dorks  - \\n 	\
										  /whois  - \\n 	\
										  /theharvester  - \\n	\
										  /botoes - \\n		\
										  /botoes2 - \\n	\
										  )"
	fi	
	if [ "$message_text" = "/botoes" ]; then
		ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "Lista de atalhos" \
                                                             --reply_markup "$keyboard1" \
                                                             --parse_mode markdown
	fi
	if [[ "$message_text" = "/admin "* ]]; then
		message_text=$(echo "$message_text" | awk '{print $2,$3}') 
		$message_text > log 2> log
		ShellBot.sendMessage --chat_id $message_chat_id --text "Comando executado"
		ShellBot.sendMessage --chat_id $message_chat_id --text "$(echo -e "<b>log do comando $message_text</b>\n\n")" --parse_mode html
		ShellBot.sendMessage --chat_id $message_chat_id --text "$(cat log)"
		> log
	fi	
	if [ "$message_text" = "/botoes2" ]; then
		ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "Lista de atalhos" \
                                                             --reply_markup "$keyboard2" \
                                                             --parse_mode markdown
	fi
	if [[ "$message_text" = "/set-target "*  ]]; then 
		echo $message_text | awk '{print $2}' > $target_file 
		ShellBot.sendMessage --chat_id $message_chat_id --text "Target = $target)"   
	fi
	if [ "$message_text" = "/show-target"  ]; then 
		ShellBot.sendMessage --chat_id $message_chat_id --text "Target = $(cat $target)"   
	fi
	) &
	done
done
