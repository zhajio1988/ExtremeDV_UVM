// ***********************************************************************
//                 Copyright (c) 2019.                                    
//             PICOCOMTECH®  ALL RIGHTS RESERVED                          
// ***********************************************************************
// PROJECT        : ExtremeDV_UVM
// FILENAME       : ahb_src_pkg.svh
// Author         : JIONGZ
// LAST MODIFIED  : 2020-04-23 21:53
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
`ifndef __AHB_SRC_PKG_SVH__
`define __AHB_SRC_PKG_SVH__

package ahb_src_pkg;

    `include "uvm_macros.svh"
    import uvm_pkg::*;
    
    `include "tb_defs.svh"
    
    `include "ahb_mxtn.sv"
    `include "ahb_sxtn.sv"
    
    `include "ahb_magent_config.sv"
    `include "ahb_mseqr.sv"
    `include "ahb_mdriver.sv"
    `include "ahb_mmonitor.sv"
    
    `include "ahb_sagent_config.sv"
    `include "ahb_sseqr.sv"
    `include "ahb_sdriver.sv"
    `include "ahb_smonitor.sv"
    
    `include "reset_seqr.sv"
    `include "reset_driver.sv"
    
    `include "env_config.sv"
    `include "ahb_vseqr.sv"
    `include "reset_agent.sv"
    `include "ahb_magent.sv"
    `include "ahb_sagent.sv"
    `include "ahb_coverage.sv"
    
    `include "ahb_env.sv"
    
    `include "reset_seqs.sv"
    `include "ahb_mseqs.sv"
    `include "ahb_sseqs.sv"
    `include "ahb_vseqs.sv"
    
endpackage
`endif

