class write_driver extends uvm_driver #(write_xtn);

  `uvm_component_utils(write_driver);

virtual fifo_wr_if.WR_DRV_MP vif;

//config db
write_config my_config;

//---function new constructor--
function new(string name = "write_driver", uvm_component parent);
super.new(name, parent);
endfunction

//---------build_phase----------
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

`uvm_info("WRITE_DRIVER", "This is build_phase", UVM_LOW)

if (!uvm_config_db#(write_config)::get(this, "", "write_config", my_config)) begin
`uvm_fatal("WRITE_DRIVER", "Set the write_config")
end
endfunction : build_phase


//---------connect_phase-----------
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
`uvm_info("WRITE_DRIVER", "This is connect_phase", UVM_LOW)
vif = my_config.vif;
endfunction : connect_phase

//-----------run_phase--------------
  virtual task run_phase(uvm_phase phase);

`uvm_info("WRITE_DRIVER", "This is run_phase", UVM_LOW)

@(vif.wr_drv_cb);
vif.wr_drv_cb.reset <= 1'b1;
 @(vif.wr_drv_cb);
vif.wr_drv_cb.reset <= 1'b0;

forever begin
seq_item_port.get_next_item(req);
send_to_dut(req);
seq_item_port.item_done();
end
// vif.wr_drv_cb.wenb <= 0;

endtask : run_phase
//---------task to send seq item to dut----------
task send_to_dut(write_xtn trans);
`uvm_info("WRITE_DRIVER", "This is send_to_dut", UVM_LOW)
//wait(vif.wr_drv_cb.full == 0);
 @(vif.wr_drv_cb);
 //vif.wr_drv_cb.reset <= trans.reset;
 if (!vif.wr_drv_cb.full) begin
 vif.wr_drv_cb.wenb <= trans.wenb;
vif.wr_drv_cb.din  <= trans.din;
end else begin
`uvm_info("WRITE_DRIVER", "Fifo is full", UVM_LOW)
end

`uvm_info("WRITE_DRIVER", $sformatf("Printing from driver \n %s", trans.sprint()), UVM_LOW)

  endtask

endclass