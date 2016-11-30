module move_control(

//input
	input wire clk, n_reset,
	input reg [11:0] width,
	input reg [11:0] length,
	input reg [7:0] initial_addr_r,
	input reg [7:0] initial_addr_w,
	input reg start_move,
	input reg load_initial,
//output
	output reg [7:0] addr_r,
	output reg [7:0] addr_w,
	output reg [1:0]direction, //0 for right, 1 for left, 2 for up
	output reg all_done, 
	output reg move_done
	
);
   reg 		   movex, movey, x, y;
   reg 		   next_addr_r, next_addr_w, next_x, next_y, next_all_done, next_movex, next_movey, next_move_done, next_direction;
   

   always_ff @ (negedge n_reset, posedge clk)
     begin 
	if (n_reset == 0)
	  begin
	     addr_r <= initial_addr_r;
	     addr_w <= initial_addr_w;
	     x <= 1;
	     y <= 1;
	     all_done <= 0;
	     movex <= 0;
	     movey <= 0;
	     move_done <= 0;
	     direction <= 2'b01;     
	  end
	else
	  begin
	     addr_r <= next_addr_r;
	     addr_w <= next_addr_w;
	     x <= next_x;
	     y <= next_y;
	     all_done <= next_all_done;
	     movex <= next_movex;
	     movey <= next_movey;
	     move_done <= next_move_done;
	     direction <= next_direction;
	  end
	end

always_comb
	begin
	if (load_initial == 1)
		begin
		   next_addr_r = initial_addr_r;
		   next_addr_w = initial_addr_w;
		   next_x = 1;
		   next_y = 1;
		   next_all_done = 0;
		   next_move_done = 0;
		   next_direction = 2'b01;
		end 
	else if (start_move == 1)
		begin
		   next_movex = 0;
		   next_movey = 0;
		   next_move_done = 0;
// direction
		if (x == 1 && direction == 2'b10)
			begin
			   next_direction = 2'b11;
			end
		else if (x == (length - 2) && direction == 2'b01)
			begin
			   next_direction = 2'b11;
			end
		else if (y == width && direction == 2'b11)
			begin
			   next_all_done = 1;
			end
		else if (x == 1 && direction == 2'b11)
			begin
			   next_direction = 2'b01;
			end
		else if (x == (length - 2) && direction == 2'b11)
			begin
			   next_direction = 2'b10;
			end

// address
		if (direction == 2'b01) //move(right, left, up)
			begin
			   next_addr_r = addr_r + 1;			   
			   next_addr_w = addr_w + 1;
			   next_movex = 1;
			   next_x = x + 1;
			end
		else if (direction == 2'b10)
			begin
			   next_addr_r = addr_r - 1;
			   next_addr_w = addr_w - 1;
			   next_movex = 1;
			   next_x = x - 1;
			end
		else if (direction == 2'b11)
			begin
			   next_addr_r = addr_r + length;
			   next_addr_w = addr_w + length;
			   next_movey = 1;
			   next_y = y + 1;
			end

//determine move is finished
		if (movex == 1 || movey == 1) 
			begin
			   next_move_done = 1;			   
			end
		end
	end
endmodule
