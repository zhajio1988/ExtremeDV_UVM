////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2017, Matt Dew @ Dew Technologies, LLC
//
// This program is free software (logic verification): you can redistribute it
// and/or modify it under the terms of the GNU Lesser General Public License (LGPL)
// as published by the Free Software Foundation, either version 3 of the License,
// or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
// for more details.
//
// License:     LGPL, v3, as defined and found on www.gnu.org,
//              http://www.gnu.org/licenses/lgpl.html
//
//
// Author's intent:  If you use this AXI verification code and find or fix bugs
//                   or make improvements, then share those fixes or improvements.
//                   If you use this in a bigger project, I don't care about,
//                   or want, any changes or code outside this block.
//                   Example: If you use this in an SoC simulation/testbench
//                            I don't want, or care about, your SoC or other blocks.
//                            I just care about the enhancements to these AXI files.
//                   That's why I have choosen the LGPL instead of the GPL.
////////////////////////////////////////////////////////////////////////////////
//
//
/*! \module tb
 * \brief  Top Level.
 *
 * This is a dual-top environment.This is the top level module that instantiates DUT and TB tops.
 * Here though the DUT is two axi_if interfaces wired together with one configured as master
 * and the other configured as a slave/responder.
 */

`include "uvm_macros.svh"
import uvm_pkg::*;
import params_pkg::*;

import axi_uvm_pkg::*;
import axi_test_pkg::*;
module tb_top;


   parameter C_AXI_ID_WIDTH   = params_pkg::AXI_ID_WIDTH;
   parameter C_AXI_ADDR_WIDTH = params_pkg::AXI_ADDR_WIDTH;
   parameter C_AXI_DATA_WIDTH = params_pkg::AXI_DATA_WIDTH;
   parameter C_AXI_LEN_WIDTH  = params_pkg::AXI_LEN_WIDTH;


   logic clk;
   logic reset;

   wire  axi_awready;
   wire [C_AXI_ID_WIDTH-1:0] axi_awid;
   wire [C_AXI_ADDR_WIDTH-1:0] axi_awaddr;
   wire [C_AXI_LEN_WIDTH-1:0]  axi_awlen;    // Write Burst Length
   wire [2:0]                  axi_awsize;        // Write Burst size
   wire [1:0]                  axi_awburst;  // Write Burst type
   wire [0:0]                  axi_awlock;   // Write lock type
   wire [3:0]                  axi_awcache;  // Write Cache type
   wire [2:0]                  axi_awprot;   // Write Protection type
   wire [3:0]                  axi_awqos;    // Write Quality of Svc
   wire                        axi_awvalid;  // Write address valid

   // AXI write data channel signals
   wire                        axi_wready;   // Write data ready
   wire [C_AXI_DATA_WIDTH-1:0] axi_wdata;    // Write data
   wire [C_AXI_DATA_WIDTH/8-1:0] axi_wstrb;    // Write strobes
   wire                          axi_wlast;    // Last write transaction
   wire                          axi_wvalid;   // Write valid

   // AXI write response channel signals
   wire [C_AXI_ID_WIDTH-1:0]     axi_bid;      // Response ID
   wire [1:0]                    axi_bresp;    // Write response
   wire                          axi_bvalid;   // Write reponse valid
   wire                          axi_bready;   // Response ready

   // AXI read address channel signals
   wire                          axi_arready; // Read address ready
   wire [C_AXI_ID_WIDTH-1:0]     axi_arid;    // Read ID
   wire [C_AXI_ADDR_WIDTH-1:0]   axi_araddr;  // Read address
   wire [C_AXI_LEN_WIDTH-1:0]    axi_arlen;  // Read Burst Length
   wire [2:0]                    axi_arsize;  // Read Burst size
   wire [1:0]                    axi_arburst; // Read Burst type
   wire [0:0]                    axi_arlock;  // Read lock type
   wire [3:0]                    axi_arcache; // Read Cache type
   wire [2:0]                    axi_arprot;  // Read Protection type
   wire [3:0]                    axi_arqos;   // Read Protection type
   wire                          axi_arvalid; // Read address valid

   // AXI read data channel signals
   wire [C_AXI_ID_WIDTH-1:0]     axi_rid;     // Response ID
   wire [1:0]                    axi_rresp;   // Read response
   wire                          axi_rvalid;  // Read reponse valid
   wire [C_AXI_DATA_WIDTH-1:0]   axi_rdata;   // Read data
   wire                          axi_rlast;   // Read last
   wire                          axi_rready;  // Read Response ready

   //  wire                            o_reset;
   wire                          wb_cyc;
   wire                          wb_stb;
   wire                          wb_we;
   wire [(C_AXI_ADDR_WIDTH-1):0] wb_addr;
   wire [(C_AXI_DATA_WIDTH-1):0] wb_indata;
   wire [(C_AXI_DATA_WIDTH-1):0] wb_outdata;
   wire [(C_AXI_DATA_WIDTH/8-1):0] wb_sel;
   wire                            wb_ack;
   wire                            wb_stall;
   wire                            wb_err;
   int                             transactions;


   /*! Driver instantiation */
   axi_if #(.C_AXI_ID_WIDTH      (C_AXI_ID_WIDTH),
            .C_AXI_DATA_WIDTH (C_AXI_DATA_WIDTH),
            .C_AXI_ADDR_WIDTH (C_AXI_ADDR_WIDTH),
            .C_AXI_LEN_WIDTH  (C_AXI_LEN_WIDTH)
            ) axi_driver_vif (.clk   (clk),
                              .reset (reset),
                              .awready(axi_awready),
                              .awid(axi_awid),
                              .awaddr(axi_awaddr),
                              .awlen(axi_awlen),
                              .awsize(axi_awsize),
                              .awburst(axi_awburst),
                              .awlock(axi_awlock),
                              .awcache(axi_awcache),
                              .awprot(axi_awprot),
                              .awqos(axi_awqos),
                              .awvalid(axi_awvalid),

                              .wready(axi_wready),
                              .wdata(axi_wdata),
                              .wstrb(axi_wstrb),
                              .wlast(axi_wlast),
                              .wvalid(axi_wvalid),

                              .bid(axi_bid),
                              .bresp(axi_bresp),
                              .bvalid(axi_bvalid),
                              .bready(axi_bready),

                              .arready(axi_arready),
                              .arid(axi_arid),
                              .araddr(axi_araddr),
                              .arlen(axi_arlen),
                              .arsize(axi_arsize),
                              .arburst(axi_arburst),
                              .arlock(axi_arlock),
                              .arcache(axi_arcache),
                              .arprot(axi_arprot),
                              .arqos(axi_arqos),
                              .arvalid(axi_arvalid),

                              .rid(axi_rid),
                              .rresp(axi_rresp),
                              .rvalid(axi_rvalid),
                              .rdata(axi_rdata),
                              .rlast(axi_rlast),
                              .rready(axi_rready)
                              );

   /*! Slave/responder instantiation */
   axi_if #(.C_AXI_ID_WIDTH   (C_AXI_ID_WIDTH),
            .C_AXI_DATA_WIDTH (C_AXI_DATA_WIDTH),
            .C_AXI_ADDR_WIDTH (C_AXI_ADDR_WIDTH),
            .C_AXI_LEN_WIDTH  (C_AXI_LEN_WIDTH)
            ) axi_responder_vif (.clk   (clk),
                                 .reset (reset),
                                 .awready(axi_awready),
                                 .awid(axi_awid),
                                 .awaddr(axi_awaddr),
                                 .awlen(axi_awlen),
                                 .awsize(axi_awsize),
                                 .awburst(axi_awburst),
                                 .awlock(axi_awlock),
                                 .awcache(axi_awcache),
                                 .awprot(axi_awprot),
                                 .awqos(axi_awqos),
                                 .awvalid(axi_awvalid),

                                 .wready(axi_wready),
                                 .wdata(axi_wdata),
                                 .wstrb(axi_wstrb),
                                 .wlast(axi_wlast),
                                 .wvalid(axi_wvalid),

                                 .bid(axi_bid),
                                 .bresp(axi_bresp),
                                 .bvalid(axi_bvalid),
                                 .bready(axi_bready),

                                 .arready(axi_arready),
                                 .arid(axi_arid),
                                 .araddr(axi_araddr),
                                 .arlen(axi_arlen),
                                 .arsize(axi_arsize),
                                 .arburst(axi_arburst),
                                 .arlock(axi_arlock),
                                 .arcache(axi_arcache),
                                 .arprot(axi_arprot),
                                 .arqos(axi_arqos),
                                 .arvalid(axi_arvalid),

                                 .rid(axi_rid),
                                 .rresp(axi_rresp),
                                 .rvalid(axi_rvalid),
                                 .rdata(axi_rdata),
                                 .rlast(axi_rlast),
                                 .rready(axi_rready)
                                 );


   // tbx clkgen
   initial begin
      clk = 0;
      forever begin
         #10 clk = ~clk;
      end
   end

   // tbx clkgen
   initial begin
      reset = 1;
      #100 reset = 0;
   end

   initial begin

      if ($value$plusargs("transactions=%d", transactions)) begin
         `uvm_info("plusargs", $sformatf("TRANSACTIONS: %0d", transactions), UVM_INFO)
      end

      uvm_config_db #(int)::set(null, "*", "AXI_ADDR_WIDTH", C_AXI_ADDR_WIDTH);
      uvm_config_db #(int)::set(null, "*", "AXI_DATA_WIDTH", C_AXI_DATA_WIDTH);
      uvm_config_db #(int)::set(null, "*", "AXI_ID_WIDTH",   C_AXI_ID_WIDTH);
      uvm_config_db #(int)::set(null, "*", "AXI_LEN_WIDTH",  C_AXI_LEN_WIDTH);

      axi_driver_vif.use_concrete_class();
      axi_responder_vif.use_concrete_class();

      //run_test("axi_sequential_writes_test");
      run_test();

   end
   `JVS_WAVE(tb_top)

endmodule : tb_top
