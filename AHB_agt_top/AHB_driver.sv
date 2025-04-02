//----------------------------------
//----------   AHB_driver
//----------------------------------
class AHB_driver extends uvm_driver#(AHB_xtn);

`uvm_component_utils(AHB_driver)

virtual AMBA_AHB_if.AHB_DRIVER vif;
AHB_config AHB_m_cfg;


extern function new(string name ="AHB_driver",uvm_component parent);
extern task run_phase(uvm_phase phase);
extern function void build_phase(uvm_phase phase);
extern task send_data(AHB_xtn xtn);
extern function void connect_phase(uvm_phase phase);
endclass

//----------------------- Methodes
function AHB_driver::new(string name ="AHB_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void AHB_driver:: build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(AHB_config)::get(this,"","AHB_config",AHB_m_cfg))
	`uvm_fatal(get_type_name(),"configuration is failing")
endfunction

function void AHB_driver:: connect_phase(uvm_phase phase);
vif=AHB_m_cfg.in0;
endfunction

task AHB_driver::run_phase(uvm_phase phase);

 //Active low reset
        @(vif.ahb_driver);
        vif.ahb_driver.Hresetn <= 1'b0;
        repeat(3) @(vif.ahb_driver);
	vif.ahb_driver.Hresetn <= 1'b1;
       // @(vif.ahb_driver);
forever 
	begin
	
		seq_item_port.get_next_item(req);
		send_data(req);
		seq_item_port.item_done();
	end
endtask

task AHB_driver ::send_data( AHB_xtn xtn);
	while(vif.ahb_driver.Hreadyout===0)
        @(vif.ahb_driver);

        vif.ahb_driver.Hwrite  <= xtn.Hwrite;
        vif.ahb_driver.Htrans <= xtn.Htrans;
        vif.ahb_driver.Hsize   <= xtn.Hsize;
        vif.ahb_driver.Haddr   <= xtn.Haddr;
        vif.ahb_driver.Hburst   <= xtn.BURST;
        vif.ahb_driver.Hreadyin<= 1'b1;	
        @(vif.ahb_driver);
	while(vif.ahb_driver.Hreadyout===0)
       		@(vif.ahb_driver);

	if(xtn.Hwrite===1)
           vif.ahb_driver.Hwdata<=xtn.Hwdata;
	`uvm_info(get_type_name(),$sformatf("xtn %s",xtn.sprint()),UVM_NONE);

endtask
