class AMBA_scoreboard extends uvm_scoreboard;
`uvm_component_utils(AMBA_scoreboard)

	uvm_tlm_analysis_fifo #(AHB_xtn) fifo_ahb;
	uvm_tlm_analysis_fifo #(APB_xtn) fifo_apb;

 	AHB_xtn AHB_data;
	APB_xtn APB_data;

	AHB_xtn AHB_cov;
	APB_xtn APB_cov;

	int data_verified_count=0;
	int data_match=0;
	int data_match_miss=0;
	int addr_match=0;
	int addr_match_miss=0;




	covergroup cov_1;
		option.per_instance = 1;

		
		SIZE: coverpoint AHB_cov.Hsize {bins b2[] = {[0:2]} ;}//1,2,4 bytes of data
		
		TRANS: coverpoint AHB_cov.Htrans {bins trans[] = {[2:3]} ;}//NS and S
	
		ADDR: coverpoint AHB_cov.Haddr {bins first_slave = {[32'h8000_0000:32'h8000_03ff]} ;
						     bins second_slave = {[32'h8400_0000:32'h8400_03ff]};
                                                     bins third_slave = {[32'h8800_0000:32'h8800_03ff]};
                                                     bins fourth_slave = {[32'h8C00_0000:32'h8C00_03ff]};}

           	WRITE : coverpoint AHB_cov.Hwrite;
		SIZEXWRITE: cross SIZE, WRITE,ADDR;

	endgroup

	covergroup cov_2;
		option.per_instance=1;

		ADDR : coverpoint APB_cov.Paddr {bins first_slave = {[32'h8000_0000:32'h8000_03ff]};
                                                      bins second_slave = {[32'h8400_0000:32'h8400_03ff]};
                                                      bins third_slave = {[32'h8800_0000:32'h8800_03ff]};
                                                      bins fourth_slave = {[32'h8C00_0000:32'h8C00_03ff]};}

                WRITE : coverpoint APB_cov.Pwrite;

                SEL : coverpoint APB_cov.Pselx {bins first_slave = {4'b0001};
                                                     bins second_slave = {4'b0010};
                                                     bins third_slave = {4'b0100};
                                                     bins fourth_slave = {4'b1000};}
		WRITE_SEL: cross WRITE, SEL,ADDR;


	endgroup





function new(string name="AMBA_scoreboard",uvm_component parent);
super.new(name,parent);
	cov_1=new();
	cov_2=new();
	APB_cov=new();
	AHB_cov=new();
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	fifo_ahb =new("fifo_ahb",this);
	fifo_apb =new("fifo_apb",this);
endfunction

task run_phase(uvm_phase phase);
super.run_phase(phase);
forever
	begin
		fifo_ahb.get(AHB_data);		
		fifo_apb.get(APB_data);
		APB_cov=APB_data;
		AHB_cov=AHB_data;
		cov_2.sample();
		cov_1.sample();
		`uvm_info(get_type_name(),$sformatf("AHB_data %s",AHB_data.sprint()),UVM_NONE);
		`uvm_info(get_type_name(),$sformatf("APB_data %s",APB_data.sprint()),UVM_NONE);
		compair(AHB_data,APB_data);
	end
endtask

task compair(AHB_xtn AHB_data ,APB_xtn APB_data );
if(AHB_data.Hwrite==1)
begin
	case(AHB_data.Hsize)
	2'b00:
	begin
		
                        if(AHB_data.Haddr[1:0] == 2'b00)
                                compare_data(AHB_data.Hwdata[7:0], APB_data.Pwdata[7:0], AHB_data.Haddr, APB_data.Paddr);
                        if(AHB_data.Haddr[1:0] == 2'b01)
                                compare_data(AHB_data.Hwdata[15:8], APB_data.Pwdata[15:8], AHB_data.Haddr, APB_data.Paddr);
                        if(AHB_data.Haddr[1:0] == 2'b10)
                                compare_data(AHB_data.Hwdata[23:16], APB_data.Pwdata[23:16], AHB_data.Haddr, APB_data.Paddr);
			//if(AHB_data.Haddr[1:0] == 2'b11)
else
                                compare_data(AHB_data.Hwdata[31:24], APB_data.Pwdata[31:24], AHB_data.Haddr, APB_data.Paddr);
	end
	2'b01:
        begin
                        if(AHB_data.Haddr[1:0] == 2'b00)
                                compare_data(AHB_data.Hwdata[15:0], APB_data.Pwdata[15:0], AHB_data.Haddr, APB_data.Paddr);
                        if(AHB_data.Haddr[1:0] == 2'b10)
                                compare_data(AHB_data.Hwdata[31:16], APB_data.Pwdata[31:16], AHB_data.Haddr, APB_data.Paddr);
        end
	2'b10:
                        compare_data(AHB_data.Hwdata,APB_data.Pwdata, AHB_data.Haddr, APB_data.Paddr);

	endcase
	end
else
begin
	case(AHB_data.Hsize)
	2'b00:
	begin
		
                        if(AHB_data.Haddr[1:0] == 2'b00)
                                compare_data(AHB_data.Hwdata[7:0], APB_data.Pwdata[7:0], AHB_data.Haddr, APB_data.Paddr);
                        if(AHB_data.Haddr[1:0] == 2'b01)
                                compare_data(AHB_data.Hwdata[15:8], APB_data.Pwdata[15:8], AHB_data.Haddr, APB_data.Paddr);
                       	if(AHB_data.Haddr[1:0] == 2'b10)
                                compare_data(AHB_data.Hwdata[23:16], APB_data.Pwdata[23:16], AHB_data.Haddr, APB_data.Paddr);
			if (AHB_data.Haddr[1:0] == 2'b11)
                                compare_data(AHB_data.Hwdata[31:24], APB_data.Pwdata[31:24], AHB_data.Haddr, APB_data.Paddr);
	end
	2'b01:
        begin
                        if(AHB_data.Haddr[1:0] == 2'b00)
                                compare_data(AHB_data.Hwdata[15:0], APB_data.Pwdata[15:0], AHB_data.Haddr, APB_data.Paddr);
                        if(AHB_data.Haddr[1:0] == 2'b10)
                                compare_data(AHB_data.Hwdata[31:16], APB_data.Pwdata[15:0], AHB_data.Haddr, APB_data.Paddr);
        end
	2'b10:
                        compare_data(AHB_data.Hwdata,APB_data.Pwdata, AHB_data.Haddr, APB_data.Paddr);

	endcase
		

end	
endtask



function void compare_data(int Hdata, Pdata, Haddr, Paddr);

        if(Haddr == Paddr)
	begin
                $display("Address compared Successfully");
		`uvm_warning(get_type_name(),"Address compared Successfully")    
		$display("HADDR=%h, PADDR=%h", Haddr, Paddr);
		addr_match++;
	end
        else
        begin
		`uvm_error(get_type_name(),"Address compared FAIL")                
		$display("HADDR=%h, PADDR=%h", Haddr, Paddr);
		addr_match_miss++;
               // $finish;
        end

        if(Hdata == Pdata) 
	begin
               // $display("Data compared Successfully");
		`uvm_warning(get_type_name(),"Data compared Successfully")        
		$display("HDATA=%h, PDATA=%h", Hdata, Pdata);
		data_match++;
	end
        else
        begin
               // $display("Data not compared Successfully");
		`uvm_error(get_type_name(),"Data not compared Successfully")      
		$display("HDATA=%h, PDATA=%h", Hdata, Pdata);
		data_match_miss++;

               // $finish;
        end

        data_verified_count ++;
	$display ("Data verified = %d", data_verified_count);
	$display ("data_match = %d", data_match);
	$display ("data_match_miss = %d", data_match_miss);
	$display ("addr_match = %d", addr_match);
	$display ("addr_match_miss = %d", addr_match_miss);
endfunction

endclass


