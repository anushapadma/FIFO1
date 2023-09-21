`include "fifo_sequence_item.sv"
`include "fifo_sequence.sv"
`include "fifo_sequencer.sv"
`include "fifo_driver.sv"
`include "fifo_monitor.sv"
//Fifo Agent

class fifo_agent extends uvm_agent;
  
  fifo_sequencer f_seq;
  fifo_driver driv;
  fifo_monitor f_mon;
  
  `uvm_component_utils(fifo_agent)
  
  virtual fifo_interface vif;
  
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  
  
  //---------------------------------------
  //Constructor
  //---------------------------------------  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  //---------------------------------------
  //Build phase
  //---------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    f_seq=fifo_sequencer::type_id::create("seq",this);
    driv=fifo_driver::type_id::create("driv",this);
    f_mon=fifo_monitor::type_id::create("mon",this);
    uvm_config_db#(virtual fifo_interface)::set(this, "seq", "vif", vif);
    uvm_config_db#(virtual fifo_interface)::set(this, "driv", "vif", vif);
    uvm_config_db#(virtual fifo_interface)::set(this, "mon", "vif", vif);
    
    if(!uvm_config_db#(virtual fifo_interface)::get(this,"","vif",vif))
      begin
        `uvm_error("build_phase","agent virtual interface failed");
      end
    
  endfunction
  
  //---------------------------------------
  //Connect phase
  //---------------------------------------
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driv.seq_item_port.connect(f_seq.seq_item_export);
    uvm_report_info("FIFO_AGENT", "connect_phase, Connected driver to sequencer");
  endfunction
  
endclass
