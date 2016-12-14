module main_file (
	
input wire clk,
input wire n_rst,
input reg start,
input reg [11:0] width,
input reg [11:0] length,
input reg [7:0] initial_addr_r,
input reg [7:0] initial_addr_w,	

);

reg start_shift;
reg start_read;
	reg shift_direc;
	reg [7:0] data_r;
	reg count;
	reg count_o;
	reg read_done;
	reg shift_done;
	reg [7:0] windowBufferOut[0:8];
	reg busy;
	reg [7:0] addr_w_mc;
	reg [7:0] addr_r_mc;
	reg [7:0] data_w;
	reg start_write;
	reg start_read;
	reg [7:0] data_w_o;
	reg instruction;
	reg [7:0] addr_w;
	reg [7:0] addr_r;
	reg write_done;
	reg read_data_done;
	reg [7:0] data_r_o;
	
	

windowBuffer window_buffer (.clk(clk), .n_rst(n_rst), .start_shift(start_shift), .start_read(start_read), .shift_direc(shift_direc), .data_r(data_r), .count(count), .count_o(count_o), .read_done(read_done), shift_done(shift_done), windowBufferOut(windowBufferOut));

Read_Write read_write (.clk(clk), .n_rst(n_rst), .data_r(data_r), .busy(busy), .addr_w_mc(addr_w_mc), .addr_r_mc(addr_r_mc), .data_w(data_w), .start_write(start_write), .start_read(start_read), .data_w_o(data_w_o), .instruction(instruction), .addr_w(addr_w), .addr_r(addr_r), .write_done(write_done), .read_data_done(read_data_done), .data_r_o(data_r_o));

move_control movecontrol(.clk(clk), .n_rst(n_rst), .width(width), .length(length), .initial_addr_r(initial_addr_r), .initial_addr_w(initial_addr_w), . )

controller controller(.clk(clk), .n_rst(n_rst), .start(start), .move_done(move_done), .all_done(all_done), .write_done(write_done), .read_done(read_done), .shift_done(shift_done), .calculation_done(calculation_done), .load_done(load_done), .read_data_done(read_data_done), .h_done(h_done), .v_done(v_done), .start_write(start_write), .start_move(start_move), .start_shift(start_shift), .load_initial(load_initial), .start_i_read(start_i_read), .start_t_grad(start_t_grad), .start_9_read(start_9_read));
		
horizontal_gradient horizontal_grad (.windowBuffer(windowBuffer), .start_calculations(start_calculations), .gx(gx) , .h_done(h_done));
vertical_gradient vertical_grad (.windowBuffer(windowBuffer), .start_calculations(start_calculations), .gx(gy) , .h_done(v_done));
total_gradient total_grad (.gy(gy), .gx(gx), .start_t_grad(start_t_grad), .g(g));

endmodule
