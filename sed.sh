pileup pile-up
c-jet $c$-jet
b-jet $b$-jet
light flavor light-flavor

while read line ; do
    orig=`echo $line | cut -d " " -f 1`
    new=`echo $line | cut -d " " -f 2`

    echo $orig $new
    sed -i -e "s#${orig}#${new}#g" ./temp//Detector.tex \
	./temp//Abstract.tex \
	./temp//Introduction.tex \
	./temp//Detector.tex \
	./temp//ObjectDef.tex \
	./temp//Samples.tex \
	./temp//SRdefinition.tex \
	./temp//BGestimation.tex \
	./temp//Uncertainties.tex \
	./temp//Result.tex \
	./temp/Conclusion.tex

done < sed.txt
