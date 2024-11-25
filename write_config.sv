class write_config extends uvm_object;

`uvm_object_utils(write_config); //macros

virtual fifo_wr_if vif;
 
//for making active orr passive agent
  uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "write_config");
    super.new(name);
  endfunction

endclass