module main_file (
	
input wire clk;
input wire n_rst;
input reg start;

);


windowBuffer window_buffer (.clk(clk), .n_rst(n_rst), .start_shift(start_shift), .start_read(start_read), .shift_direc(shift_direc), .data_r(data_r), .count(count), .count_o(count_o), .read_done(read_done), shift_done(shift_done), windowBufferOut(windowBufferOut));

Read_Write read_write (.clk(clk), .n_rst(n_rst), .data_r(data_r), .busy(busy), .addr_w_mc(addr_w_mc), .addr_r_mc(addr_r_mc), .data_w(data_w), .start_write(start_write), .start_read(start_read), .data_w_o(data_w_o), .instruction(instruction), .addr_w(addr_w), .addr_r(addr_r), .write_done(write_done), .read_data_done(read_data_done), .data_r_o(data_r_o));





endmodule
