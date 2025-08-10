#for line in "Fig. Figure" "Tab. Table" "Tablees Tables"; do
for line in "Tablee Table"; do
#for line in "Tableee Table"; do

    orig=`echo $line | cut -d " " -f 1`
    new=`echo $line | cut -d " " -f 2`

    echo $orig $new
    sed -i -e "s#${orig}#${new}#g" tex/*/*.tex
done
