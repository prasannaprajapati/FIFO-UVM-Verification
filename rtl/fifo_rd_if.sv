interface fifo_rd_if (
    input clk
);

  logic [7:0] dout;
  logic renb, empty;

  clocking rd_drv_cb @(posedge clk);
    output renb;
    input empty;
  endclocking : rd_drv_cb

  clocking rd_mon_cb @(posedge clk);
    input renb;
    input empty;
    input dout;
  endclocking : rd_mon_cb

  modport RD_DRV_MP(clocking rd_drv_cb);
  modport RD_MON_MP(clocking rd_mon_cb);

endinterface
