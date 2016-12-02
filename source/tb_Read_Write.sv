`timescale 1ns / 100ps

module tb_Read_Write
();

	reg [7:0] tb_data_r;
	reg [7:0] tb_addr_w_mc;
	reg [7:0] tb_addr_r_mc;
	reg [7:0] tb_data_w;
	reg tb_start_write;
	reg tb_start_read;
	reg tb_busy;
 	reg [7:0] tb_data_w_o;
	reg [7:0] tb_addr_w;
        reg [7:0] tb_addr_r;
        reg [7:0] tb_data_r_o;   
	reg [1:0] tb_instruction;
        reg 	  tb_write_done;        
  
  integer testcase;
	reg [7:0] tb_expected_data_w_o;
	reg [7:0] tb_expected_addr_w;
        reg [7:0] tb_expected_addr_r;
        reg [7:0] tb_expected_data_r_o;   
	reg [1:0] tb_expected_instruction;
        reg 	  tb_expected_write_done;
   
  
  
  Read_Write DUT (.data_r(tb_data_r), .addr_w_mc(tb_addr_w_mc), .addr_r_mc(tb_addr_r_mc), .data_w(tb_data_w), .start_write(tb_start_write), .start_read(tb_start_read), .busy(tb_busy), .addr_r(tb_addr_r), .addr_w(tb_addr_w), .data_w_o(tb_data_w_o), .data_r_o(tb_data_r_o), .instruction(tb_instruction), .write_done(tb_write_done));
   

  
  initial
    begin
  
  //initialization
       testcase = 1;
       #1
	tb_data_r = 200;
	tb_addr_w_mc = 100;
	tb_addr_r_mc = 50;
	tb_data_w = 255;
	tb_start_write = 0;
	tb_start_read = 0;
	tb_busy = 1;
       tb_expected_instruction = 2'b00;
      
       
       #10
         assert (tb_expected_instruction == tb_instruction)
	   $info("Correct initial read address for test case %d!", testcase);
	else
	  $error("Incorrect initial read address for test case %d!", testcase);
       tb_busy = 0;
       
       #10
       testcase = 2;
       tb_start_read = 1;
	tb_expected_data_r_o = 200;
	tb_expected_addr_r = 50;  
	tb_expected_instruction = 2'b01;
       #10
       assert (tb_expected_data_r_o == tb_data_r_o)
	 $info("Correct initial direction for test case %d!", testcase);
        else
	  $error("Incorrect initial direction for test case %d!", testcase);
       assert (tb_expected_instruction == tb_instruction)
	 $info("Correct initial direction for test case %d!", testcase);
        else
	  $error("Incorrect initial direction for test case %d!", testcase);
       #10
       tb_start_read = 0;       

       #10
       testcase = 3;
       tb_start_write = 1;
	tb_expected_data_w_o = 255;
	tb_expected_addr_w = 100;  
	tb_expected_instruction = 2'b10;  
       #10
       assert (tb_expected_data_w_o == tb_data_w_o)
	 $info("Correct initial direction for test case %d!", testcase);
        else
	  $error("Incorrect initial direction for test case %d!", testcase);
       assert (tb_expected_instruction == tb_instruction)
	 $info("Correct initial direction for test case %d!", testcase);
        else
	  $error("Incorrect initial direction for test case %d!", testcase);  
       #10
        tb_start_write = 0;      


    end // initial begin
   
endmodule

