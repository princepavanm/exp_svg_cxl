class ph_tx extends uvm_sequence_item;

  //rand bit [31:0] data;

  `uvm_object_utils_begin(ph_tx)
    //`uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="ph_tx");
    super.new(name);
  endfunction

endclass
