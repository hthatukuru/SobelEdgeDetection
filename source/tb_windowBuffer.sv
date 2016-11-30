`timescale 1ns / 100ps

module tb_windowBuffer ();

  reg tb_start_shift;
  reg tb_start_read;
  reg [1:0] tb_shift_direc;
  reg [7:0] tb_data_r;
  reg [7:0] tb_windowBufferIn[0:8];
  reg tb_read_done;
  reg tb_shift_done;
  reg [7:0] tb_windowBuffer[0:8];
  
  reg tb_expected_read_done;
  reg tb_expected_shift_done;
  reg [7:0] tb_expected_windowBuffer[0:8];
  
  integer testcase;

  reg [7:0] tb_expected_p1;
  reg [7:0] tb_p1;
  
  windowBuffer DUT ( 
    .start_shift(tb_start_shift),
    .start_read(tb_start_read),
    .shift_direc(tb_shift_direc),
    .data_r(tb_data_r),
    .windowBufferIn(tb_windowBufferIn),
    .read_done(tb_read_done),
    .shift_done(tb_shift_done),
    .windowBuffer(tb_windowBuffer)
  );
  
  initial
  begin

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
    tb_expected_p1 = tb_expected_windowBuffer[0];
    tb_p1 = tb_windowBuffer[0];
    #10
    assert (tb_expected_p1 == tb_p1)
      $info("Correct window buffer for test case %d!", testcase);
	  else
      $error("Incorrect window buffer for test case %d!", testcase);
	//  #10
    
/*	  
    testcase = 1;
    tb_windowBufferIn = tb_windowBuffer;

    tb_start_shift = 1;
    tb_start_read = 0;
    tb_shift_direc = 2'b01;
    tb_data_r = 8'b0;

    tb_expected_read_done = 0;
    tb_expected_shift_done = 1;
    tb_expected_windowBuffer = '{8'd, 8'd57, 8'd58, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0, 8'd0};

    tb_expected_p1 = tb_expected_windowBuffer[0];
    tb_p1 = tb_windowBuffer[0];
    
    #10
    assert (tb_expected_p1 == tb_p1)
      $info("Correct window buffer for test case %d!", testcase);
	  else
      $error("Incorrect window buffer for test case %d!", testcase);

  */

  end
endmodule
