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

	reg [10:0] tb_gx;
	reg [10:0] tb_gy;
	reg tb_start_t_grad;
	reg [7:0] tb_g;	
  
  	integer testcase;
	reg [7:0] tb_expected_g;
  
  
  total_gradient DUT (.gx(tb_gx), .gy(tb_gy), .g(tb_g), .start_t_grad(tb_start_t_grad));
  
  
  initial
  begin
  
  //initialization
	testcase = 0;	
	tb_gx = 0;
	tb_start_t_grad = 1;
	tb_gy = 0;
	tb_expected_g = 0;
	
	#10
 	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);
	  	#10
	testcase = 1;
	tb_gx = 300;
	tb_gy = 400;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 2;
	tb_gx = 129;
	tb_gy = 150;
	tb_start_t_grad = 1;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 3;
	tb_gx = 240;
	tb_gy = 106;
	tb_start_t_grad = 1;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 4;
	tb_gx = 200;
	tb_gy = 95;
	tb_start_t_grad = 1;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 5;
	tb_gx = 213;
	tb_gy = 156;
	tb_start_t_grad = 1;
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
	tb_start_t_grad = 1;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);


	//this if from the horizontal and vertical testbench

	testcase = 7;	
	tb_gx = 0;
	tb_gy = 0;
	tb_start_t_grad = 1;
	tb_expected_g = 0;
	#10
 	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);
	  	#10
	testcase = 8;
	tb_gx = 55;
	tb_gy = 555;
	tb_start_t_grad = 1;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 9;
	tb_gx = 0;
	tb_gy = 0;
	tb_start_t_grad = 1;
	tb_expected_g = 0;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 10;
	tb_gx = 5;
	tb_gy = 405;
	tb_start_t_grad = 1;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 11;
	tb_gx = 71;
	tb_gy = 317;
	tb_start_t_grad = 1;
	tb_expected_g = 255;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	#10
	testcase = 12;
	tb_gx = 71;
	tb_gy = 317;
	tb_start_t_grad = 0;
	tb_expected_g = 0;
	#10
	assert (tb_expected_g == tb_g)
		$info("Correct g value for test case %d!", testcase);
	else
		$error("Incorrect g value for test case %d!", testcase);

	

  
  end
  
  
  
  endmodule
