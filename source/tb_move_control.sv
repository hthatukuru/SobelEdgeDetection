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
   reg 		  tb_start_write;
   
   reg 		  tb_start_i_read;
   
   reg 		  tb_start_9_read;
   
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
  
////////////////////////////////////////////////////////////////////initialization/////////////////////////////////////////////////
       testcase = 1;
       tb_n_reset = 1;
       #1
       tb_width = 5;
       tb_length = 5;
       tb_initial_addr_r = 100;
       tb_initial_addr_w = 0;
       tb_start_move = 0;
       tb_start_i_read = 0;
       tb_start_9_read = 0;
       tb_start_write = 0;
       
       tb_load_initial = 1;
       tb_expected_addr_r = 100;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;
       tb_expected_all_done = 0;
       tb_expected_move_done = 0;
       tb_expected_load_done = 1;
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct initial read address for test case %d!", testcase);
	 else
	  $error("Incorrect initial read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct initial direction for test case %d!", testcase);
       else
	 $error("Incorrect initial direction for test case %d!", testcase);
 
///////////////////////////////////////////////////////////////////FIRST 9 PIXEL/////////////////////////////////////////////////      
       #10
       testcase = 2;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 100;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_9_read = 0;       
       #10
       testcase = 3;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 101;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);       

       tb_start_9_read = 0;       
       #10
       testcase = 4;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 102;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);   

       tb_start_9_read = 0;       
       #10
       testcase = 5;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 105;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);   

       tb_start_9_read = 0;       
       #10
       testcase = 6;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 106;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);   

       tb_start_9_read = 0;       
       #10
       testcase = 7;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 107;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);   

       tb_start_9_read = 0;       
       #10
       testcase = 8;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 110;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);   

       tb_start_9_read = 0;       
       #10
       testcase = 9;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 111;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);   

       tb_start_9_read = 0;       
       #10
       testcase = 10;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 112;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);
       
       tb_start_9_read = 0;       
       #10
       testcase = 11;
       tb_load_initial = 0;
       tb_start_9_read = 1;
       tb_expected_addr_r = 102;
       tb_expected_addr_w = 0;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase); 

///////////////////////////////////////////////////////////End of 10 loop (9 pixels and reposition)//////////////////////////////////////////////       
       tb_start_9_read = 0;       
       #10
       testcase = 12;
       tb_load_initial = 0;
       tb_start_write = 1;
       tb_expected_addr_r = 102;
       tb_expected_addr_w = 1;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);             


       tb_start_write = 0;       
       #10
       testcase = 13;
       tb_load_initial = 0;
       tb_start_move = 1;
       tb_expected_addr_r = 102;
       tb_expected_addr_w = 1;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);  

       tb_start_move = 0;       
       #10
       testcase = 14;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 103;
       tb_expected_addr_w = 1;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);   

       tb_start_i_read = 0;       
       #10
       testcase = 15;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 108;
       tb_expected_addr_w = 1;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;       
       #10
       testcase = 16;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 113;
       tb_expected_addr_w = 1;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);  

       tb_start_i_read = 0;       
       #10
       testcase = 17;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 103;
       tb_expected_addr_w = 1;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);    
///////////////////////////////////////////////////////////////////move right 1 done///////////////////////////
       tb_start_i_read = 0;       
       #10
       testcase = 18;
       tb_load_initial = 0;
       tb_start_write = 1;
       tb_expected_addr_r = 103;
       tb_expected_addr_w = 2;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase); 

       tb_start_write = 0;       
       #10
       testcase = 19;
       tb_load_initial = 0;
       tb_start_move = 1;
       tb_expected_addr_r = 103;
       tb_expected_addr_w = 2;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_move = 0;
       #10
       testcase = 20;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 104;
       tb_expected_addr_w = 2;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;  
       #10
       testcase = 21;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 109;
       tb_expected_addr_w = 2;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;
       #10
       testcase = 22;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 114;
       tb_expected_addr_w = 2;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;
       #10
       testcase = 22;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 104;
       tb_expected_addr_w = 2;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);
