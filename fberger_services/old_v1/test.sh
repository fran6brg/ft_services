a="one"
b="two"
c="three"

array=($a $b $c)
arraylength=${#array[@]}

for (( i=1; i<${arraylength}+1; i++ ));
do
  echo $i " / " ${arraylength} " : " ${array[$i-1]}
done