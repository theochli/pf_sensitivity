#Parameters
################ layer names 
DEM_PATH='./test.txt'
DEM='DEM'
FLODIR='flodir'
STREAM='stream'
################ output text file names
DEM_FILE='demout.txt'
FLOW_FILE='flodir.txt'
STREAM_FILE='stream.txt'
################ output ParFlow binary file names
SLOPEXPFB='slopex.pfb'
SLOPEYPFB='slopey.pfb'
################ output DEM file from parflowslopes
OUTFIL='out.txt'
################ River slope, Minimum slope, and unit conversion
RIVSLO=0.01
MINSLO=0.0001
#Determine conversion factor in case projection not in meters(ex. stateplane)
#CONFAC=`g.proj -p | grep 'meters' | awk -F ":" '{print $2}'`
#minumum quanitity of cells draining through a cell to define it a stream cell
THRESHOLD=1000
# vertical domain resolution(m) and number of layers(always 1 for slopes pfb)
nz=1
dz=10
# End parameter setting
echo -e "Importing Georeferenced DEM file"
r.in.ascii input=$DEM_PATH output=$DEM --verbose --overwrite
echo -e "Limiting Domain extent to match DEM file"
g.region -p rast=$DEM
#g.region -p vect=DR5_transformed
eval `g.region -g`

r.watershed -4 --verbose --overwrite elevation=$DEM threshold=$THRESHOLD drainage=$FLODIR stream=$STREAM

r.out.ascii -h -m dp=4 --verbose --overwrite input=$DEM output=$DEM_FILE width=$cols

r.out.ascii -h -m -i --verbose --overwrite input=$FLODIR output=$FLOW_FILE width=$cols

r.out.ascii -h -m -i --verbose --overwrite input=$STREAM output=$STREAM_FILE width=$cols
echo -e "running parflowslopes"
printf "%s,%s,%s,%s,%s,%s,%15d,%15d,%15d,%10.2e,%10.2e,%10.2e,%10.4e,%10.4e" $DEM_FILE $FLOW_FILE $STREAM_FILE $SLOPEXPFB $SLOPEYPFB $OUTFIL $cols $rows $nz $ewres $nsres $dz $RIVSLO $MINSLO | $PWD/parflowslopes
