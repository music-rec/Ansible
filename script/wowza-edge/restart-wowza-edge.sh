read -p "Server your name : " name
echo "$name"
ansible-playbook /etc/ansible/playbooks/wowza-edge/restart-wowza-edge.yaml --extra-vars "name_server=${name}" 
