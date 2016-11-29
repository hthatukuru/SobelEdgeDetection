// $Id: $
// File name:   tb_total_gradient.sv
// Created:    
// Author:      
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: tb for total_gradient.sv
`timescale 1ns / 100ps

module tb_total_gradient
();

  reg [7:0] tb_gx;
	reg [7:0] tb_gy;
	reg [7:0] tb_g;	
  
  integer testcase;
	reg [7:0] tb_expected_g;
  
  
  total_gradient 
	DUT
	(.gx(tb_gx), .gy(tb_gy), .g(tb_g));
  
  
  initial
  begin
  
  //initialization
	testcase = 0;	
	tb_gx = 0;
	tb_gy = 0;
	tb_expected_g = 0;
	#10
  assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);
  
  end
  
  
  
  endmodule
