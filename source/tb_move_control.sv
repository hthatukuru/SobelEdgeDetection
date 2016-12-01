`timescale 1ns / 100ps

module tb_move_control
();
   localparam   CLK_PERIOD = 10;
   localparam	CHECK_DELAY = 1; 
   reg tb_clk;
   reg tb_n_reset;
   
	reg [11:0] tb_width;
	reg [11:0] tb_length;
	reg [7:0] tb_initial_addr_r;
	reg [7:0] tb_initial_addr_w;
	reg tb_start_move;
	reg tb_load_initial;
	reg [7:0]tb_addr_r;
	reg [7:0]tb_addr_w;
	reg [1:0]tb_direction;
	reg tb_all_done;
	reg tb_move_done;	
  
  integer testcase;
	reg [7:0] tb_expected_addr_r;
	reg [7:0] tb_expected_addr_w;
	reg [1:0] tb_expected_direction;
	reg tb_expected_all_done;
	reg tb_expected_move_done;
  
  
  move_control DUT (.clk(tb_clk), .n_reset(tb_n_reset), .width(tb_width), .length(tb_length), .initial_addr_r(tb_initial_addr_r), .initial_addr_w(tb_initial_addr_w), .start_move(tb_start_move), .load_initial(tb_load_initial), .addr_r(tb_addr_r), .addr_w(tb_addr_w), .direction(tb_direction), .all_done(tb_all_done), .move_done(tb_move_done));
   
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
       testcase = 0;
       tb_n_reset = 1;

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
       testcase = 1;
         assert (tb_expected_addr_w == tb_addr_w)
	   $info("Correct initial write address for test case %d!", testcase);
	else
	  $error("Incorrect initial write address for test case %d!", testcase);
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
       tb_expected_addr_w = 1;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 4;
         assert (tb_expected_addr_w == tb_addr_w)
	   $info("Correct write address for test case %d!", testcase);
	else
	  $error("Incorrect write address for test case %d!", testcase); 
       testcase = 5;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct initial direction for test case %d!", testcase);
        else
	  $error("Incorrect initial direction for test case %d!", testcase);
       tb_start_move = 0;
       #20
       testcase = 6;
       tb_start_move = 1;
       tb_expected_addr_r = 102;
       tb_expected_addr_w = 2;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 7;
         assert (tb_expected_addr_w == tb_addr_w)
	   $info("Correct write address for test case %d!", testcase);
	else
	  $error("Incorrect write address for test case %d!", testcase); 
       testcase = 8;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct change direction to up for test case %d!", testcase);
        else
	  $error("Incorrect change direction to up for test case %d!", testcase);    
       tb_start_move = 0;
       #10
       testcase = 9;
       tb_start_move = 1;
       tb_expected_addr_r = 107;
       tb_expected_addr_w = 7;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       testcase = 10;
         assert (tb_expected_addr_w == tb_addr_w)
	   $info("Correct write address for test case %d!", testcase);
	else
	  $error("Incorrect write address for test case %d!", testcase); 
       testcase = 11;
       assert (tb_expected_direction == tb_direction)
	 $info("Correct change direction to up for test case %d!", testcase);
        else
	  $error("Incorrect change direction to up for test case %d!", testcase);         
	  

    end // initial begin
   
endmodule

