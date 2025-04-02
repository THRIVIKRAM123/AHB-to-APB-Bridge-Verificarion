
module AMBA_top;

import uvm_pkg::*;

import AMBA_top_pkg::*;

bit clock;  
always 	#5 clock=~clock;  
AMBA_AHB_if in0(clock);
AMBA_APB_if in1(clock);

rtl_top DUT(
            .Hclk(clock),
            .Hresetn(in0.Hresetn),
            .Htrans(in0.Htrans),
            .Hsize(in0.Hsize),
            .Hreadyin(in0.Hreadyin),
            .Hwdata(in0.Hwdata),
            .Haddr(in0.Haddr),
            .Hwrite(in0.Hwrite),
            .Hrdata(in0.Hrdata),
            .Hresp(in0.Hresp),
            .Hreadyout(in0.Hreadyout),
            .Pselx(in1.Pselx),
            .Pwrite(in1.Pwrite),
            .Penable(in1.Penable),
	    .Prdata(in1.Prdata),
            .Paddr(in1.Paddr),
	    .Pwdata(in1.Pwdata)
            ) ;
initial
begin
$monitor("Pselx is ", in1.Pselx);

end
initial
begin
	
			`ifdef VCS
         		$fsdbDumpvars(0, AMBA_top);
        		`endif	

uvm_config_db#(virtual AMBA_AHB_if)::set(null,"*","vif0",in0);
uvm_config_db#(virtual AMBA_APB_if)::set(null,"*","vif1",in1);


run_test();

end
endmodule

