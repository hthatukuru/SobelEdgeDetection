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
	output reg move_done,
	output reg load_done //adding to notify controller that the initial load is done
	
);
   reg 		    next_move_done;
 
   reg [11:0]		   x, y;
   reg [7:0] 	   next_addr_r, next_addr_w;
   reg [11:0]	   next_x, next_y;
   reg [1:0] 	   next_direction;
   

   always_ff @ (negedge n_reset, posedge clk)
     begin 
	if (n_reset == 0)
	  begin
	     addr_r <= 0;
	     addr_w <= 0;
	     x <= 0;
	     y <= 0;
	     direction <= 2'b00;  
	     //all_done <= 0;
	     move_done <= 0;
	     	     
	  end
	else
	  begin
	     addr_r <= next_addr_r;
	     addr_w <= next_addr_w;
	     x <= next_x;
	     y <= next_y;
	     direction <= next_direction;
	     //all_done <= next_all_done;
	     move_done <= next_move_done;
	     
	     
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
		   all_done = 0;
		   next_move_done = 0;
		   next_direction = 2'b01;
		   load_done = 1;
		end 
	else if (start_move == 1 && !move_done && !all_done)
		begin
		   next_move_done = 0;

// address
		if (direction == 2'b01) //move(right, left, up)
			begin
			   next_addr_r = addr_r + 1;			   
			   next_addr_w = addr_w + 1;
			   next_move_done = 1;
			   next_x = x + 1;
			end
		else if (direction == 2'b10)
			begin
			   next_addr_r = addr_r - 1;
			   next_addr_w = addr_w - 1;
			   next_move_done = 1;
			   next_x = x - 1;
			end
		else if (direction == 2'b11)
			begin
			   next_addr_r = addr_r + length;
			   next_addr_w = addr_w + length;
			   next_move_done = 1;
			   next_y = y + 1;
			end		   
// direction
		if (y == (width - 2) && direction == 2'b11)
			begin
			   all_done = 1;
			end		   
		else if (x == 2 && direction == 2'b10)
			begin
			   next_direction = 2'b11;
			end
		else if (x == (length - 3) && direction == 2'b01)
			begin
			   next_direction = 2'b11;
			end

		else if (x == 1 && direction == 2'b11)
			begin
			   next_direction = 2'b01;
			end
		else if (x == (length - 2) && direction == 2'b11)
			begin
			   next_direction = 2'b10;
			end



//determine move is finished
//		if (movex == 1 || movey == 1) 
//			begin
//			   next_move_done = 1;			   
//			end
		end // if (start_move == 1 && !move_done)
	else if (move_done)
	  begin
	     next_move_done = 0;
	  end

	   
	end
endmodule
