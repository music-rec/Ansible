path="/etc/nginx/conf.d"
nginx_config_path="/etc/nginx"
nginx_conf="nginx.conf"
filename=("p2.fptplay.tv.conf" "p3.fptplay.tv.conf")
break_loop=0

k1=$(md5sum "${nginx_config_path}/${nginx_conf}")

for i in ${!filename[*]}; do
  for ((j = $i; j <= i; j++)); do
    origin[$j]=$(md5sum "${path}/${filename[$i]}")
  done
done


while true; do
k2=$(md5sum "${nginx_config_path}/${nginx_conf}")
for i in ${!filename[*]};
do
   if [ "$(md5sum ${path}/${filename[$i]})" != "${origin[$i]}" ] && [ "$k1" == "$k2" ]; then
       origin[$i]=$(md5sum "${path}/${filename[$i]}")
       echo "${filename[$i]}"
       break_loop=1
       break
   elif [ "$(md5sum ${path}/${filename[$i]})" == "${origin[$i]}" ]&& [ "$k1" != "$k2" ]; then
       echo "$nginx_conf"
       break_loop=1
       break
   else
       echo "0" > /dev/null
   fi

done
if [ "$break_loop" == 1 ]; then
   break
fi
done

