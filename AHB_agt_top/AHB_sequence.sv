//----------------------------------------------
//----------------AHB_sequence
//--------------------------------------------

class AHB_sequence extends uvm_sequence #(AHB_xtn);
bit [31:0]HHaddr;
bit [3] HHsize;
bit [3] HBURST;	
bit  HHwrite;
bit [5] Hlength;
bit [31:0] HHrdata ;
bit [31:0] HHwdata ;


`uvm_object_utils(AHB_sequence)
extern function new(string name="AHB_sequence");
extern task body();
endclass

function AHB_sequence::new(string name="AHB_sequence");
	super.new(name);
endfunction

task AHB_sequence::body();
//super.body();
endtask

//----------------------------------------------
//---------------  single transaction
//--------------------------------------------

class single_sequence extends AHB_sequence;

`uvm_object_utils(single_sequence)
extern function new(string name="single_sequence");
extern task body();
endclass

function single_sequence::new(string name="single_sequence");
	super.new(name);
endfunction

task single_sequence::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==2 && BURST==0;});
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;
HHrdata =req.Hrdata;
HHwdata =req.Hwdata;

finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


repeat(1)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 2'b11;
                                                                                        Haddr == HHaddr;Hrdata==HHrdata;Hwdata==HHwdata;});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 2'b11;
                                                                                        Haddr == HHaddr ;Hrdata==HHrdata;Hwdata==HHwdata;});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 2'b11;
                                                                                        Haddr == HHaddr ;Hrdata==HHrdata;Hwdata==HHwdata;});	
  finish_item(req);
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask






//----------------------------------------------
//---------------  Increment transaction
//--------------------------------------------

class Increment_sequence extends AHB_sequence;

`uvm_object_utils(Increment_sequence)
extern function new(string name="Increment_sequence");
extern task body();
endclass

function Increment_sequence::new(string name="Increment_sequence");
	super.new(name);
endfunction

task Increment_sequence::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==2 && BURST==1;});
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;
Hlength =req.length;	
finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


for (int i =0;i<Hlength-1;i++)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 1;});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite ==HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 2;});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 4;});
			HHaddr=req.Haddr;
  		
  finish_item(req);
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask









//----------------------------------------------
//---------------  WRAP 4
//--------------------------------------------

class four_WRAPING_sequence extends AHB_sequence;

`uvm_object_utils(four_WRAPING_sequence)
extern function new(string name="four_WRAPING_sequence");
extern task body();
endclass

function four_WRAPING_sequence::new(string name="four_WRAPING_sequence");
	super.new(name);
endfunction

task four_WRAPING_sequence::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==2 && BURST==2;});	
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;

finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

repeat(3)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == {HHaddr[31:2],HHaddr[1:0]+1'b1};});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == {HHaddr[31:3],HHaddr[2:1]+1'b1,HHaddr[0]};});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == {HHaddr[31:4],HHaddr[3:2]+1'b1,HHaddr[1:0]};});

HHaddr=req.Haddr;
finish_item(req);
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask















//----------------------------------------------
//---------------  4 Increment transaction
//--------------------------------------------

class four_Increment_sequence extends AHB_sequence;

`uvm_object_utils(four_Increment_sequence)
extern function new(string name="four_Increment_sequence");
extern task body();
endclass

function four_Increment_sequence::new(string name="four_Increment_sequence");
	super.new(name);
endfunction

task four_Increment_sequence::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==2 && BURST==3;});
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;
finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

repeat(3)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 1;});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 2;});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 4;});


  	HHaddr=req.Haddr;
		
  finish_item(req);
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask












//----------------------------------------------
//---------------  WRAP 8
//--------------------------------------------

class eight_WRAPING_sequence extends AHB_sequence;

`uvm_object_utils(eight_WRAPING_sequence)
extern function new(string name="eight_WRAPING_sequence");
extern task body();
endclass

function eight_WRAPING_sequence::new(string name="eight_WRAPING_sequence");
	super.new(name);
endfunction

task eight_WRAPING_sequence::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==2 && BURST==4;});
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;

finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
	

repeat(7)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == {HHaddr[31:3],HHaddr[2:0]+1'b1};});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == {HHaddr[31:4],HHaddr[3:1]+1'b1,HHaddr[0]};});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == {HHaddr[31:5],HHaddr[4:2]+1'b1,HHaddr[1:0]};});

HHaddr=req.Haddr;  		
  finish_item(req);
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask












//----------------------------------------------
//---------------  8 Increment transaction
//--------------------------------------------

class eight_Increment_sequence extends AHB_sequence;

`uvm_object_utils(eight_Increment_sequence)
extern function new(string name="eight_Increment_sequence");
extern task body();
endclass

function eight_Increment_sequence::new(string name="eight_Increment_sequence");
	super.new(name);
endfunction

task eight_Increment_sequence::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==2 && BURST==5;});	
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;

finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


repeat(7)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 1;});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 2;});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 4;});

HHaddr=req.Haddr;
  finish_item(req);
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask
































//----------------------------------------------
//---------------  WRAP 16
//--------------------------------------------

class WRAPING16_sequence extends AHB_sequence;

`uvm_object_utils(WRAPING16_sequence)
extern function new(string name="WRAPING16_sequence");
extern task body();
endclass

function WRAPING16_sequence::new(string name="WRAPING16_sequence");
	super.new(name);
endfunction

task WRAPING16_sequence::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==2 && BURST==6;});	
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;

finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

repeat(15)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == {HHaddr[31:4],HHaddr[3:0]+1'b1};});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == {HHaddr[31:5],HHaddr[4:1]+1'b1,HHaddr[0]};});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == {HHaddr[31:6],HHaddr[5:2]+1'b1,HHaddr[1:0]};});

HHaddr=req.Haddr;

finish_item(req);
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask












//----------------------------------------------
//---------------  16 Increment transaction
//--------------------------------------------

class Increment16_sequence extends AHB_sequence;

`uvm_object_utils(Increment16_sequence)
extern function new(string name="Increment16_sequence");
extern task body();
endclass

function Increment16_sequence::new(string name="Increment16_sequence");
	super.new(name);
endfunction

task Increment16_sequence::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==2 && BURST==7;});
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;

	
finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


repeat(14)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 1;});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 2;});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 4;});

HHaddr=req.Haddr;		
  finish_item(req);
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask








//----------------------------------------------
//---------------  16 Increment transaction with bussy
//--------------------------------------------

class Increment16B_sequence extends AHB_sequence;

`uvm_object_utils(Increment16B_sequence)
extern function new(string name="Increment16B_sequence");
extern task body();
endclass

function Increment16B_sequence::new(string name="Increment16B_sequence");
	super.new(name);
endfunction

task Increment16B_sequence::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==2 && BURST==7;});

finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;	
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==1 && BURST==7;});
	HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;

finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||



repeat(1)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr ;});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr ;});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr ;});

HHaddr=req.Haddr;  		
  finish_item(req);
end


repeat(13)
begin
req = AHB_xtn::type_id::create("req");

  start_item(req);

                        if(HHsize == 0)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 1;});
 			if(HHsize == 1)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 2;});
 			if(HHsize == 2)
                                assert(req.randomize() with {Hsize == HHsize; BURST == HBURST;
                                                                                        Hwrite == HHwrite; Htrans == 3;
                                                                                        Haddr == HHaddr + 4;});

HHaddr=req.Haddr;  		
  finish_item(req);
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask










//----------------------------------------------
//---------------  idle_SEQ
//--------------------------------------------

class idle_SEQ extends AHB_sequence;

`uvm_object_utils(idle_SEQ)
extern function new(string name="idle_SEQ");
extern task body();
endclass

function idle_SEQ::new(string name="idle_SEQ");
	super.new(name);
endfunction

task idle_SEQ::body();
super.body();

req = AHB_xtn::type_id::create("req");
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
start_item(req);
assert(req.randomize() with {Htrans==1 && BURST==7;});
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;
finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
endtask


