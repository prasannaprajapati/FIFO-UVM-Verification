class read_xtn extends uvm_sequence_item;

  `uvm_object_utils(read_xtn);

  rand logic renb;

  logic [7:0] dout;
  logic empty;

  function new(string name = "read_xtn");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("renb", this.renb, 1, UVM_BIN);
    printer.print_field("dout", this.dout, 8, UVM_DEC);
    printer.print_field("empty", this.empty, 1, UVM_BIN);

  endfunction : do_print

endclass


