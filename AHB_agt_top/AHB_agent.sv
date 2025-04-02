//--------------------------------------
//--------------------------AHB_agent
//--------------------------------------

class AHB_agent extends uvm_agent;

`uvm_component_utils(AHB_agent)
AHB_driver 	drvh;
AHB_sequencer  	seqrh;
AHB_monitor	monh;
env_config 	m_cfg; 

extern function new(string name ="AHB_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function AHB_agent::new(string name="AHB_agent",uvm_component parent);
	super.new(name,parent);
endfunction

function void AHB_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);


if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal(get_type_name(),"fail to get config")

	monh=AHB_monitor::type_id::create("monh",this);
	if(m_cfg.AHB_m_cfg.is_active==UVM_ACTIVE)
	begin
		drvh=AHB_driver::type_id::create("drvh",this);
		seqrh=AHB_sequencer::type_id::create("seqrh",this);
	end

endfunction

function void AHB_agent:: connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	drvh.seq_item_port.connect(seqrh.seq_item_export);

endfunction
