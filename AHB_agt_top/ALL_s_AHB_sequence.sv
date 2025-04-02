//----------------------------------------------
//----------------AHB_sequence
//--------------------------------------------

class ALL_s_AHB_sequence extends uvm_sequence #(AHB_xtn);
bit [31:0]HHaddr;
bit [3] HHsize;
bit [3] HBURST;	
bit  HHwrite;
bit [5] Hlength;
bit [31:0] HHrdata ;
bit [31:0] HHwdata ;


`uvm_object_utils(ALL_s_AHB_sequence)
extern function new(string name="ALL_s_AHB_sequence");
extern task body();
endclass

function ALL_s_AHB_sequence::new(string name="ALL_s_AHB_sequence");
	super.new(name);
endfunction

task ALL_s_AHB_sequence::body();
//super.body();
endtask

//----------------------------------------------
//---------------  single transaction
//--------------------------------------------

class single_sequence extends ALL_s_AHB_sequence;

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
assert(req.randomize() with {Htrans==2;});
HHaddr=req.Haddr;
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;
HHrdata =req.Hrdata;
HHwdata =req.Hwdata;	
	
finish_item(req);
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//Single
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
if(HBURST==000)
begin
		req.s0++;

	repeat(1)
		begin
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
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//inc
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
else if(HBURST==001)
begin
		req.s1++;
	repeat(Hlength)
		begin
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
				HHsize = req.Hsize;
				HBURST =req.BURST;
				HHwrite =req.Hwrite;
				Hlength =req.length;	  		
	  	finish_item(req);
	end
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//WRAP 4
//||| |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
else if(HBURST==010)
begin
		req.s2++;
	repeat(3)
	begin
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
		HHsize = req.Hsize;
		HBURST =req.BURST;
		HHwrite =req.Hwrite;		
		finish_item(req);
	end
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//INC 4
//||| |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
else if(HBURST==011)
begin
		req.s3++;
	repeat(3)
	begin
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
		HHsize = req.Hsize;
		HBURST =req.BURST;
		HHwrite =req.Hwrite;
	  finish_item(req);
	end
end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

//WRAP 8
//||| |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
else if(HBURST==100)
begin
		req.s4++;

	repeat(7)
	begin
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
		HHsize = req.Hsize;
		HBURST =req.BURST;
		HHwrite =req.Hwrite;	
  	finish_item(req);
end

end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

//INC 8
//||| |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
else if(HBURST==101)
begin
		req.s5++;

repeat(7)
begin
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
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;
  		
  finish_item(req);
end


end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
// WRAP 16
//||| |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
else if(HBURST==110)
begin
		req.s6++;

repeat(15)
begin
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
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;
  		
  finish_item(req);
end

end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
// INC 16
//||| |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
else if(HBURST==111)
begin
		req.s7++;

repeat(14)
begin
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
HHsize = req.Hsize;
HBURST =req.BURST;
HHwrite =req.Hwrite;
  		
  finish_item(req);
end

end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||





endtask



