result=$(curl -i -s localhost:1936 | awk '{ print $2 }' | head -1)
if [ "$result" == "200" ] ; then
    echo "0"
else
    echo "1"
    break
fi

