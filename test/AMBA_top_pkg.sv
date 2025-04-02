package AMBA_top_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

`include "AMBA_df.sv"
`include "APB_config.sv"
`include "AHB_config.sv"
`include "env_config.sv"

`include "APB_xtn.sv"
`include "APB_monitor.sv"
`include "APB_driver.sv"
`include "APB_sequencer.sv"
`include "APB_sequence.sv"
`include "APB_agent.sv"
`include "APB_agent_top.sv"



`include "AHB_xtn.sv"
`include "AHB_monitor.sv"
`include "AHB_driver.sv"
`include "AHB_sequencer.sv"
`include "AHB_sequence.sv"
//`include "ALL_s_AHB_sequence.sv"

`include "AHB_agent.sv"
`include "AHB_agent_top.sv"
`include "AMBA_scoreboard.sv"

`include "AMBA_env.sv"
`include "AMBA_test.sv"



endpackage
