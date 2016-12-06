// $Id: $
// File name:   tb_controller.sv
// Created:     12/5/2016
// Author:
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: tb for horizontal_gradient.sv
`timescale 1ns / 100ps

module tb_controller ();
reg tb_clk;
localparam CLK_PERIOD = 10.4;
always
begin: CLK_GEN
	tb_clk = 1'b0;
	#(CLK_PERIOD / 2);
	tb_clk = 1'b1;
	#(CLK_PERIOD / 2);
end

  //inputs
  //reg tb_clk;
  reg tb_n_rst;
  reg tb_start;
  reg tb_move_done;
  reg tb_all_done;
  reg tb_write_done;
  reg tb_read_done;
  reg tb_calculation_done;
  reg tb_shift_done;
  reg tb_load_done;
  reg tb_read_data_done;
  reg tb_h_done;
  reg tb_v_done;

  //outputs
  reg tb_start_write;
  reg tb_start_move;
  reg tb_start_shift;
  reg tb_start_read;
  reg tb_start_calculation; 
  reg tb_load_initial;
  reg tb_start_i_read;
  reg tb_start_t_grad;
  reg tb_start_9_read;

  //expected outputs
  reg expected_tb_start_write;
  reg expected_tb_start_move;
  reg expected_tb_start_shift;
  reg expected_tb_start_read;
  reg expected_tb_start_calculation; 
  reg expected_tb_load_initial;
  reg expected_tb_start_i_read;
  reg expected_tb_start_t_grad;
  reg expected_tb_start_9_read;

  //testcase number
  integer testcase;

  controller DUT (.clk(tb_clk), .n_rst(tb_n_rst), .start(tb_start), .move_done(tb_move_done), .all_done(tb_all_done), .write_done(tb_write_done), .read_done(tb_read_done), .calculation_done(tb_calculation_done), .load_done(tb_load_done), .read_data_done(tb_read_data_done), .h_done(tb_h_done), .v_done(tb_v_done), .shift_done(tb_shift_done), .start_write(tb_start_write), .start_move(tb_start_move), .start_shift(tb_start_shift), .start_read(tb_start_read), .start_calculation(tb_start_calculation) .load_initial(tb_load_initial), .start_i_read(tb_start_i_read), .start_t_grad(tb_start_t_grad), .start_9_read(tb_start_9_read));



  initial 
  begin
	//initialization
	testcase = 0;

	
	
	tb_start = 1;
  	tb_move_done = 0;
  	tb_all_done = 0;
  	tb_write_done = 0;
  	tb_read_done = 1;
  	tb_calculation_done = 1;
  	tb_shift_done = 0;
	tb_n_rst = 0;
	expected_tb_start_write = 0;
  	expected_tb_start_move = 0;
 	expected_tb_start_shift = 0;
  	expected_tb_start_read = 0;
   	expected_tb_start_calculation = 0; 
	
	@(negedge tb_clk);
	tb_n_rst = 0;
	tb_start = 1;
  	tb_move_done = 0;
  	tb_all_done = 0;
  	tb_write_done = 0;
  	tb_read_done = 1;
  	tb_calculation_done = 1;
  	tb_shift_done = 0;

	expected_tb_start_write = 0;
  	expected_tb_start_move = 0;
 	expected_tb_start_shift = 0;
  	expected_tb_start_read = 0;
   	expected_tb_start_calculation = 0; 

	#84
	
	@(negedge tb_clk);
	tb_n_rst = 1;
	tb_start = 1;
  	tb_move_done = 0;
  	tb_all_done = 0;
  	tb_write_done = 0;
  	tb_read_done = 1;
  	tb_calculation_done = 1;
  	tb_shift_done = 0;

	expected_tb_start_write = 0;
  	expected_tb_start_move = 0;
 	expected_tb_start_shift = 0;
  	expected_tb_start_read = 1;
   	expected_tb_start_calculation = 0; 

/*
	#100
 	  assert (expected_tb_start_read == tb_start_read)
		  $info("Correct start read value for test case %d!", testcase);
	  else
		  $error("Incorrect start read value for test case %d!", testcase);
	  //#10 */

	#100

	tb_n_rst = 1;
	tb_start = 0;
  	tb_move_done = 0;
  	tb_all_done = 0;
  	tb_write_done = 0;
  	tb_read_done = 1;
  	tb_calculation_done = 1;
  	tb_shift_done = 0;

	expected_tb_start_write = 0;
  	expected_tb_start_move = 0;
 	expected_tb_start_shift = 0;
  	expected_tb_start_read = 1;
   	expected_tb_start_calculation = 0;

	#100

	tb_n_rst = 1;
	tb_start = 1;
  	tb_move_done = 0;
  	tb_all_done = 0;
  	tb_write_done = 0;
  	tb_read_done = 1;
  	tb_calculation_done = 1;
  	tb_shift_done = 0;

	expected_tb_start_write = 0;
  	expected_tb_start_move = 0;
 	expected_tb_start_shift = 0;
  	expected_tb_start_read = 1;
   	expected_tb_start_calculation = 1; 

	#100 

	tb_n_rst = 1;
	tb_start = 1;
  	tb_move_done = 0;
  	tb_all_done = 0;
  	tb_write_done = 1;
  	tb_read_done = 0;
  	tb_calculation_done = 0;
  	tb_shift_done = 1;

	expected_tb_start_write = 0;
  	expected_tb_start_move = 0;
 	expected_tb_start_shift = 0;
  	expected_tb_start_read = 1;
   	expected_tb_start_calculation = 0; 

	#100 

	tb_n_rst = 1;
	tb_start = 1;
  	tb_move_done = 1;
  	tb_all_done = 0;
  	tb_write_done = 0;
  	tb_read_done = 1;
  	tb_calculation_done = 0;
  	tb_shift_done = 0;

	expected_tb_start_write = 0;
  	expected_tb_start_move = 0;
 	expected_tb_start_shift = 0;
  	expected_tb_start_read = 1;
   	expected_tb_start_calculation = 0; 

	#100
	tb_n_rst = 1;
	tb_start = 1;
  	tb_move_done = 1;
  	tb_all_done = 1;
  	tb_write_done = 0;
  	tb_read_done = 1;
  	tb_calculation_done = 0;
  	tb_shift_done = 0;

	expected_tb_start_write = 0;
  	expected_tb_start_move = 0;
 	expected_tb_start_shift = 0;
  	expected_tb_start_read = 1;
   	expected_tb_start_calculation = 0; 

  end

endmodule
