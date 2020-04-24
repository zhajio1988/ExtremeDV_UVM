/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 11 Sept 2015
 Author: Mayur Kubavat
 
 Module: TOP
 Filename: top.sv
 **********************************************************/
`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;
import ahb_src_pkg::*;
import ahb_test_pkg::*;

module top;
   logic clock;

   initial
     begin
        clock = 0;
        forever #10 clock = ~clock;
     end

   ahb_intf intf(clock);


   initial
     begin
        uvm_config_db#(virtual ahb_intf)::set(null, "*", "ahb_intf", intf);

        run_test();
     end
   `JVS_WAVE(top)

endmodule

