`ifndef __XGMII_PKG_SV__
 `define __XGMII_PKG_SV__

package xgmii_pkg;
 `include "uvm_macros.svh"
   import uvm_pkg::*;

 `include "reset_item.sv"
 `include "reset_sequence.sv"
 `include "wishbone_item.sv" 
 `include "wishbone_sequence.sv"
 `include "packet.sv"
 `include "packet_sequence.sv"

 `include "reset_item.sv"
 `include "reset_driver.sv"
 `include "reset_agent.sv"

 `include "wishbone_monitor.sv"
 `include "wishbone_driver.sv"
 `include "wishbone_agent.sv"

 `include "packet_tx_monitor.sv"
 `include "packet_tx_driver.sv"
 `include "packet_tx_agent.sv"
 `include "packet_rx_monitor.sv"
 `include "packet_rx_agent.sv"

 `include "xgmii_packet.sv"
 `include "xgmii_rx_monitor.sv"
 `include "xgmii_tx_monitor.sv"
 `include "xgmii_tx_agent.sv"
 `include "xgmii_rx_agent.sv"

 `include "scoreboard.sv"

 `include "env.sv"
 `include "virtual_sequencer.sv"
 `include "virtual_sequence.sv"
endpackage

`endif

