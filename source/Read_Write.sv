module Read_Write (
input reg [7:0] data_r,
input reg busy,
input reg [7:0] addr_w_mc,
input reg [7:0] addr_r_mc,
input reg [7:0] data_w,
input reg start_write,
input reg start_read,
//input reg read_done,
output reg [7:0] data_w_o,
output reg [1:0] instruction, //00 busy 01 read 10 wirte
output reg [7:0] addr_w,
output reg [7:0] addr_r,
output reg write_done,
output reg read_data_done,
output reg [7:0] data_r_o
);

always_comb
  begin
     write_done = 0;
     read_data_done = 0;
     //instruction = 2'b00;
   if (busy)
     begin
	instruction = 2'b00;
	     addr_r = 0;
	     data_r_o = 0;
	     read_data_done = 0;
		addr_w = 0;
	     data_w_o = 0;
	     write_done = 0; 
     end
   else 
     begin
	if (start_read)
	  begin
	     instruction = 2'b01;
	     addr_r = addr_r_mc;
	     data_r_o = data_r;
	     read_data_done = 1;
		addr_w = 0;
	     data_w_o = 0;
	     write_done = 0;
	  end


	else if (start_write)
	  begin
	     instruction = 2'b10;
	     addr_w = addr_w_mc;
	     data_w_o = data_w;
	     write_done = 1; 
		addr_r = 0;
	     data_r_o = 0;
	     read_data_done = 0;    
	  end

	else
		begin
			instruction = 2'b00;
			     addr_r = 0;
			     data_r_o = 0;
			     read_data_done = 0;
				addr_w = 0;
			     data_w_o = 0;
			     write_done = 0;   

		end
     end	
  end
	  

endmodule
