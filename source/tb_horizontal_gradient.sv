// $Id: $
// File name:   tb_horizontal_gradient.sv
// Created:     4/22/2016
// Author:
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: tb for horizontal_gradient.sv
`timescale 1ns / 100ps

module tb_horizontal_gradient ();
  
  reg [7:0] tb_P0;
  reg [7:0] tb_P1;
  reg [7:0] tb_P2;
  reg [7:0] tb_P3;
  reg [7:0] tb_P4;
  reg [7:0] tb_P5;
  reg [7:0] tb_P6;
  reg [7:0] tb_P7;
  reg [7:0] tb_P8;
  reg tb_start_calculations;
  reg [10:0] tb_expected_gx;
  reg [10:0] tb_gx;
  integer testcase;
  
  
  total_horizontal_gradient DUT (.P0(tb_P0), .P1(tb_P1), .P2(tb_P2), .P3(tb_P3), .P4(tb_P4), .P5(tb_P5), .P6(tb_P6), .P7(tb_P7), .P8(tb_P8), .start_calculations(tb_start_calculations), .gx(tb_gx));
  
  initial
  begin
     //initialization
    testcase = 0;
    tb_P0 = 0;
    tb_P1 = 0;
    tb_P2 = 0;
    tb_P3 = 0;
    tb_P4 = 0;
    tb_P5 = 0;
    tb_P6 = 0;
    tb_P7 = 0;
    tb_P8 = 0;
    tb_start_calculations = 1;
    tb_expected_gx = 0;
    #10
 	  assert (tb_expected_g == tb_g)
		  $info("Correct g value for test case %d!", testcase);
	  else
		  $error("Incorrect g value for test case %d!", testcase);
	  #10
    
    //testcase 1
    testcase = 1;
    tb_P0 = 50;
    tb_P1 = 255;
    tb_P2 = 250;
    tb_P3 = 100;
    tb_P4 = 255;
    tb_P5 = 0;
    tb_P6 = 0;
    tb_P7 = 0;
    tb_P8 = 0;
    tb_start_calculations = 1;
    tb_expected_gx = 0;
    #10
 	  assert (tb_expected_g == tb_g)
		  $info("Correct g value for test case %d!", testcase);
	  else
		  $error("Incorrect g value for test case %d!", testcase);
	  #10
    
  end
endmodule
  
  
  
  
