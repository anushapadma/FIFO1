
class fifo_seq_item extends uvm_sequence_item;
  
  //---------------------------------------
  //data and control fields
  //---------------------------------------
  rand bit [127:0]i_wrdata;
  rand bit i_wren;
  rand bit i_rden ;
  bit o_full;
  bit o_empty;
  bit o_alm_full;
  bit o_alm_empty;
  bit [127:0]o_rddata ;
  
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(fifo_seq_item)
  `uvm_field_int(i_wrdata, UVM_ALL_ON)
  `uvm_field_int(i_wren, UVM_ALL_ON)
  `uvm_field_int(i_rden, UVM_ALL_ON)
  `uvm_field_int( o_full, UVM_ALL_ON)
  `uvm_field_int(o_empty, UVM_ALL_ON)
  `uvm_field_int( o_alm_full, UVM_ALL_ON)
  `uvm_field_int(o_alm_empty, UVM_ALL_ON)
  `uvm_field_int(o_rddata, UVM_ALL_ON)
  `uvm_object_utils_end
  
  //---------------------------------------
  //Constraint
  //---------------------------------------
  constraint c1{i_wren!=i_rden;};
  
  //---------------------------------------
  //Pre randomize function
  //--------------------------------------
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name="fifo_seq_item");
    super.new(name);
  endfunction
  
  function string convert2string();
    return $psprintf("data_in=%0h,data_out=%0h,wr=%0d,rd=%0d,full=%od,empty=%0d,almost full=%od,almost empty=%0d",i_wrdata,o_rddata, i_wren,i_rden,o_full,o_empty,o_alm_full,o_alm_empty);
  endfunction
  
endclass
