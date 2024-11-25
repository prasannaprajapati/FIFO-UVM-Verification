
class write_seqs extends uvm_sequence #(write_xtn);

  `uvm_object_utils(write_seqs);

  function new(string name = "write_seqs");
    super.new(name);
  endfunction

  task body();

    `uvm_info("WRITE_SEQS", "This is task body", UVM_LOW)

    repeat (5) begin
      req = write_xtn::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {wenb == 1'b0;});
      finish_item(req);
    end

    req = write_xtn::type_id::create("req");
    start_item(req);
    req.wenb = 0;
    finish_item(req);

  endtask : body

endclass

class low_seqs extends write_seqs;

  `uvm_object_utils(low_seqs)

  task body;

    repeat (5) begin
      req = write_xtn::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {
        wenb == 1'b1;
        din inside {[1 : 85]};
      });
      finish_item(req);
    end

    req = write_xtn::type_id::create("req");
    start_item(req);
    req.wenb = 0;
    finish_item(req);

  endtask

endclass

class medium_seqs extends write_seqs;

  `uvm_object_utils(medium_seqs)

  task body;

    repeat (5) begin
      req = write_xtn::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {
        wenb == 1'b1;
        din inside {[86 : 170]};
      });
      finish_item(req);
    end

    req = write_xtn::type_id::create("req");
    start_item(req);
    req.wenb = 0;
    finish_item(req);

  endtask

endclass

class large_seqs extends write_seqs;

  `uvm_object_utils(large_seqs)

  task body;

    repeat (5) begin
      req = write_xtn::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {
        wenb == 1'b1;
        din inside {[171 : 254]};
      });
      finish_item(req);
    end

    req = write_xtn::type_id::create("req");
    start_item(req);
    req.wenb = 0;
    finish_item(req);

  endtask

endclass

class max_seqs extends write_seqs;

  `uvm_object_utils(max_seqs)

  task body;

    repeat (5) begin
      req = write_xtn::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {
        wenb == 1'b1;
        din == 255;
      });
      finish_item(req);
    end

    req = write_xtn::type_id::create("req");
    start_item(req);
    req.wenb = 0;
    finish_item(req);

  endtask

endclass

class zero_seqs extends write_seqs;

  `uvm_object_utils(zero_seqs)

  task body;

    repeat (5) begin
      req = write_xtn::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {
        wenb == 1'b1;
        din == 0;
      });
      finish_item(req);
    end

    req = write_xtn::type_id::create("req");
    start_item(req);
    req.wenb = 0;
    finish_item(req);

  endtask

endclass

class full_seqs extends write_seqs;

  `uvm_object_utils(full_seqs)

  task body;

    repeat (20) begin
      req = write_xtn::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {wenb == 1'b1;});
      finish_item(req);
    end

    req = write_xtn::type_id::create("req");
    start_item(req);
    req.wenb = 0;
    finish_item(req);

  endtask

endclass

class reset_seqs extends write_seqs;

  `uvm_object_utils(reset_seqs)

  task body;

    repeat (20) begin
      req = write_xtn::type_id::create("req");
      start_item(req);
      assert (req.randomize() with {reset == 1'b1;});
      finish_item(req);
    end

    req = write_xtn::type_id::create("req");
    start_item(req);
    req.wenb = 0;
    finish_item(req);

  endtask

endclass
