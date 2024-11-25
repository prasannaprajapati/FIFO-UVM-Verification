interface fifo_wr_if (
    input clk
);

  logic reset, wenb;
  logic [7:0] din;
  logic full;


  clocking wr_drv_cb @(posedge clk);
    output wenb;
    output din;
    output reset;
    input full;
  endclocking : wr_drv_cb

  clocking wr_mon_cb @(posedge clk);
    // default input #0 output #1;
    input wenb;
    input din;
    input reset;
    input full;
  endclocking : wr_mon_cb

  modport WR_DRV_MP(clocking wr_drv_cb);
  modport WR_MON_MP(clocking wr_mon_cb);

endinterface
