//---------------------
//------AHB_agent_top
//--------------------------

class AHB_agent_top extends uvm_env;

`uvm_component_utils(AHB_agent_top)

AHB_agent agth;
env_config m_cfg;
AHB_config AHB_m_cfg;

extern function new(string name ="AHB_agent_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
	endclass

function AHB_agent_top::new(string name="AHB_agent_top",uvm_component parent);
	super.new(name,parent);

endfunction

function void AHB_agent_top::build_phase(uvm_phase phase);
if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("top_dst","getting config is failing")

	agth = AHB_agent::type_id::create("agth",this);
uvm_config_db#(AHB_config)::set(this,"agth*","AHB_config",m_cfg.AHB_m_cfg);

endfunction


