//-------------------------------------Basic class
class APB_sequence extends uvm_sequence #(APB_xtn);

`uvm_object_utils(APB_sequence)
extern function new(string name="APB_sequence");

endclass

function APB_sequence::new(string name="APB_sequence");
	super.new(name);
endfunction

//--------------------------------E_class

class E_class extends APB_sequence;

`uvm_object_utils(E_class)
extern function new(string name="E_class");
extern task body();

endclass

function E_class::new(string name="E_class");
	super.new(name);
endfunction

task E_class::body();
//super.body();
req = APB_xtn::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);

endtask

