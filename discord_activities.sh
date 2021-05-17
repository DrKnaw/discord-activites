#!/bin/bash
echo ""
echo " _____  _                       _                _   _       _ _   _           "
echo "|  __ \(_)                     | |     /\       | | (_)     (_) | (_)          "
echo "| |  | |_ ___  ___ ___  _ __ __| |    /  \   ___| |_ ___   ___| |_ _  ___  ___ "
echo "| |  | | / __|/ __/ _ \|  __/ _  |   / /\ \ / __| __| \ \ / / | __| |/ _ \/ __|"
echo "| |__| | \__ \ (_| (_) | | | (_| |  / ____ \ (__| |_| |\ V /| | |_| |  __/\__  "
echo "|_____/|_|___/\___\___/|_|  \__ _| /_/    \_\___|\__|_| \_/ |_|\__|_|\___||___/"
echo ""
echo ""
if [ -f "./token.txt" ]; then
   while read line; do 
   if [ ${#line} = "59" ]; then
        echo ""
        TOKEN=$line
else
        echo ""
        echo "Invalid token. (if persit try removing token.txt)"
        exit
fi
  
  
  done < token.txt
  else
   echo "Enter a discord token (silent input):"
  read -s token
     if [ ${#token} = "59" ]; then
        echo ""
        TOKEN=$token
else
        echo ""
        echo "Invalid token."
        exit
fi
  
  echo "Do you want to save the token ? (y or n)"
  read ouinon
  if echo "$ouinon" | grep -iq "^y" ;then
 echo $token >> token.txt
 else 
 echo "Token not save."
 echo ""
 fi


fi


echo "Wich activity do you want?"
select activites in "YouTube" "Poker Night" "Betrayal" "Fishington" "Other" "Exit"; do
    case $activites in
        YouTube ) APP_ID=755600276941176913; break;;
        Poker\ Night )  APP_ID=755827207812677713;  break;;
        Betrayal ) APP_ID=755827207812677713;  break;;
        Fishington )  APP_ID=814288819477020702; break;;
        Other ) echo ''; echo 'Enter the ID of the Application:'; read; APP_ID=$REPLY; break;;
        Exit ) exit;;
    esac
done


generate_post_data()
{
  cat <<EOF
{"target_application_id":"$APP_ID","target_type":"2"}
EOF
}
echo ""
echo "Enter the ID of the voice channel:"
read
CHANNEL_ID=$REPLY
echo "Fetching Discord API..."
echo "Bot Token or User Token ?"
select botoruser in "Bot" "User"; do
    case $botoruser in
        Bot ) RESULT=`curl --silent -X POST -H "Authorization: Bot $TOKEN" --data "$(generate_post_data)" -H "Content-Type: application/json" https://discord.com/api/v8/channels/$CHANNEL_ID/invites | grep code | awk {'print $2'} | sed 's/"//g' | sed 's/,//g'`; break;;
        User ) RESULT=`curl --silent -X POST -H "Authorization: $TOKEN" --data "$(generate_post_data)" -H "Content-Type: application/json" https://discord.com/api/v8/channels/$CHANNEL_ID/invites | grep code | awk {'print $2'} | sed 's/"//g' | sed 's/,//g'`;  break;;
    esac
done
echo ""
echo "Fetching Done."
echo "The Link to join the activity is the following:"
echo ""
echo "https://discord.gg/"$RESULT
echo ""
echo "(https://drknaw.eu)"
