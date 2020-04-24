// ***********************************************************************
//                 Copyright (c) 2019.                                    
//             PICOCOMTECH®  ALL RIGHTS RESERVED                          
// ***********************************************************************
// PROJECT        : ExtremeDV_UVM
// FILENAME       : ahb_test_pkg.svh
// Author         : JIONGZ
// LAST MODIFIED  : 2020-04-23 21:53
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
`ifndef __AHB_TEST_PKG_SVH__
 `define __AHB_TEST_PKG_SVH__
package ahb_test_pkg;
   timeunit 1ns;
   timeprecision 1ps;
 `include "uvm_macros.svh"
   import uvm_pkg::*;
   import ahb_src_pkg::*;

 `include "ahb_base_test.sv"
 `include "ahb_reset_test.sv"
 `include "ahb_incrx_test.sv"
 `include "ahb_wrapx_test.sv"
 `include "ahb_crt_test.sv"
 `include "ahb_incrbusy_test.sv"
 `include "ahb_err_test.sv"
endpackage
`endif

