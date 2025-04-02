class AMBA_test extends uvm_test;
`uvm_component_utils(AMBA_test)
AMBA_env envh;


bit has_scoreboard=1;
bit has_AHB_agent = 1;
bit has_APB_agent = 1;
env_config m_cfg;
AHB_config AHB_m_cfg;
APB_config APB_m_cfg;



extern function new(string name="AMBA_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass
function AMBA_test::new(string name ="AMBA_test",uvm_component parent);

	super.new(name,parent);

endfunction

function void AMBA_test::build_phase(uvm_phase phase);

envh = AMBA_env::type_id::create("envh",this);

m_cfg = env_config::type_id::create("m_cfg");



//if(has_scoreboard)
//	begin
//		sb= AMBA_scoreboard::type_id::create("sb",this);
//
//	end

if(has_APB_agent)
	begin
		
		APB_m_cfg = APB_config::type_id::create("APB_m_cfg");
		if(!uvm_config_db #(virtual AMBA_APB_if)::get(this,"","vif1",APB_m_cfg.in1))
			`uvm_fatal("AMBA_test","fail to get virtual interface in1")
		APB_m_cfg.is_active = UVM_ACTIVE;
		m_cfg.APB_m_cfg=APB_m_cfg;
	end


if(has_AHB_agent)
	begin	
		AHB_m_cfg = AHB_config::type_id::create("AHB_m_cfg");
		if(!uvm_config_db #(virtual AMBA_AHB_if)::get(this,"","vif0",AHB_m_cfg.in0))
			`uvm_fatal("AMBA_test","fail to get virtual interface in0")
		AHB_m_cfg.is_active = UVM_ACTIVE;
		m_cfg.AHB_m_cfg=AHB_m_cfg;

	end
//uvm_config_db#(virtual AMBA_AHB_if)::set(null,"*","vif0",in0);


uvm_config_db #(env_config)::set(this,"*","env_config",m_cfg);


endfunction






/*

//--------------------------------single
//-------------------------------------
class single_xtn extends AMBA_test;
`uvm_component_utils(single_xtn)
single_sequence  ss_seq;
E_class ES_seq;
extern function new(string name="single_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function single_xtn::new(string name ="single_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void single_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task single_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
repeat(100) begin
        ss_seq=single_sequence::type_id::create("ss_seq");
        ES_seq=E_class::type_id::create("ES_seq");
        ES_seq.start(envh.apbh.agth.seqrh);
        ss_seq.start(envh.ahbh.agth.seqrh);#15;
end
       phase.drop_objection(this);
	end
endtask

*/


//--------------------------------single
//-------------------------------------
class single_xtn extends AMBA_test;
`uvm_component_utils(single_xtn)
single_sequence  ss_seq;
E_class ES_seq;
extern function new(string name="single_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function single_xtn::new(string name ="single_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void single_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task single_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
        ss_seq=single_sequence::type_id::create("ss_seq");
        ES_seq=E_class::type_id::create("ES_seq");
	repeat(10)
        ss_seq.start(envh.ahbh.agth.seqrh);#25;
       // ES_seq.start(envh.apbh.agth.seqrh);#25;
       phase.drop_objection(this);
	end
endtask







//-------------------------------- inc
//-------------------------------------
class INC_xtn extends AMBA_test;
`uvm_component_utils(INC_xtn)
Increment_sequence  si_seq;
E_class ES_seq;

extern function new(string name="INC_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function INC_xtn::new(string name ="INC_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void INC_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task INC_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
	ES_seq=E_class::type_id::create("ES_seq");
        si_seq=Increment_sequence::type_id::create("si_seq");
	repeat(10)
        si_seq.start(envh.ahbh.agth.seqrh);#25;
        //ES_seq.start(envh.apbh.agth.seqrh);#25;
        phase.drop_objection(this);
	end
endtask

 


//--------------------------------4 wrap
//-------------------------------------#15;
class four_wrap_xtn extends AMBA_test;
`uvm_component_utils(four_wrap_xtn)
four_WRAPING_sequence  s4w_seq;
E_class ES_seq;

extern function new(string name="four_wrap_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function four_wrap_xtn::new(string name ="four_wrap_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void four_wrap_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task four_wrap_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
	ES_seq=E_class::type_id::create("ES_seq");
        s4w_seq=four_WRAPING_sequence::type_id::create("s4w_seq");
	repeat(10)
        s4w_seq.start(envh.ahbh.agth.seqrh);#25
        //ES_seq.start(envh.apbh.agth.seqrh);#25;

        phase.drop_objection(this);
	end
endtask















//--------------------------------4 inc
//-------------------------------------
class four_INC_xtn extends AMBA_test;
`uvm_component_utils(four_INC_xtn)
four_Increment_sequence  s4_seq;
E_class ES_seq;

extern function new(string name="four_INC_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function four_INC_xtn::new(string name ="four_INC_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void four_INC_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task four_INC_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
	ES_seq=E_class::type_id::create("ES_seq");
        s4_seq=four_Increment_sequence::type_id::create("s4_seq");
	repeat(10)
        s4_seq.start(envh.ahbh.agth.seqrh);#25
      //  ES_seq.start(envh.apbh.agth.seqrh);#25;

        phase.drop_objection(this);
	end
endtask


//--------------------------------8 wrap
//-------------------------------------
class eight_wrap_xtn extends AMBA_test;
`uvm_component_utils(eight_wrap_xtn)
eight_WRAPING_sequence  s8w_seq;
E_class ES_seq;

extern function new(string name="eight_wrap_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function eight_wrap_xtn::new(string name ="eight_wrap_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void eight_wrap_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task eight_wrap_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
        s8w_seq=eight_WRAPING_sequence::type_id::create("s8w_seq");
	ES_seq=E_class::type_id::create("ES_seq");
	repeat(10)
        s8w_seq.start(envh.ahbh.agth.seqrh);#25;
       // ES_seq.start(envh.apbh.agth.seqrh);#25;

        phase.drop_objection(this);
	end
endtask







//--------------------------------8 inc
//-------------------------------------
class eight_INC_xtn extends AMBA_test;
`uvm_component_utils(eight_INC_xtn)
eight_Increment_sequence  s8_seq;
E_class ES_seq;

extern function new(string name="eight_INC_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function eight_INC_xtn::new(string name ="eight_INC_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void eight_INC_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task eight_INC_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
        s8_seq=eight_Increment_sequence::type_id::create("s8_seq");
	ES_seq=E_class::type_id::create("ES_seq");
	repeat(10)
        s8_seq.start(envh.ahbh.agth.seqrh);#25;
      //  ES_seq.start(envh.apbh.agth.seqrh);#25;


        phase.drop_objection(this);
	end
endtask



//--------------------------------16 wrap
//-------------------------------------
class wrap16_xtn extends AMBA_test;
`uvm_component_utils(wrap16_xtn)
WRAPING16_sequence  s16w_seq;
E_class ES_seq;

extern function new(string name="wrap16_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function wrap16_xtn::new(string name ="wrap16_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void wrap16_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task wrap16_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
        s16w_seq=WRAPING16_sequence::type_id::create("s16w_seq");
	ES_seq=E_class::type_id::create("ES_seq");
	repeat(10)
        s16w_seq.start(envh.ahbh.agth.seqrh);#25;
        //ES_seq.start(envh.apbh.agth.seqrh);#25;

        phase.drop_objection(this);
	end
endtask





//--------------------------------16 inc
//-------------------------------------
class INC16_xtn extends AMBA_test;
`uvm_component_utils(INC16_xtn)
Increment16_sequence  s16_seq;
E_class ES_seq;

extern function new(string name="INC16_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function INC16_xtn::new(string name ="INC16_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void INC16_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task INC16_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
        s16_seq=Increment16_sequence::type_id::create("s16_seq");
	ES_seq=E_class::type_id::create("ES_seq");
	repeat(10)
        s16_seq.start(envh.ahbh.agth.seqrh);#15;
       // ES_seq.start(envh.apbh.agth.seqrh);#25;


        phase.drop_objection(this);
	end
endtask


//--------------------------------16 inc_bussy
//-------------------------------------
class INC16_bussy_xtn extends AMBA_test;
`uvm_component_utils(INC16_bussy_xtn)
Increment16B_sequence  s16B_seq;
E_class ES_seq;

extern function new(string name="INC16_bussy_xtn",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function INC16_bussy_xtn::new(string name ="INC16_bussy_xtn",uvm_component parent);
	super.new(name,parent);
endfunction

function void INC16_bussy_xtn:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task INC16_bussy_xtn:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
        s16B_seq=Increment16B_sequence::type_id::create("s16B_seq");
	ES_seq=E_class::type_id::create("ES_seq");
	repeat(10)
        s16B_seq.start(envh.ahbh.agth.seqrh);#15;
       // ES_seq.start(envh.apbh.agth.seqrh);#25;

        phase.drop_objection(this);
	end
endtask











//--------------------------------IDLE
//-------------------------------------
class IDLE_SEQ extends AMBA_test;
`uvm_component_utils(IDLE_SEQ)
idle_SEQ  seq;
E_class ES_seq;

extern function new(string name="IDLE_SEQ",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function IDLE_SEQ::new(string name ="IDLE_SEQ",uvm_component parent);
	super.new(name,parent);
endfunction

function void IDLE_SEQ:: build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task IDLE_SEQ:: run_phase(uvm_phase phase);
	begin
  	phase.raise_objection(this);
        seq=idle_SEQ::type_id::create("seq");
	ES_seq=E_class::type_id::create("ES_seq");
	repeat(10)
        seq.start(envh.ahbh.agth.seqrh);#15;
       // ES_seq.start(envh.apbh.agth.seqrh);#25;

        phase.drop_objection(this);
	end
endtask





