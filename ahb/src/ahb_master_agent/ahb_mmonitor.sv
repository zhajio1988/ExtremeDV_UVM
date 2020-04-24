/**********************************************************
 Start Date: 10 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Master Monitor
 Filename: ahb_mmonitor.svh
 **********************************************************/

class ahb_mmonitor extends uvm_monitor;

   `uvm_component_utils(ahb_mmonitor)

   virtual ahb_intf.MMON_MP vif;
   ahb_magent_config magt_cfg;
   ahb_mxtn xtn;

   uvm_analysis_port#(ahb_mxtn) monitor_ap;

   //------------------------------------------------
   // Methods
   //------------------------------------------------

   extern function new(string name = "ahb_mmonitor", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task create_beat();
   extern task monitor_beat();

endclass: ahb_mmonitor

//Constructor
function ahb_mmonitor::new(string name = "ahb_mmonitor", uvm_component parent);
   super.new(name, parent);
   monitor_ap = new("monitor_ap", this);
endfunction

//Build
function void ahb_mmonitor::build_phase(uvm_phase phase);
   if(!uvm_config_db#(ahb_magent_config)::get(this, "", "ahb_magent_config", magt_cfg))
     begin
        `uvm_fatal(get_full_name(), "Cannot get VIF from configuration database!")
     end

   super.build_phase(phase);
endfunction

//Connect
function void ahb_mmonitor::connect_phase(uvm_phase phase);
   vif = magt_cfg.vif;
endfunction

//Run
task ahb_mmonitor::run_phase(uvm_phase phase);
   forever
     begin
        create_beat();
        fork
           begin: mon
              monitor_beat();
              disable wait_for_reset;
           end

           begin: wait_for_reset
              wait(!vif.HRESETn);
              disable mon;
              while(!vif.HRESETn)
                begin
                   xtn.reset = 0;
                   xtn.trans_type[0] = transfer_t'(vif.mmon_cb.HTRANS);
                   monitor_ap.write(xtn);
                   @(vif.mmon_cb);
                end
           end
        join
     end
endtask


// Create Transaction
task ahb_mmonitor::create_beat();
   xtn = ahb_mxtn::type_id::create("xtn", this);
   xtn.trans_type = new[1];
   xtn.address = new[1];
   xtn.write_data = new[1];
endtask


// Monitor Transaction
task ahb_mmonitor::monitor_beat();
   begin:mon1

      xtn.trans_type[0] = transfer_t'(vif.mmon_cb.HTRANS);

      if(xtn.trans_type[0] == IDLE)
        begin
           monitor_ap.write(xtn);
           `uvm_info(get_type_name(), "IDLE Transaction Detected..", UVM_MEDIUM)
           @(vif.mmon_cb);
           disable mon1;
        end

      while(xtn.trans_type[0] == BUSY);
      begin
         monitor_ap.write(xtn);
         @(vif.mmon_cb);
         xtn.trans_type[0] = transfer_t'(vif.mmon_cb.HTRANS);
         if(xtn.trans_type[0] == IDLE)
           begin
              `uvm_info(get_type_name(), "IDLE Transaction Detected..", UVM_MEDIUM)
              disable mon1;
           end
      end

      xtn.burst_mode =  burst_t'(vif.mmon_cb.HBURST);
      xtn.trans_size = size_t'(vif.mmon_cb.HSIZE);
      xtn.read_write = rw_t'(vif.mmon_cb.HWRITE);
      xtn.response = resp_t'(vif.mmon_cb.HRESP);
      xtn.address[0] = vif.mmon_cb.HADDR;
      xtn.ready = vif.mmon_cb.HREADY;
      @(vif.mmon_cb);

      while(!vif.mmon_cb.HREADY || (vif.mmon_cb.HTRANS == 1))
        begin
           xtn.ready = 0;
           monitor_ap.write(xtn);
           @(vif.mmon_cb);
        end

      if(xtn.read_write == WRITE)
        xtn.write_data[0] = vif.mmon_cb.HWDATA;
      else
        xtn.read_data = vif.mmon_cb.HRDATA;

      monitor_ap.write(xtn);
      `uvm_info(get_type_name(), "Data Received from Master Monitor..", UVM_MEDIUM)
      xtn.print();
   end
endtask

