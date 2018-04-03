while true; do
result=$(curl -i -s localhost:1937 | awk '{ print $2 }' | head -1)
if [ "$result" == "200" ] ; then
    echo "0"
else
    echo "1"
    break
fi

done
