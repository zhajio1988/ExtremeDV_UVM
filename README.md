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

## add axi tb
axi tb is from https://github.com/marcoz001/axi-uvm  

### run a testcase
` YASAsim -b axi -t axi_sequential_writes_test -seed 1 -w`   

### run a group of testcases
`YASAsim -g axi_regr` 

## more topic
Pls visit My Blog [ExtremeDV](https://blog.csdn.net/zhajio)  
![ExtremeDV](https://github.com/zhajio1988/ExtremeDV_UVM/blob/master/XtremeDV.png)

## If you need some help about verification pls contact with me



