class APB_sequencer extends uvm_sequencer#(APB_xtn);

`uvm_component_utils(APB_sequencer)
extern function new(string name="APB_sequencer",uvm_component parent);

endclass

function APB_sequencer::new(string name="APB_sequencer",uvm_component parent);
	super.new(name,parent);
endfunction


