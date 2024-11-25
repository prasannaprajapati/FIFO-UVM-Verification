class write_monitor extends uvm_monitor;

`uvm_component_utils(write_monitor);

virtual fifo_wr_if.WR_MON_MP vif;
  write_config my_config;
write_xtn data_sent;

  uvm_analysis_port #(write_xtn) write_port;

//----------------write_monitor--------------
function new(string name = "write_monitor", uvm_component parent);
super.new(name, parent);
write_port = new("write_port", this);
endfunction

//-----------build_phase----------------
  virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info("WRITE_MONITOR", "This is build_phase", UVM_LOW)
if (!uvm_config_db#(write_config)::get(this, "", "write_config", my_config)) 
begin
`uvm_fatal("WRITE_MONITOR", "Set the write_config")
end
endfunction : build_phase


//----------connect_phase----------------
  virtual function void connect_phase(uvm_phase phase);
 super.connect_phase(phase);
 `uvm_info("WRITE_MONITOR", "This is connect_phase", UVM_LOW)
 vif = my_config.vif;
endfunction : connect_phase

//------------run_phase--------------
 virtual task run_phase(uvm_phase phase);
`uvm_info("WRITE_MONITOR", "This is run_phase", UVM_LOW)
 repeat (3) @(vif.wr_mon_cb);
forever begin
collect_data();
    end
  endtask : run_phase

//------collect data from dut to monitor thorugh interface
  virtual task collect_data();

 `uvm_info("WRITE_MONITOR", "This is collect_data", UVM_LOW)

 data_sent = write_xtn::type_id::create("data_sent");

//wait (vif.wr_mon_cb.wenb);

//clock cycle delay
   @(vif.wr_mon_cb);
    data_sent.reset = vif.wr_mon_cb.reset;
    data_sent.wenb = vif.wr_mon_cb.wenb;
    data_sent.din = vif.wr_mon_cb.din;
    data_sent.full = vif.wr_mon_cb.full;

`uvm_info("WRITE_MONITOR", $sformatf("printing from monitor \n %s", data_sent.sprint()),UVM_LOW)

    write_port.write(data_sent);

  endtask


endclass