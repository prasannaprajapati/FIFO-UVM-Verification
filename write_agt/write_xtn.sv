class write_xtn extends uvm_sequence_item;

`uvm_object_utils(write_xtn)


  rand logic reset, wenb;
  rand logic [7:0] din;

  logic full;


//function new constructor
function new(string name="write_xtn");
super.new(name);
endfunction

//do_print
function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("reset", this.reset, 1, UVM_BIN);
    printer.print_field("write_en", this.wenb, 1, UVM_BIN);
    printer.print_field("data_in", this.din, 8, UVM_DEC);
    printer.print_field("full", this.full, 1, UVM_BIN);

  endfunction : do_print

endclass
