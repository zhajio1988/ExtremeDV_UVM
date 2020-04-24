# ExtremeDV_UVM

## support simulator
After `source bin/bootenv.sh`  
use   
`export YASA_SIMULATOR=vcs`  
or  
`export YASA_SIMULATOR=xrun`   
to change default simulatior

## add ahb tb
ahb tb is from https://github.com/mayurkubavat/UVM 

### run a testcase of default tb
`source bin/bootenv.sh`  
`YASAsim -t ahb_crt_test  -seed 1`  

### run a group of testcases of default tb
`YASAsim -g ahb_regr`  

## add ethernet tb
ethernet tb is from https://github.com/andres-mancera/ethernet_10ge_mac_SV_UVM_tb  
### run a testcase
` YASAsim -b ethernet -t bringup_packet_test -seed 1 -w`   

### run a group of testcases
`YASAsim -g ethernet_regr`  

