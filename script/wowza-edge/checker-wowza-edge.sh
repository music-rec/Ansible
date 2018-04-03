# Function
function notify() {

   ansible-playbook /etc/ansible/playbooks/wowza-edge/send_notify_edge.yaml --extra-vars "status=$(checker)"

}

function handler() {

   ansible-playbook /etc/ansible/playbooks/wowza-edge/handler_edge.yaml

}

function uncomment() {

  ansible-playbook /etc/ansible/playbooks/wowza-edge/uncomment.yaml

}

function checker() {
   result=$(curl -i -s localhost:1936 | awk '{ print $2 }' | head -1)
   if [ "$result" == "200" ] ; then
     echo "0"
   else
     echo "Error"
   fi
}

# Main
while true; do

   if [ "$(checker)" == 1 ] ; then

      break

   else

     #notify
     #handler
     #sleep 15
     echo "fail"
     sleep 30

     if [ "$(checker)" == 1 ] ; then

        #uncomment
        break

     else

        #handler
        echo "loop"

     fi

   fi
done

