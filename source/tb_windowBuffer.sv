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
	//reg [3:0] tb_countOut;
	reg [3:0] tb_count;
	reg [3:0] tb_count_o;
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
		.windowBufferOut(tb_windowBuffer),
		.count(tb_count),
		.count_o(tb_count_o)
	);
  
  initial
  begin

	testcase = 0;
	
	tb_n_rst = 1'b0;
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd6;
	tb_count = 0;
	
	//#100
	// RESET
	@( negedge tb_clk );
	tb_n_rst = 1'b0;
	@( negedge tb_clk );
	tb_n_rst = 1'b1;

	@( posedge tb_clk );
	// READ 9 PIXELS
	tb_start_shift = 0;
	tb_data_r = 8'd6;
	#5
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	
	tb_count = 0;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
	tb_expected_windowBuffer = '{8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd6, 8'd0, 8'd0};
    	//tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'd6, 8'dx, 8'dx};

	#120
	/*
	assert (tb_expected_windowBuffer[6] == tb_windowBuffer[6])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	//#80
	*/


	@( posedge tb_clk );

	@( posedge tb_clk );

	

	tb_n_rst = 1'b1;
	tb_data_r = 8'd7;
	#5
	/*
	assert (tb_windowBuffer[6][2] == 1'b0 )
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
*/
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	
	tb_count = tb_count_o;
    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	//tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'd6, 8'd7, 8'dx};
	tb_expected_windowBuffer = '{8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd6, 8'd7, 8'd0};

	#80

	@(posedge tb_clk);

	//assert (tb_expected_windowBuffer[7] == tb_windowBuffer[7])
	assert (tb_expected_windowBuffer[6][2] == 1'b1)
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	//#5

	@( posedge tb_clk );
	tb_n_rst = 1'b1;
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd8;
	tb_count = tb_count_o;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	//tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'dx, 8'd6, 8'd7, 8'd8};

	#80

	@(posedge tb_clk);
	assert (tb_expected_windowBuffer[7][2] == 1)
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	//#5

	@( posedge tb_clk );
	tb_n_rst = 1'b1;
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd3;
	tb_count = tb_count_o;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	//tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'd3, 8'dx, 8'dx, 8'd6, 8'd7, 8'd8};

	#80

	@(posedge tb_clk);
	
	//#5

	@( posedge tb_clk );
	tb_n_rst = 1'b1;
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd4;
	tb_count = tb_count_o;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'd3, 8'd4, 8'dx, 8'd6, 8'd7, 8'd8};

	assert (tb_expected_windowBuffer[8][3] == 1)
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	
	#80
	assert (tb_expected_windowBuffer[4] == tb_windowBuffer[4])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	//#100
	@( posedge tb_clk );
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd5;
	tb_count = tb_count_o;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'dx, 8'dx, 8'dx, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8};

	#80

	@(posedge tb_clk);
	assert (tb_expected_windowBuffer[8][0] == 0)
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	//#100
	@( posedge tb_clk );
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd0;
	tb_count = tb_count_o;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'd0, 8'dx, 8'dx, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8};

	#80

	@(posedge tb_clk);
	assert (tb_expected_windowBuffer[5][2] == 1)
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	//#100
	@( posedge tb_clk );
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd1;
	tb_count = tb_count_o;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'd0, 8'd1, 8'dx, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8};

	#80
	assert (tb_expected_windowBuffer[0] == 0)
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);
	//#100
	@( posedge tb_clk );
	tb_start_shift = 0;
    	tb_start_read = 1;
    	tb_shift_direc = 2'b00;
    	tb_data_r = 8'd2;
	tb_count = tb_count_o;

    	tb_expected_read_done = 1;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'd0, 8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8};

	@( posedge tb_clk );
	tb_start_shift = 1;
    	tb_start_read = 0;
    	tb_shift_direc = 2'b01;
    	//tb_data_r = 8'd0;
	tb_count = tb_count_o;

    	tb_expected_read_done = 0;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'd0, 8'dx, 8'dx, 8'd3, 8'd5, 8'd5, 8'd6, 8'd7, 8'd8};

	#10
	assert (tb_expected_windowBuffer[5] == tb_windowBuffer[5])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);

	tb_start_shift = 0;
	#10
	@( posedge tb_clk );
	tb_start_shift = 1;
    	tb_start_read = 0;
    	tb_shift_direc = 2'b10;
    	//tb_data_r = 8'd0;
	tb_count = tb_count_o;

    	tb_expected_read_done = 0;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'd0, 8'dx, 8'd5, 8'd5, 8'd5, 8'd5, 8'd6, 8'd7, 8'd8};

	#10
	assert (tb_expected_windowBuffer[5] == tb_windowBuffer[5])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);

	tb_start_shift = 0;
	#10
	@( posedge tb_clk );
	tb_start_shift = 1;
    	tb_start_read = 0;
    	tb_shift_direc = 2'b11;
    	//tb_data_r = 8'd0;
	tb_count = tb_count_o;

    	tb_expected_read_done = 0;
    	tb_expected_shift_done = 0;
    	tb_expected_windowBuffer = '{8'd0, 8'dx, 8'dx, 8'd3, 8'd5, 8'd5, 8'd6, 8'd7, 8'd8};

	#10
	assert (tb_expected_windowBuffer[0] == tb_windowBuffer[0])
		$info("Correct window buffer for test case %d!", testcase++);
	else
		$error("Incorrect window buffer for test case %d!", testcase++);

	tb_start_shift = 0;
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


  end
endmodule
