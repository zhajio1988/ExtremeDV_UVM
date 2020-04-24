`ifndef __AXI_TEST_PKG_SV__
 `define __AXI_TEST_PKG_SV__

package axi_test_pkg ;
   timeunit 1ns;
   timeprecision 1ps;
 `include "uvm_macros.svh"
   /** Import UVM Package */
   import uvm_pkg::*; 
   import axi_uvm_pkg::*;

 `include "axi_base_test.sv"

endpackage

`endif

