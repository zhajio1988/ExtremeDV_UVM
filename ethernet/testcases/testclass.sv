//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : testclass.sv                                        //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef TESTCLASS__SV
 `define TESTCLASS__SV

class test_base extends uvm_test;

   env               m_env;
   uvm_factory factory = uvm_factory::get();
   `uvm_component_utils( test_base );

   function new(input string name, input uvm_component parent);
      super.new(name, parent);
   endfunction : new


   virtual function void build_phase(input uvm_phase phase);
      super.build_phase(phase);
      m_env = env::type_id::create("m_env", this);
      // ==== Run the sequence on the sequencer using uvm_config_db ===
      uvm_config_db #(uvm_object_wrapper)::set(this, "m_env.rst_agent.rst_seqr.reset_phase", "default_sequence", reset_sequence::get_type() );
      uvm_config_db #(uvm_object_wrapper)::set(this, "m_env.wshbn_agent.wshbn_seqr.configure_phase", "default_sequence", wishbone_init_sequence::get_type() );
      uvm_config_db #(uvm_object_wrapper)::set(this, "m_env.pkt_tx_agent.pkt_tx_seqr.main_phase", "default_sequence", packet_sequence::get_type() );
      // ==============================================================

      // ==== Set the number of packets in the sequence ===============
      uvm_config_db #(int unsigned)::set(this, "m_env.pkt_tx_agent.pkt_tx_seqr.packet_sequence", "num_packets", 10 );
      // ==============================================================
   endfunction : build_phase


   virtual function void end_of_elaboration_phase(input uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      `uvm_info(get_name(), "Printing Topology from end_of_elaboration phase", UVM_MEDIUM)
      if ( uvm_report_enabled(UVM_MEDIUM) ) begin
         uvm_top.print_topology();
      end
   endfunction : end_of_elaboration_phase


   virtual function void start_of_simulation_phase(input uvm_phase phase);
      super.start_of_simulation_phase(phase);
      `uvm_info(get_name(), "Printing factory from start_of_simulation phase", UVM_MEDIUM);
      if ( uvm_report_enabled(UVM_MEDIUM) ) begin
         factory.print();
      end
   endfunction  : start_of_simulation_phase


   virtual task run_phase(input uvm_phase phase);
      `uvm_info(get_name(), $sformatf("%m"), UVM_HIGH);
   endtask : run_phase


   virtual task main_phase( input uvm_phase phase);
      uvm_objection   objection;
      super.main_phase(phase);
      objection = phase.get_objection();
      objection.set_drain_time(this, 1us);
   endtask : main_phase


   //  virtual function void report_phase(input uvm_phase phase);
   //    uvm_report_server svr;
   //    svr = uvm_report_server::get_server();
   //    if (svr.get_severity_count(UVM_ERROR))
   //      `uvm_error(get_name(), "***** UVM TEST FAILED *****")
   //  endfunction : report_phase

endclass : test_base

class virtual_sequence_test_base extends test_base;

   virtual_sequencer     v_seqr;

   `uvm_component_utils( virtual_sequence_test_base );

   function new(input string name, input uvm_component parent);
      super.new(name, parent);
   endfunction : new


   virtual function void build_phase(input uvm_phase phase);
      super.build_phase(phase);
      v_seqr = virtual_sequencer::type_id::create("v_seqr", this);

      // Reset and Configure sequences remain untouched ===============
      uvm_config_db #(uvm_object_wrapper)::set(this, "m_env.rst_agent.rst_seqr.reset_phase", "default_sequence", reset_sequence::get_type());
      uvm_config_db #(uvm_object_wrapper)::set(this, "m_env.wshbn_agent.wshbn_seqr.configure_phase", "default_sequence", wishbone_init_sequence::get_type());
      uvm_config_db #(uvm_object_wrapper)::set(this, "m_env.pkt_tx_agent.pkt_tx_seqr.main_phase", "default_sequence", null);
      // ==============================================================

      // Run the virtual_sequence on the virtual_sequencer ============
      uvm_config_db #(uvm_object_wrapper)::set(this, "v_seqr.main_phase", "default_sequence", virtual_sequence::get_type() );
      // ==============================================================
   endfunction : build_phase


   virtual function void connect_phase(input uvm_phase phase);
      super.connect_phase(phase);
      v_seqr.seqr_rst     = m_env.rst_agent.rst_seqr;
      v_seqr.seqr_wshbn   = m_env.wshbn_agent.wshbn_seqr;
      v_seqr.seqr_tx_pkt  = m_env.pkt_tx_agent.pkt_tx_seqr;
   endfunction : connect_phase


   //  virtual function void report_phase(input uvm_phase phase);
   //    super.report_phase(phase);
   //  endfunction : report_phase

endclass : virtual_sequence_test_base

`endif  // TESTCLASS__SV
