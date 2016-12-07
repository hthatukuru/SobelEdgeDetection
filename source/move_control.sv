module move_control(

//input
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
	
);
   reg 		    next_move_done, next_load_done;
   reg [3:0] 	    count, next_count;
    
   reg [11:0]	    x, y;
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
   	     load_done <= 0;
	     count <= 0;
	     	     
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
	     load_done <= next_load_done;
	     count <= next_count;
	     
	  end
	end

always_comb
	begin
	   next_x = x;
	   next_y = y;

	   
	   if (load_initial == 1)
		begin
		   next_addr_r = initial_addr_r;
		   next_addr_w = initial_addr_w;
		   next_x = 1;
		   next_y = 1;
		   all_done = 0;
		   next_move_done = 0;
		   next_direction = 2'b01;
		   next_load_done = 1;
		   next_count = 0;
		   
		end 
	   else if (start_move == 1 && !move_done && !all_done)
		begin
		next_move_done = 0;	   
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
		end // if (start_move == 1 && !move_done)
	   else if (move_done)
		begin
	     		next_move_done = 0;
	  	end

	   else if (start_write && !move_done && !all_done)
	 	begin
// write address
		if (direction == 2'b01) //move(right, left, up)
			begin			   
			   next_addr_w = addr_w + 1;
			   next_x = x + 1;
			end
		else if (direction == 2'b10)
			begin
			   next_addr_w = addr_w - 1;
			   next_x = x - 1;
			end
		else if (direction == 2'b11)
			begin
			   next_addr_w = addr_w + length;
			   next_y = y + 1'b1;
			end
		end			
	   else if (start_i_read && !move_done && !all_done)
		begin
//normal read address
		if (direction == 2'b01) //move(right, left, up)
		  begin
		     if (count == 0)
		       begin						   
			  next_addr_r = addr_r + 1;
		       end
		     else if (count == 1)
		       begin						   
			  next_addr_r = addr_r + length;
		       end
		     else if (count == 2)
		       begin						   
			  next_addr_r = addr_r + length;
		       end
		     next_count = count + 1'b1;
		     next_addr_r = addr + 1 - length - length;		     
		  end
		else if (direction == 2'b10)
		  begin
		     if (count == 0)
		       begin						   
			  next_addr_r = addr_r - 1;
		       end
		     else if (count == 1)
		       begin						   
			  next_addr_r = addr_r + length;
		       end
		     else if (count == 2)
		       begin						   
			  next_addr_r = addr_r + length;
		       end
		     next_count = count + 1'b1;	
		     next_addr_r = addr - 1 - length - length;	     
		  end // if (direction == 2'b10)			   
		else if (direction == 2'b11)
		  begin
		     if (count == 0)
		       begin						   
			  next_addr_r = addr_r + length + length + length;
		       end
		     else if (count == 1)
		       begin						   
			  next_addr_r = addr_r + 1;
		       end
		     else if (count == 2)
		       begin						   
			  next_addr_r = addr_r + 1;
		       end
		     next_count = count + 1'b1;		     
		  end		
		end
	   else if (start_9_read && !move_done && !all_done)
		begin
// first 9 address read
		   if (count == 0)
		     begin
			next_addr_r = addr + 1;
		     end
		   else if (count == 1)
		     begin
			next_addr_r = addr + 1;
		     end
		   else if (count == 2)
		     begin
			next_addr_r = addr + 1;
		     end
		   else if (count == 3)
		     begin
			next_addr_r = addr + length - 2;
		     end
		   else if (count == 4)
		     begin
			next_addr_r = addr + 1;
		     end
		   else if (count == 5)
		     begin
			next_addr_r = addr + 1;
		     end
		   else if (count == 6)
		     begin
			next_addr_r = addr + length - 2;
		     end
		   else if (count == 7)
		     begin
			next_addr_r = addr + 1;
		     end
		   else if (count == 8)
		     begin
			next_addr_r = addr + 1;
		     end
		   next_count = count + 1'b1;
		   next_addr_r = addr + 1 - length - length;		   
		end // if (start_9_read)

	end
  
endmodule

