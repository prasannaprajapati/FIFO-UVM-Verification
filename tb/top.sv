module top ();

 bit clk; 
 
  import test_pkg::*;
  import uvm_pkg::*;

  fifo_wr_if wr_if (clk);
  fifo_rd_if rd_if (clk);

  fifo duv (

      .clk(clk),

      // write interface
      .reset(wr_if.reset),
      .wenb(wr_if.wenb),
      .din(wr_if.din),
      .full(wr_if.full),

      // read interface
      .renb(rd_if.renb),
      .dout(rd_if.dout),
      .empty(rd_if.empty)

  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin

    uvm_config_db#(virtual fifo_wr_if)::set(null, "*", "wr_if", wr_if);
    uvm_config_db#(virtual fifo_rd_if)::set(null, "*", "rd_if", rd_if);

    run_test();

  end


endmodule
