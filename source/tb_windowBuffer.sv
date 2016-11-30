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
    tb_windowBufferIn[0] = 50;
    tb_windowBufferIn[1] = 51;
    tb_windowBufferIn[2] = 52;
    tb_windowBufferIn[3] = 53;
    tb_windowBufferIn[4] = 54;
    tb_windowBufferIn[5] = 55;
    tb_windowBufferIn[6] = 56;    
    tb_windowBufferIn[7] = 57;
    tb_windowBufferIn[8] = 58;

    tb_start_shift = 1;
    tb_start_read = 0;
    tb_shift_direc = 2'b01;
    tb_data_r = 8'b0;

    tb_expected_read_done = 0;
    tb_expected_shift_done = 1;
    tb_expected_windowBuffer = '{8'd53, 8'd54, 8'd55, 8'd56, 8'd57, 8'd58, 8'd0, 8'd0};
    
    #10
    assert (tb_expected_shift_done == tb_shift_done && tb_expected_windowBuffer == tb_windowBuffer)
      $info("Correct window buffer for test case %d!", testcase);
	  else
      $error("Incorrect window buffer for test case %d!", testcase);
	  #10
    
    tb_windowBufferIn = tb_windowBuffer;
  
  end
endmodule
