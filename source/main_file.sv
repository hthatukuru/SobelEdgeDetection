module main_file (
	
input wire clk;
input wire n_rst;
input reg start;

);


windowBuffer window_buffer (.clk(clk), .n_rst(n_rst), .start_shift(start_shift), .start_read(start_read), .shift_direc(shift_direc), .data_r(data_r), .count(count), .count_o(count_o), .read_done(read_done), shift_done(shift_done), windowBufferOut(windowBufferOut));

Read_Write read_write (.clk(clk), .n_rst(n_rst), .data_r(data_r), .busy(busy), .addr_w_mc(addr_w_mc), .addr_r_mc(addr_r_mc), .data_w(data_w), .start_write(start_write), .start_read(start_read), .data_w_o(data_w_o), .instruction(instruction), .addr_w(addr_w), .addr_r(addr_r), .write_done(write_done), .read_data_done(read_data_done), .data_r_o(data_r_o));

	move_control movecontrol(.clk(clk), .n_rst(n_rst), .width(width), .length(length), .initial_addr_r(initial_addr_r), .initial_addr_w(initial_addr_w), . )
input wire clk, n_reset,
	input reg [11:0] width,
	input reg [11:0] length,
	input reg [7:0] initial_addr_r,
	input reg [7:0] initial_addr_w,
	input reg start_move,
	input reg start_write,
	input reg start_i_read,
	input reg start_9_read,
	input reg load_initial,
//output
	output reg [7:0] addr_r,
	output reg [7:0] addr_w,
	output reg [1:0]direction, //0 for right, 1 for left, 2 for up
	output reg all_done, 
	output reg move_done,
	output reg load_done //adding to notify controller that the initial load is done

horizontal_gradient horizontal_grad (.windowBuffer(windowBuffer), .start_calculations(start_calculations), .gx(gx) , .h_done(h_done));
vertical_gradient vertical_grad (.windowBuffer(windowBuffer), .start_calculations(start_calculations), .gx(gy) , .h_done(v_done));
total_gradient total_grad (.gy(gy), .gx(gx), .start_t_grad(start_t_grad), .g(g));

endmodule
