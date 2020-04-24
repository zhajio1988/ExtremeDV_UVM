# ExtremeDV_UVM

## run a testcase
`source bin/bootenv.sh`  
`YASAsim -t ahb_crt_test  -seed 1`  

## run a group of testcases
`YASAsim -g ahb_regr`  

## add ethernet tb

### run a testcase
` YASAsim -b ethernet -t bringup_packet_test -seed 1 -w`   

### run a group of testcases
`YASAsim -g ethernet_regr`  
