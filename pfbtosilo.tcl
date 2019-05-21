lappend auto_path $env(PARFLOW_DIR)/bin 
package require parflow
namespace import Parflow::*


set tcl_precision 16
set runname lbase

for {set i 0 } {$i <= 200} {incr i 1} {

	set filename [format "slopes_only.out.press.%05d.pfb"  $i]
	set press [pfload $filename]
	pfsave $press  -silo "press.$i.silo"


	set filename [format "slopes_only.out.satur.%05d.pfb"  $i]
	set satur [pfload $filename]
	pfsave $satur  -silo "satur.$i.silo"

}
