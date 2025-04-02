class AMBA_env extends uvm_env;
`uvm_component_utils(AMBA_env)
AHB_agent_top ahbh;
APB_agent_top apbh;
AMBA_scoreboard sb;

extern function new(string name="AMBA_env",uvm_component parent);
extern function void  build_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);


endclass

function AMBA_env:: new(string name ="AMBA_env",uvm_component parent);
	super.new(name,parent);
endfunction

function void AMBA_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
ahbh=AHB_agent_top::type_id::create("ahbh",this);
apbh=APB_agent_top::type_id::create("apbh",this);
sb= AMBA_scoreboard::type_id::create("sb",this);


endfunction

function void AMBA_env::end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction

function void AMBA_env::connect_phase(uvm_phase phase);
ahbh.agth.monh.monitor_port.connect(sb.fifo_ahb.analysis_export);
apbh.agth.monh.monitor_port.connect(sb.fifo_apb.analysis_export);
endfunction
