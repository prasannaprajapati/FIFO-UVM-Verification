module fifo (clk,reset,renb,wenb,din,dout,empty,full);

  input logic clk, reset;
  input logic renb, wenb;
  input logic [7:0] din;
  output logic [7:0] dout;
  output logic empty, full;

  integer i;

  // Memory
  logic [7:0] mem[16];

  // Read and Write pointer
  logic [4:0] rpr, wpr;

  // Logic for read and write pointer
  always @(posedge clk) begin
    if (reset) begin
      rpr  <= 5'b0;
      wpr <= 5'b0;
    end else if (renb && ~empty) begin
      rpr <= rpr + 1;
    end else if (wenb && ~full) begin
      wpr <= wpr + 1;
    end
  end

  // Logic for write and read logic
  always @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < 16; i = i + 1) begin
        mem[i]   <= 8'b0;
        dout <= 8'b0;
      end
    end else begin
      if (renb && ~empty) dout <= mem[rpr[3:0]];
      else if (wenb && ~full) mem[wpr[3:0]] <= din;
    end
  end

  // Empty & Full

  assign empty = (rpr == wpr);
  assign full  = (rpr == {~wpr[4], wpr[3:0]});

  // NOTE: Assertions

  // Basic Protocol Assertions
  property reset_clears_pointers;
    @(posedge clk) $rose(reset) |-> ##1 (rpr == 0 && wpr == 0);
  endproperty

  property write_updates_pointer;
    @(posedge clk) disable iff (reset) (wenb && !full) |-> ##1 (wpr != $past(wpr));
  endproperty

  property read_updates_pointer;
    @(posedge clk) disable iff (reset) (renb && !empty) |-> ##1 (rpr != $past(rpr));
  endproperty

  // FIFO Functionality Assertions
  property fifo_full_condition;
    @(posedge clk) disable iff (reset) full |-> (rpr == {~wpr[4], wpr[3:0]});
  endproperty

  property fifo_empty_condition;
    @(posedge clk) disable iff (reset) empty |-> (rpr == wpr);
  endproperty

  // Liveness Properties
  property eventual_read_after_write;
    @(posedge clk) disable iff (reset) (wenb && !full) |-> ##[1:16] (!empty);
  endproperty

  // Assertion Bindings
  a_reset_clears_pointers :
  assert property (reset_clears_pointers)
  else $error("Reset did not clear pointers");

  a_write_updates_pointer :
  assert property (write_updates_pointer)
  else $error("Write pointer not updated after write");

  a_read_updates_pointer :
  assert property (read_updates_pointer)
  else $error("Read pointer not updated after read");

  a_fifo_full_condition :
  assert property (fifo_full_condition)
  else $error("FIFO full condition mismatch");

  a_fifo_empty_condition :
  assert property (fifo_empty_condition)
  else $error("FIFO empty condition mismatch");

  a_eventual_read_after_write :
  assert property (eventual_read_after_write)
  else $error("Written data not readable within bounded time");

  // Assume properties (constraints on inputs)
  a_reset_stability :
  assume property (@(posedge clk) $rose(reset) |-> ##[0:3] $stable(reset))
  else $error("Reset deasserted too quickly");


  FULL :
  cover property (@(posedge clk) !full ##1 full);

  EMPTY :
  cover property (@(posedge clk) !empty ##1 empty);

  RCP :
  cover property (reset_clears_pointers);

  WUP :
  cover property (write_updates_pointer);

  RUP :
  cover property (read_updates_pointer);

  FFC :
  cover property (fifo_full_condition);

  FEC :
  cover property (fifo_empty_condition);

  ERAW :
  cover property (eventual_read_after_write);

endmodule