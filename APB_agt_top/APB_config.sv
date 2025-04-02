class APB_config extends uvm_object;

`uvm_object_utils(APB_config)

 	is_active_passive is_active;	
	virtual AMBA_APB_if in1;

extern function new(string name="APB_config");

endclass

function APB_config::new(string name="APB_config");
	super.new(name);
endfunction

