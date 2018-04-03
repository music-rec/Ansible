path="/etc/ansible/config/proxy/"
nginx_conf="/etc/ansible/config/proxy/nginx.conf"
filename=("p2.fptplay.tv.conf" "p3.fptplay.tv.conf" "p4.fptplay.tv.conf")
break_loop=0

k1=$(md5sum "$nginx_conf")

for i in ${!filename[*]}; do
  for ((j = $i; j <= i; j++)); do
    origin[$j]=$(md5sum "${path}/${filename[$i]}")
  done
done


while true; do
k2=$(md5sum "$nginx_conf")
for i in ${!filename[*]};
do
   if [ "$(md5sum ${path}/${filename[$i]})" != "${origin[$i]}" ] || [ "$k1" != "$k2" ]; then
       break_loop=1
       origin[$i]=$(md5sum "${path}/${filename[$i]}")
       echo "${filename[$i]}"
       #ansible-playbook /etc/ansible/playbooks/notify.yaml --extra-vars "file_name=${filename[$i]}"
       cp /etc/ansible/config/proxy/${filename[$i]} /etc/ansible/config/backup/${filename[$i]}.$(date +"%Y.%m.%d-%T")
       ansible-playbook /etc/ansible/playbooks/nginx/clone_nginx.yaml --extra-vars "file_name=${filename[$i]}"
       break
   else
       echo "0" > /dev/null
       fi

done
if [ "$break_loop" == 1 ]; then
   break
fi

done