//////////////////////////////////////////////////////////////move right 2 done/////////////////////////////////
       tb_start_i_read = 0;    
       #10
       testcase = 23;
       tb_load_initial = 0;
       tb_start_write = 1;
       tb_expected_addr_r = 104;
       tb_expected_addr_w = 3;
       tb_expected_direction = 2'b01;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_write = 0; 
       #10
       testcase = 24;
       tb_load_initial = 0;
       tb_start_move = 1;
       tb_expected_addr_r = 104;
       tb_expected_addr_w = 3;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_move = 0;  
       #10
       testcase = 25;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 117;
       tb_expected_addr_w = 3;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;     
       #10
       testcase = 26;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 118;
       tb_expected_addr_w = 3;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;
       #10
       testcase = 27;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 119;
       tb_expected_addr_w = 3;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;        
       #10
       testcase = 25;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 107;
       tb_expected_addr_w = 3;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);
///////////////////////////////////////////////////////////move up 1 done//////////////////////////////////////
       tb_start_i_read = 0;
       #10
       testcase = 26;
       tb_load_initial = 0;
       tb_start_write = 1;
       tb_expected_addr_r = 107;
       tb_expected_addr_w = 8;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_write = 0; 
       #10
       testcase = 27;
       tb_load_initial = 0;
       tb_start_move = 1;
       tb_expected_addr_r = 107;
       tb_expected_addr_w = 8;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

        tb_start_move = 0;  
       #10
       testcase = 28;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 106;
       tb_expected_addr_w = 8;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;     
       #10
       testcase = 29;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 111;
       tb_expected_addr_w = 8;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;
       #10
       testcase = 30;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 116;
       tb_expected_addr_w = 8;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;        
       #10
       testcase = 31;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 106;
       tb_expected_addr_w = 8;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);
////////////////////////////////////////////////////move left 1 done//////////////////////////////////////

       tb_start_i_read = 0;
       #10
       testcase = 32;
       tb_load_initial = 0;
       tb_start_write = 1;
       tb_expected_addr_r = 106;
       tb_expected_addr_w = 7;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_write = 0; 
       #10
       testcase = 33;
       tb_load_initial = 0;
       tb_start_move = 1;
       tb_expected_addr_r = 106;
       tb_expected_addr_w = 7;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

        tb_start_move = 0;  
       #10
       testcase = 34;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 105;
       tb_expected_addr_w = 7;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;     
       #10
       testcase = 35;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 110;
       tb_expected_addr_w = 7;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;
       #10
       testcase = 36;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 115;
       tb_expected_addr_w = 7;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;        
       #10
       testcase = 37;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 105;
       tb_expected_addr_w = 7;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);  
///////////////////////////////////////////////////////////////move left 2 done//////////////////////////////


       tb_start_i_read = 0;
       #10
       testcase = 38;
       tb_load_initial = 0;
       tb_start_write = 1;
       tb_expected_addr_r = 105;
       tb_expected_addr_w = 6;
       tb_expected_direction = 2'b10;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_write = 0; 
       #10
       testcase = 39;
       tb_load_initial = 0;
       tb_start_move = 1;
       tb_expected_addr_r = 105;
       tb_expected_addr_w = 6;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

        tb_start_move = 0;  
       #10
       testcase = 40;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 120;
       tb_expected_addr_w = 6;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;     
       #10
       testcase = 41;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 121;
       tb_expected_addr_w = 6;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;
       #10
       testcase = 42;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 122;
       tb_expected_addr_w = 6;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);

       tb_start_i_read = 0;        
       #10
       testcase = 43;
       tb_load_initial = 0;
       tb_start_i_read = 1;
       tb_expected_addr_r = 112;
       tb_expected_addr_w = 6;
       tb_expected_direction = 2'b11;       
       #10
         assert (tb_expected_addr_r == tb_addr_r)
	   $info("Correct read address for test case %d!", testcase);
	else
	  $error("Incorrect read address for test case %d!", testcase);
       assert (tb_expected_addr_w == tb_addr_w)
	 $info("Correct initial write address for test case %d!", testcase);
       else
	 $error("Incorrect initial write address for test case %d!", testcase);
       assert (tb_expected_direction == tb_direction)
	 $info("Correct direction for test case %d!", testcase);
        else
	  $error("Incorrect direction for test case %d!", testcase);  
       tb_start_i_read = 0;              
    end // initial begin
   
endmodule

