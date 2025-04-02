//---------------------------------------main class
class APB_driver extends uvm_driver#(APB_xtn);

virtual AMBA_APB_if.APB_DRIVER vif;
APB_config APB_m_cfg;
 bit [31:0] data;
`uvm_component_utils(APB_driver)
extern function new(string name="APB_driver",uvm_component parent);
extern task run_phase(uvm_phase phase);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task send_data();

endclass


function void APB_driver:: build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(APB_config)::get(this,"","APB_config",APB_m_cfg))
	`uvm_fatal(get_type_name(),"configuration is failing")
endfunction


function void APB_driver:: connect_phase(uvm_phase phase);
super.connect_phase(phase);
vif=APB_m_cfg.in1;
endfunction


function APB_driver::new(string name ="APB_driver",uvm_component parent);
	super.new(name,parent);
endfunction

task APB_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);
forever 
begin

//	seq_item_port.get_next_item(req);
//	$display("(---------------------)");
	send_data();
//	seq_item_port.item_done();

end
endtask

task APB_driver::send_data();

while(vif.apb_drv_cb.Pselx===0)
begin
        @(vif.apb_drv_cb);
end
if(vif.apb_drv_cb.Pwrite===0)
begin
data=$random;//xtn.Prdata;
vif.apb_drv_cb.Prdata<=data;

`uvm_info(get_type_name(),"sending data",UVM_NONE);
//$display("send random data is",vif.apb_drv_cb.Prdata);
end
        @(vif.apb_drv_cb);
      //  @(vif.apb_drv_cb);
endtask


