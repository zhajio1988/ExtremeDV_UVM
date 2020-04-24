`ifndef __XGMII_TEST_PKG_SV__
 `define __XGMII_TEST_PKG_SV__

package xgmii_test_pkg;
   timeunit 1ns;
   timeprecision 1ps;
 `include "uvm_macros.svh"
   import uvm_pkg::*;
   import xgmii_pkg::*;

 `include "testclass.sv"

endpackage

`endif

