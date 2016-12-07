`timescale 1ns / 100ps

module tb_move_control
();
   localparam   CLK_PERIOD = 10;
   localparam	CHECK_DELAY = 1; 
   reg tb_clk;
   reg tb_n_reset;
   
   reg [11:0] tb_width;
   reg [11:0] tb_length;
   reg [7:0]  tb_initial_addr_r;
   reg [7:0]  tb_initial_addr_w;
   reg 		  tb_start_move;
   reg 		  start_write;
   
   reg 		  start_i_read;
   
   reg 		  start_9_read;
   
   reg 		  tb_load_initial;
   reg [7:0] 	  tb_addr_r;
   reg [7:0] 	  tb_addr_w;
   reg [1:0] 	  tb_direction;
   reg 		  tb_all_done;
   reg 		  tb_move_done;
   reg 		  tb_load_done;
  
  integer testcase;
	reg [7:0] tb_expected_addr_r;
	reg [7:0] tb_expected_addr_w;
	reg [1:0] tb_expected_direction;
	reg tb_expected_all_done;
	reg tb_expected_move_done;
	reg tb_expected_load_done;
  
  
  move_control DUT (.clk(tb_clk), .n_reset(tb_n_reset), .width(tb_width), .length(tb_length), .initial_addr_r(tb_initial_addr_r), .initial_addr_w(tb_initial_addr_w), .start_move(tb_start_move), .start_write(tb_start_write), .start_i_read(tb_start_i_read), .start_9_read(tb_start_9_read), .load_initial(tb_load_initial), .addr_r(tb_addr_r), .addr_w(tb_addr_w), .direction(tb_direction), .all_done(tb_all_done), .move_done(tb_move_done), .load_done(tb_load_done));
   
  	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
  
  initial
    begin
  
  //initialization
       testcase = 1;
       tb_n_reset = 1;
       #1
       tb_width = 5;
       tb_length = 5;
       tb_initial_addr_r = 100;
       tb_initial_addr_w = 0;
       tb_start_move = 0;
       tb_load_initial = 1;
       tb_expected_addr_r = 100;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;
       tb_expected_all_done = 0;
       tb_expected_move_done = 0;
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct initial read address for test case %d!", testcase);
	else
	  $error("Incorrect initial read address for test case %d!", testcase);
       testcase = 2;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct initial direction for test case %d!", testcase);
        else
	  $error("Incorrect initial direction for test case %d!", testcase);
     
       #10
       testcase = 3;
       tb_load_initial = 0;
       tb_start_move = 1;
       tb_expected_addr_r = 101;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 4;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);
       
       tb_start_move = 0;
       #20
       testcase = 5;
       tb_start_move = 1;
       tb_expected_addr_r = 102;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 6;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct change direction to up for test case %d!", testcase);
        else
	  $error("Incorrect change direction to up for test case %d!", testcase);   
 
       tb_start_move = 0;
       #10
       testcase = 7;
       tb_start_move = 1;
       tb_expected_addr_r = 107;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 8;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct change direction to left for test case %d!", testcase);
        else
	  $error("Incorrect change direction to left for test case %d!", testcase);  
       #10
       testcase = 9;
       tb_start_move = 1;
       tb_expected_addr_r = 106;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 10;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);
       #10
       testcase = 11;
       tb_start_move = 1;
       tb_expected_addr_r = 105;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 12;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct change direction to up for test case %d!", testcase);
        else
	  $error("Incorrect change direction to up for test case %d!", testcase);
       #10
       testcase = 13;
       tb_start_move = 1;
       tb_expected_addr_r = 110;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 14;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct change direction to right for test case %d!", testcase);
        else
	  $error("Incorrect change direction to right for test case %d!", testcase);  
       #10
       testcase = 15;
       tb_start_move = 1;
       tb_expected_addr_r = 111;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 16;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);
       #10
       testcase = 17;
       tb_start_move = 1;
       tb_expected_addr_r = 112;
       tb_expected_direction = 2'b11;
       tb_expected_all_done = 1;
       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 18;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct change direction to up for test case %d!", testcase);
        else
	  $error("Incorrect change direction to up for test case %d!", testcase);
       #10
       testcase = 19;
       assert (tb_expected_all_done == tb_all_done)
	 $info("Correct all done flag for test case %d!", testcase);
        else
	  $error("Incorrect all done flag for test case %d!", testcase);    	  

    end // initial begin
   
endmodule

