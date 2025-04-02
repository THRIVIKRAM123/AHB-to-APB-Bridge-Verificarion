//----------------------------------
//----------XTN
//----------------------------------
/*
----------------------------------------------------------------
Name                         Type                    Size  Value
----------------------------------------------------------------
uvm_test_top                 AMBA_test               -     @457 
  envh                       AMBA_env                -     @465 
    ahbh                     AHB_agent_top           -     @488 
      agth                   AHB_agent               -     @504 
        drvh                 AHB_driver              -     @525 
          rsp_port           uvm_analysis_port       -     @542 
          seq_item_port      uvm_seq_item_pull_port  -     @533 
        monh                 AHB_monitor             -     @517 
        seqrh                AHB_sequencer           -     @551 
          rsp_export         uvm_analysis_export     -     @559 
          seq_item_export    uvm_seq_item_pull_imp   -     @665 
          arbitration_queue  array                   0     -    
          lock_queue         array                   0     -    
          num_last_reqs      integral                32    'd1  
          num_last_rsps      integral                32    'd1  
    apbh                     APB_agent_top           -     @496 
      agth                   APB_agent               -     @679 
        drvh                 APB_driver              -     @819 
          rsp_port           uvm_analysis_port       -     @836 
          seq_item_port      uvm_seq_item_pull_port  -     @827 
        monh                 APB_monitor             -     @687 
        seqrh                APB_sequencer 	          -     @696 
          rsp_export         uvm_analysis_export     -     @704 
          seq_item_export    uvm_seq_item_pull_imp   -     @810 
          arbitration_queue  array                   0     -    
          lock_queue         array                   0     -    
          num_last_reqs      integral                32    'd1  
          num_last_rsps      integral                32    'd1  
  sb                         AMBA_scoreboard         -     @474 
----------------------------------------------------------------


*/
class AHB_xtn extends uvm_sequence_item;
	`uvm_object_utils(AHB_xtn)
rand bit Hresetn;
rand bit [1:0]Htrans;
rand bit Hwrite;
//rand bit HREADY;
rand bit [1:0]Hresp;
rand bit [31:0]Hrdata;
rand bit [31:0]Hwdata;
rand bit [31:0]Haddr;
rand bit [2:0]Hsize;
rand bit [2:0]BURST;	
rand bit [4:0]length;

static int s0 =0;
static int s1 =0;
static int s2 =0;
static int s3 =0;
static int s4 =0;
static int s5 =0;
static int s6 =0;
static int s7 =0;



constraint limitt {BURST dist{1:=3,0:=3,2:=3,3:=3,4:=3,5:=3,6:=3,7:=3};}

constraint limit {Hresetn dist{1:=90,0:=10};}
constraint limit2 {Haddr inside {	[32'h8000_0000 : 32'h8000_03ff],
                                 	[32'h8400_0000 : 32'h8400_03ff],
                                        [32'h8800_0000 : 32'h8800_03ff],
                                        [32'h8c00_0000 : 32'h8c00_03ff]};} // 4 slaves
constraint limit3 {Hsize inside {[0:2]};}
constraint limit4 {	if(Hsize==0) Haddr%1==0;
			if(Hsize==1) Haddr%2==0;
			if(Hsize==2) Haddr%4==0;
			}

constraint limit5 {((Haddr%1024)+(2**Hsize)*length)<=1024;}
//constraint limit6 {Hwrite inside {0};}


extern function void do_print(uvm_printer printer); 
extern function new(string name ="AHB_xtn");

endclass

function AHB_xtn::new(string name ="AHB_xtn");
	super.new(name);
endfunction



function void  AHB_xtn::do_print (uvm_printer printer);
	super.do_print(printer);
if(BURST==0) 	  $display("single transaction \n");
else if(BURST==1)  $display("INCREMENR \n");
else if(BURST==2)  $display("wrapin 4 \n");
else if(BURST==3)  $display("INCREMENT 4 \n");
else if(BURST==4)  $display("wraping 8 \n");
else if(BURST==5)  $display("INCREMENT 8 \n");
else if(BURST==6)  $display("wrap 16 \n");
else if(BURST==7) $display("INCREMENT 16 \n");


    	printer.print_field( "Hresetn", this.Hresetn,	2,UVM_DEC	);
    	printer.print_field( "Htrans", this.Htrans,	2,UVM_DEC	);
    	printer.print_field( "Hwrite", this.Hwrite,	2,UVM_DEC	);
    	printer.print_field( "Hresp", this.Hresp,	2,UVM_DEC	);
    	printer.print_field( "Hrdata", this.Hrdata,	31,UVM_DEC	);
    	printer.print_field( "Hwdata", this.Hwdata,	31,UVM_DEC	);
    	printer.print_field( "Haddr", this.Haddr,	31,UVM_DEC	);
    	printer.print_field( "Hsize", this.Hsize,	3,UVM_DEC	);
    	printer.print_field( "BURST", this.BURST,	4,UVM_DEC	);
    	printer.print_field( "length", this.length,	31,UVM_DEC	);



endfunction



















































