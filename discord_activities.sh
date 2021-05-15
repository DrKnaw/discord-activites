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
echo "Enter a discord token (silent input):"
read -s
if [ ${#REPLY} = "59" ]
then
        echo ""
        TOKEN=$REPLY
else
        echo ""
        echo "Invalid token."
        exit
fi
echo "Wich activity do you want?"
select yn in "YouTube" "Poker Night" "Betrayal" "Fishington" "Exit"; do
    case $yn in
        YouTube ) APP_ID=755600276941176913; break;;
        Poker\ Night )  APP_ID=755827207812677713;  break;;
        Betrayal ) APP_ID=755827207812677713;;  break;;
        Fishington )  echo ''; echo 'Not Implemented Yet';  break;;
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
echo ""
RESULT=`curl --silent -X POST -H "Authorization: $TOKEN" --data "$(generate_post_data)" -H "Content-Type: application/json" https://discord.com/api/v8/channels/$CHANNEL_ID/invites | grep code | awk {'print $2'} | sed 's/"//g' | sed 's/,//g'`
echo "Fetching Done."
echo ""
echo "The Link to join the activity is the following:"
echo ""
echo "https://discord.gg/"$RESULT
echo ""
echo "(https://drknaw.eu)"
