class AHB_config extends uvm_object;
	`uvm_object_utils(AHB_config)
 	is_active_passive is_active;	
	virtual AMBA_AHB_if in0;

extern function new(string name="AHB_config");

endclass

function AHB_config::new(string name="AHB_config");
	super.new(name);
endfunction


