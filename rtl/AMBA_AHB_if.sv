interface AMBA_AHB_if(input bit Hclk);

logic Hresetn;
logic [1:0] Htrans;
logic [2:0]Hsize;
logic Hreadyin;
logic [31:0]Hwdata;
logic [31:0]Haddr;
logic Hwrite;
logic [31:0]Hrdata;
logic [1:0]Hresp;
logic Hreadyout;
logic [2:0] Hburst;


clocking ahb_driver@(posedge Hclk);
default input #1 output#1;
output Hresetn;
output Htrans;
output Hsize;
output Hreadyin;
input Hreadyout;
output Hwdata;
output Haddr;
output Hwrite;
input Hrdata;
input Hresp;
output Hburst;
endclocking

clocking ahb_monitor@(posedge Hclk);
default input #1 output#1;
input Hresetn;
input Htrans;
input Hsize;
input Hreadyin;
input Hreadyout;
input Hwdata;
input Haddr;
input Hwrite;
input Hrdata;
input Hresp;
input Hburst;

endclocking


modport AHB_DRIVER(clocking ahb_driver);
modport AHB_MONITOR(clocking ahb_monitor);
endinterface
