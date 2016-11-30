// $Id: $
// File name:   tb_horizontal_gradient.sv
// Created:     4/22/2016
// Author:
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: tb for horizontal_gradient.sv
`timescale 1ns / 100ps

module tb_horizontal_gradient ();
  
  reg [7:0] tb_windowBuffer[0:8];
  reg tb_start_calculations;
  reg [10:0] tb_expected_gx;
  reg [10:0] tb_gx;
  integer testcase;
  
  
  horizontal_gradient DUT (.windowBuffer(tb_windowBuffer) , .start_calculations(tb_start_calculations), .gx(tb_gx));
  
  initial
  begin


	
    //initialization
    testcase = 0;
    tb_windowBuffer[0] = 0;
    tb_windowBuffer[1] = 0;
    tb_windowBuffer[2] = 0;
    tb_windowBuffer[3] = 0;
    tb_windowBuffer[4] = 0;
    tb_windowBuffer[5] = 0;
    tb_windowBuffer[6] = 0;    
    tb_windowBuffer[7] = 0;
    tb_windowBuffer[8] = 0;

    tb_start_calculations = 1;
    tb_expected_gx = 0;
    #10
 	  assert (tb_expected_gx == tb_gx)
		  $info("Correct gx value for test case %d!", testcase);
	  else
		  $error("Incorrect gx value for test case %d!", testcase);
	  #10
    
    //testcase 1
    testcase = 1;
    tb_windowBuffer[0] = 50;
    tb_windowBuffer[1] = 255;
    tb_windowBuffer[2] = 250;
    tb_windowBuffer[3] = 100;
    tb_windowBuffer[4] = 0;
    tb_windowBuffer[5] = 200;
    tb_windowBuffer[6] = 100;
    tb_windowBuffer[7] = 255;
    tb_windowBuffer[8] = 255;
   
    tb_start_calculations = 1;
    tb_expected_gx = 555;
    #10
 	  assert (tb_expected_gx == tb_gx)
		  $info("Correct gx value for test case %d!", testcase);
	  else
		  $error("Incorrect gx value for test case %d!", testcase);
    
  end
endmodule
  
  
  
  
