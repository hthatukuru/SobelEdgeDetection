// $Id: $
// File name:   tb_main_file.sv
// Created:    
// Author:      
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: tb for main_file.sv

`timescale 1ns / 100ps

module tb_main_file();

  localparam SIZE = 4;
	localparam CLK_PERIOD = 10.4;
	localparam DELAY = 1;
	reg		tb_clk;	

	//	Clock generation block
	always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#( CLK_PERIOD / 2.0 );
		tb_clk = 1'b1;
		#( CLK_PERIOD / 2.0 );
	end

  wire clk;
  wire n_rst;
  reg start;
  reg [11:0] width;
  reg [11:0] length;
  reg [7:0] initial_addr_r;
  reg [7:0] initial_addr_w;
  
  integer testcase;
  
  main_file DUT (.clk(tb_clk), .n_rst(tb_n_rst), .start(tb_start), .width(width), .length(length), .initial_addr_r(initial_addr_r), .initial_addr_w(initial_addr_w));
  
  
  initial
  begin
  
    testcase = 0;
    
    @( negedge tb_clk );
    @( negedge tb_clk );
	
	  tb_n_rst = 1'b0;
    tb_start = 1'b1;
    tb_width = 200;
    tb_length = 200;
    tb_initial_addr_r = 0;
    tb_initial_addr_w = 0;


    @( posedge tb_clk );

    
  end
  
  
endmodule
