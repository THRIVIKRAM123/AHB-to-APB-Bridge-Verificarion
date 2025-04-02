class APB_agent_top extends uvm_env;

`uvm_component_utils(APB_agent_top)
APB_agent agth;


env_config m_cfg;
APB_config APB_m_cfg;

extern function new(string name="APB_agent_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function APB_agent_top::new(string name="APB_agent_top",uvm_component parent);
	super.new(name,parent);
endfunction

function void APB_agent_top::build_phase(uvm_phase phase);
if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
		`uvm_fatal("top_dst","getting config is failing")

agth = APB_agent::type_id::create("agth",this);
uvm_config_db#(APB_config)::set(this,"agth*","APB_config",m_cfg.APB_m_cfg);

endfunction

