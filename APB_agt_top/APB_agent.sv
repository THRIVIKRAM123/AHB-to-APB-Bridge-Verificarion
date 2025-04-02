class APB_agent extends uvm_agent;

`uvm_component_utils(APB_agent);

APB_driver drvh;
APB_monitor monh;
APB_sequencer seqrh;
env_config m_cfg;

extern function  new(string name="APB_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass
function  APB_agent::new(string name="APB_agent",uvm_component parent);
	super.new(name,parent);
endfunction

function void APB_agent:: build_phase(uvm_phase phase);
		
	monh=APB_monitor::type_id::create("monh",this);
if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("APB","fail to get config")
	if(m_cfg.APB_m_cfg.is_active==UVM_ACTIVE)
	begin

	seqrh=APB_sequencer::type_id::create("seqrh",this);
	drvh =APB_driver::type_id::create("drvh",this);
end
endfunction


function void APB_agent:: connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction
