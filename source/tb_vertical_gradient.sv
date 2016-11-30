// $Id: $
// File name:   tb_vertical_gradient.sv
// Created:     4/22/2016
// Author:   
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: tb for vertical_gradient.sv
`timescale 1ns / 100ps

module tb_vertical_gradient ();
  
  reg [7:0] tb_windowBuffer[0:8];
  reg tb_start_calculations;
  reg [10:0] tb_expected_gy;
  reg [10:0] tb_gy;
  integer testcase;
  
  
  vertical_gradient DUT (.windowBuffer(tb_windowBuffer) , .start_calculations(tb_start_calculations), .gy(tb_gy));
  
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
    tb_expected_gy = 0;
    #10
    assert (tb_expected_gy == tb_gy)
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
    tb_expected_gy = 55;
    #10
    assert (tb_expected_gy == tb_gy)
		  $info("Correct gx value for test case %d!", testcase);
	  else
		  $error("Incorrect gx value for test case %d!", testcase);
    
    //testcase 2
    testcase = 2;
    tb_windowBuffer[0] = 255;
    tb_windowBuffer[1] = 255;
    tb_windowBuffer[2] = 255;
    tb_windowBuffer[3] = 255;
    tb_windowBuffer[4] = 255;
    tb_windowBuffer[5] = 255;
    tb_windowBuffer[6] = 255;
    tb_windowBuffer[7] = 255;
    tb_windowBuffer[8] = 255;
   
    tb_start_calculations = 1;
    tb_expected_gy = 0;
    #10
    assert (tb_expected_gy == tb_gy)
		  $info("Correct gx value for test case %d!", testcase);
	  else
		  $error("Incorrect gx value for test case %d!", testcase);

    //testcase 3
    testcase = 3;
    tb_windowBuffer[0] = 255;
    tb_windowBuffer[1] = 255;
    tb_windowBuffer[2] = 0;
    tb_windowBuffer[3] = 155;
    tb_windowBuffer[4] = 255;
    tb_windowBuffer[5] = 205;
    tb_windowBuffer[6] = 255;
    tb_windowBuffer[7] = 255;
    tb_windowBuffer[8] = 5;
   
    tb_start_calculations = 1;
    tb_expected_gy = 5;
    #10
    assert (tb_expected_gy == tb_gy)
		  $info("Correct gx value for test case %d!", testcase);
	  else
		  $error("Incorrect gx value for test case %d!", testcase);
    
    
    //testcase 4
    testcase = 4;
    tb_windowBuffer[0] = 40;
    tb_windowBuffer[1] = 255;
    tb_windowBuffer[2] = 32;
    tb_windowBuffer[3] = 255;
    tb_windowBuffer[4] = 255;
    tb_windowBuffer[5] = 100;
    tb_windowBuffer[6] = 0;
    tb_windowBuffer[7] = 255;
    tb_windowBuffer[8] = 1;
   
    tb_start_calculations = 1;
    tb_expected_gy = 71;
    #10
    assert (tb_expected_gy == tb_gy)
		  $info("Correct gx value for test case %d!", testcase);
	  else
		  $error("Incorrect gx value for test case %d!", testcase);
    
    
    //testcase 5
    testcase = 5;
    tb_windowBuffer[0] = 255;
    tb_windowBuffer[1] = 255;
    tb_windowBuffer[2] = 255;
    tb_windowBuffer[3] = 255;
    tb_windowBuffer[4] = 255;
    tb_windowBuffer[5] = 255;
    tb_windowBuffer[6] = 255;
    tb_windowBuffer[7] = 255;
    tb_windowBuffer[8] = 255;
   
    tb_start_calculations = 0;
    tb_expected_gy = 71;
    #10
    assert (tb_expected_gy == tb_gy)
		  $info("Correct gx value for test case %d!", testcase);
	  else
		  $error("Incorrect gx value for test case %d!", testcase);
    
  end
endmodule
