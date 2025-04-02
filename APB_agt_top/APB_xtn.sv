class APB_xtn extends uvm_sequence_item;
rand bit [31:0] Prdata;
bit [4]Pselx;
bit Pwrite;
bit Penable;
bit [31:0] Paddr;
bit [31:0]Pwdata;

`uvm_object_utils(APB_xtn)
extern function new(string name= "APB_xtn");
extern function void do_print(uvm_printer printer); 

endclass

function APB_xtn::new(string name="APB_xtn");
	super.new(name);
endfunction



function void  APB_xtn::do_print (uvm_printer printer);
	super.do_print(printer);

    	printer.print_field( "Prdata", this.Prdata,	32,UVM_DEC	);
    	printer.print_field( "Pselx", this.Pselx,	4,UVM_DEC	);
    	printer.print_field( "Pwrite", this.Pwrite,	2,UVM_DEC	);
    	printer.print_field( "Penable", this.Penable,	2,UVM_DEC	);
    	printer.print_field( "Paddr", this.Paddr,	31,UVM_DEC	);
    	printer.print_field( "Pwdata", this.Pwdata,	31,UVM_DEC	);
endfunction

