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
	  	#10
	testcase = 1;
	tb_gx = 3;
	tb_gy = 4;
	tb_expected_g = 5;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 2;
	tb_gx = 12;
	tb_gy = 13;
	tb_expected_g = 17;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 3;
	tb_gx = 24;
	tb_gy = 106;
	tb_expected_g = 108;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 4;
	tb_gx = 200;
	tb_gy = 95;
	tb_expected_g = 221;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 5;
	tb_gx = 213;
	tb_gy = 156;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 6;
	tb_gx = 255;
	tb_gy = 255;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

  
  end
  
  
  
  endmodule
