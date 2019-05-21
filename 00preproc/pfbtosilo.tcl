lappend auto_path $env(PARFLOW_DIR)/bin 
package require parflow
namespace import Parflow::*


set tcl_precision 16


set slopes [pfload "slopey.pfb"]	
pfsave $slopes -silo "slopey.silo"



