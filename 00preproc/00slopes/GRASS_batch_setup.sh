chmod u+x $PWD/GRASS_slopes.sh
export GRASS_BATCH_JOB=$PWD/GRASS_slopes.sh
grass74 -text 
unset GRASS_BATCH_JOB
