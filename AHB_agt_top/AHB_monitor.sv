//------------------------------------
//---------------      AHB_monitor
//-----------------------------------
class AHB_monitor extends uvm_monitor;

`uvm_component_utils(AHB_monitor)
AHB_xtn xtn1;

uvm_analysis_port #(AHB_xtn) monitor_port;

virtual AMBA_AHB_if.AHB_MONITOR vif;
env_config m_cfg;
AHB_config AHB_m_cfg;

extern function new(string name="AHB_monitor",uvm_component parent);
extern task collect_data();
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern function void report_phase(uvm_phase phase);


endclass

function void AHB_monitor:: report_phase(uvm_phase phase);
/*$display("S0 ",xtn1.s0);
$display("S1 ",xtn1.s1);
$display("S2 ",xtn1.s2);
$display("S3 ",xtn1.s3);
$display("S4 ",xtn1.s4);
$display("S5 ",xtn1.s5);
$display("S6 ",xtn1.s6);
$display("S7 ",xtn1.s7);
*/
endfunction


function void AHB_monitor::build_phase(uvm_phase phase);
super.build_phase(phase);
xtn1 = AHB_xtn::type_id::create("xtn1");

if(!uvm_config_db#(AHB_config)::get(this,"","AHB_config",AHB_m_cfg))
	`uvm_fatal(get_type_name(),"configuration is failing")

endfunction

function void AHB_monitor:: connect_phase(uvm_phase phase);
vif = AHB_m_cfg.in0;
endfunction

function AHB_monitor:: new(string name ="AHB_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port =new("monitor_port",this);
endfunction

task AHB_monitor::run_phase(uvm_phase phase);
forever collect_data();
endtask

task AHB_monitor:: collect_data();
AHB_xtn xtn;
xtn = AHB_xtn::type_id::create("xtn");
while(vif.ahb_monitor.Hreadyout===0)
	@(vif.ahb_monitor);


while((vif.ahb_monitor.Htrans!==2) && (vif.ahb_monitor.Htrans!==3))
@(vif.ahb_monitor);

xtn.Hwrite = vif.ahb_monitor.Hwrite ;
xtn.Htrans = vif.ahb_monitor.Htrans ;
xtn.Hsize =  vif.ahb_monitor.Hsize  ;
xtn.Haddr =  vif.ahb_monitor.Haddr  ;
xtn.BURST =  vif.ahb_monitor.Hburst ;

@(vif.ahb_monitor);

while(vif.ahb_monitor.Hreadyout===0)//=================hreadyin
	@(vif.ahb_monitor);
while((vif.ahb_monitor.Htrans!==2) && (vif.ahb_monitor.Htrans!==3))
@(vif.ahb_monitor);


if(vif.ahb_monitor.Hwrite==1'b1)
        xtn.Hwdata = vif.ahb_monitor.Hwdata;
else
        xtn.Hrdata = vif.ahb_monitor.Hrdata;
//@(vif.ahb_monitor);
    monitor_port.write(xtn);


`uvm_info(get_type_name(),$sformatf("xtn %s",xtn.sprint()),UVM_NONE);

endtask
