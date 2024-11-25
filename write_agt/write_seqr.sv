class write_seqr extends uvm_sequencer#(write_xtn);
 `uvm_component_utils(write_seqr) // Macro for automatic UVM component registration

 function new(string name, uvm_component parent);
 super.new(name, parent); // Call base class constructor with name andparent component
 endfunction
endclass