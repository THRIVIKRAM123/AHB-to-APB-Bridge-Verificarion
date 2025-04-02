//---------------------------------main class
class APB_monitor extends uvm_monitor;
`uvm_component_utils(APB_monitor)
virtual AMBA_APB_if.APB_MONITOR vif;
APB_config APB_m_cfg;
env_config m_cfg;

uvm_analysis_port #(APB_xtn) monitor_port;

extern function new(string name="APB_monitor",uvm_component parent);
extern task run_phase(uvm_phase phase);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task collect_data();

endclass

//---------------------------------------all methodes

function void APB_monitor::build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db#(APB_config)::get(this,"","APB_config",APB_m_cfg))
	`uvm_fatal(get_type_name(),"configuration is failing")

endfunction

function void APB_monitor:: connect_phase(uvm_phase phase);
vif = APB_m_cfg.in1;
endfunction


function APB_monitor::new(string name= "APB_monitor",uvm_component parent);
	super.new(name,parent);
monitor_port =new("monitor_port",this);
endfunction

task APB_monitor::run_phase(uvm_phase phase);
	super.run_phase(phase);
forever
	collect_data();
endtask

task APB_monitor:: collect_data();
APB_xtn xtn;
xtn = APB_xtn::type_id::create("xtn");
while(vif.apb_mon_cb.Penable===0)
@(vif.apb_mon_cb)
while(vif.apb_mon_cb.Pselx===0)
@(vif.apb_mon_cb)

xtn.Paddr=vif.apb_mon_cb.Paddr;
xtn.Pwrite=vif.apb_mon_cb.Pwrite;
xtn.Pselx=vif.apb_mon_cb.Pselx;
if(vif.apb_mon_cb.Pwrite===1)
xtn.Pwdata=vif.apb_mon_cb.Pwdata;
else
xtn.Prdata=vif.apb_mon_cb.Prdata;

@(vif.apb_mon_cb);
//@(vif.apb_mon_cb);
  	  monitor_port.write(xtn);
//@(vif.apb_mon_cb);

	`uvm_info(get_type_name(),$sformatf("xtn %s",xtn.sprint()),UVM_NONE);



endtask

