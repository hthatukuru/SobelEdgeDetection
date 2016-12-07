`timescale 1ns / 100ps

module tb_windowBuffer ();

	//	Default Config Test Variables and Constants
	localparam SIZE = 4;
	localparam CLK_PERIOD = 10.4;
	localparam DELAY = 1;
	reg		tb_clk;	

	//	Clock generation block
	always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#( CLK_PERIOD / 2.0 );
		tb_clk = 1'b1;
		#( CLK_PERIOD / 2.0 );
	end

  	reg tb_n_rst;
	reg tb_start_shift;
	reg tb_start_read;
	reg [1:0] tb_shift_direc;
	reg [7:0] tb_data_r;
	// reg [7:0] tb_windowBufferIn[0:8];
	reg tb_read_done;
	reg tb_shift_done;
	reg [7:0] tb_windowBuffer[0:8];
	reg [3:0] tb_countOut;

	reg tb_expected_read_done;
	reg tb_expected_shift_done;
	reg [7:0] tb_expected_windowBuffer[0:8];

	integer testcase;
	integer i;

	windowBuffer DUT ( 
		.n_rst(tb_n_rst),
		.clk(tb_clk),
		.start_shift(tb_start_shift),
		.start_read(tb_start_read),
		.shift_direc(tb_shift_direc),
		.data_r(tb_data_r),
		.read_done(tb_read_done),
		.shift_done(tb_shift_done),
		.windowBufferOut(tb_windowBuffer)
	);
  
  initial
  begin

	testcase = 0;

	// RESET
	@( negedge tb_clk );
	tb_n_rst = 1'b0;
	@( negedge tb_clk );
	tb_n_rst = 1'b1;

	@( negedge tb_clk );
	// READ 9 PIXELS
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd6;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'd6, 8'dx, 8'dx};

	#100
	assert (tb_expected_windowBuffer[6] == tb_windowBuffer[6])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	#100

	@( negedge tb_clk );
	tb_n_rst = 1'b1;

	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd7;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'd6, 8'd7, 8'dx};

	#100
	assert (tb_expected_windowBuffer[7] == tb_windowBuffer[7])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	#100

	@( negedge tb_clk );
	tb_n_rst = 1'b1;
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd8;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'd6, 8'd7, 8'd8};

	#100
	assert (tb_expected_windowBuffer[8] == tb_windowBuffer[8])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	#100

	@( negedge tb_clk );
	tb_n_rst = 1'b1;
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd3;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'd3, 8'dx, 8'dx, 8'd6, 8'd7, 8'd8};

	#100
	assert (tb_expected_windowBuffer[3] == tb_windowBuffer[3])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	#100

	@( negedge tb_clk );
	tb_n_rst = 1'b1;
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd4;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'd3, 8'd4, 8'dx, 8'd6, 8'd7, 8'd8};

	#100
	assert (tb_expected_windowBuffer[4] == tb_windowBuffer[4])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	#100
	@( negedge tb_clk );
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd5;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8};

	#100
	assert (tb_expected_windowBuffer[5] == tb_windowBuffer[5])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	#100
	@( negedge tb_clk );
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd0;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'd0, 8'dx, 8'dx, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8};

	#100
	assert (tb_expected_windowBuffer[0] == tb_windowBuffer[0])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	#100
	@( negedge tb_clk );
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd1;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'd0, 8'd1, 8'dx, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8};

	#100
	assert (tb_expected_windowBuffer[1] == tb_windowBuffer[1])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	#100
	@( negedge tb_clk );
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd2;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'd0, 8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8};

	#100
	/*
	for(i=0; i < 9; i = i + 1)
	begin
		assert (tb_expected_windowBuffer[i] == tb_windowBuffer[i])
			$info("Correct %d element in window buffer for test case %d!", i, testcase);
		else
			$error("Incorrect %d element in window buffer for test case %d!", i, testcase);
	end
	*/
	testcase++;
/*
--------------------------------------------------------------------------------

    testcase = 0;
    tb_windowBufferIn[0] = 8'b00000000;
    tb_windowBufferIn[1] = 8'b00000001;
    tb_windowBufferIn[2] = 8'b00000011;
    tb_windowBufferIn[3] = 8'b00000000;
    tb_windowBufferIn[4] = 8'b00000001;
    tb_windowBufferIn[5] = 8'b00000011;
    tb_windowBufferIn[6] = 8'b00000000;    
    tb_windowBufferIn[7] = 8'b00000001;
    tb_windowBufferIn[8] = 8'b00000011;

    tb_start_shift = 1;
    tb_start_read = 0;
    tb_shift_direc = 2'b01;
    tb_data_r = 8'b0;

    tb_expected_read_done = 0;
    tb_expected_shift_done = 1;
    tb_expected_windowBuffer = '{8'b00000001, 8'b00000011, 8'b0, 8'b00000001, 8'b00000011, 8'b0, 8'b00000001, 8'b00000011, 8'b0};
    
    #10
    assert (tb_expected_windowBuffer == tb_windowBuffer)
      $info("Correct window buffer for test case %d!", testcase);
    else
      $error("Incorrect window buffer for test case %d!", testcase);
    #10
    
	  
    tb_windowBufferIn = tb_windowBuffer;

    tb_start_shift = 1;
    tb_start_read = 0;
    tb_shift_direc = 2'b01;
    tb_data_r = 8'b0;

    tb_expected_read_done = 0;
    tb_expected_shift_done = 1;
    tb_expected_windowBuffer = '{8'b00000011, 8'b0, 8'b0, 8'b00000011, 8'b0, 8'b0, 8'b00000011, 8'b0, 8'b0};

    
    #10
    assert (tb_expected_windowBuffer == tb_windowBuffer)
      $info("Correct window buffer for test case %d!", testcase);
	  else
      $error("Incorrect window buffer for test case %d!", testcase);


    testcase = 2;
    tb_windowBufferIn = tb_windowBuffer;

    tb_start_shift = 1;
    tb_start_read = 0;
    tb_shift_direc = 2'b10;
    tb_data_r = 8'b0;

    tb_expected_read_done = 0;
    tb_expected_shift_done = 1;
    tb_expected_windowBuffer = '{8'b0, 8'b00000011, 8'b0, 8'b0, 8'b00000011, 8'b0, 8'b0, 8'b00000011, 8'b0};
    
    #10
    assert (tb_expected_windowBuffer == tb_windowBuffer)
      $info("Correct window buffer for test case %d!", testcase);
	  else
      $error("Incorrect window buffer for test case %d!", testcase);
    #10
    
	  
    testcase = 3;
    tb_windowBufferIn = tb_windowBuffer;

    tb_start_shift = 1;
    tb_start_read = 0;
    tb_shift_direc = 2'b11;
    tb_data_r = 8'b0;

    tb_expected_read_done = 0;
    tb_expected_shift_done = 1;
    tb_expected_windowBuffer = '{8'b0, 8'b0, 8'b0, 8'b0, 8'b00000011, 8'b0, 8'b0, 8'b00000011, 8'b0};

    
    #10
    assert (tb_expected_windowBuffer == tb_windowBuffer)
      $info("Correct window buffer for test case %d!", testcase);
	  else
      $error("Incorrect window buffer for test case %d!", testcase);

------------------------------------------------------------------------------------------
*/

  end
endmodule
