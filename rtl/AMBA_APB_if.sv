interface AMBA_APB_if(input bit Hclk);

logic [31:0] Prdata;
logic [4]Pselx;
logic Pwrite;
logic Penable;
logic [31:0] Paddr;
logic [31:0]Pwdata;

 clocking apb_drv_cb @(posedge Hclk);
                default input #1 output #1;
                output Prdata;
                input Penable;
                input Pwrite;
                input Pselx; 
        endclocking

        //APB monitor
        clocking apb_mon_cb @(posedge Hclk);
                default input #1 output #1;
                input Prdata;
                input Penable;
                input Pwrite;
                input Pselx;
                input Paddr;
                input Pwdata;
        endclocking
	//DRIVER and monitor modport:
modport APB_DRIVER (clocking apb_drv_cb);
modport APB_MONITOR (clocking apb_mon_cb);

endinterface 
