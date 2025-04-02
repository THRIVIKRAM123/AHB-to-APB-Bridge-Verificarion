class env_config extends uvm_object;

AHB_config AHB_m_cfg; 
APB_config APB_m_cfg;
bit has_scoreboard=1;
bit has_wagent = 1;
bit has_ragent = 1;

`uvm_object_utils(env_config)



function new(string name="env_config");
	super.new(name);
endfunction

endclass

