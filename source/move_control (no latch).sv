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
   reg 		    next_move_done, next_all_done, next_load_done, next_9_done, next_i_done, next_w_done;
   reg		    n_done, i_done, w_done;
   reg [3:0] 	    count9, next_count9;
 	    
   reg [1:0] 	    count, next_count;
    
   reg [11:0]	    rx, ry, wx, wy;
   reg [7:0] 	   next_addr_r, next_addr_w;
   reg [11:0]	   next_rx, next_ry, next_wx, next_wy;
   reg [1:0] 	   next_direction;
   

always_ff @ (negedge n_reset, posedge clk)
     begin 
	if (n_reset == 0)
	  begin
	     addr_r <= 0;
	     addr_w <= 0;
	     rx <= 0;
	     ry <= 0;
	     wx <= 0;
	     wy <= 0;
	     direction <= 2'b00;  
	     all_done <= 0;
	     move_done <= 0;
   	     load_done <= 0;
	     count <= 0;
	     count9 <= 0;
	     n_done <= 0;
	     i_done <= 0;
	     w_done <= 0;	     
	     
	     	     
	  end
	else
	  begin
	     addr_r <= next_addr_r;
	     addr_w <= next_addr_w;
	     rx <= next_rx;
	     ry <= next_ry;
	     wx <= next_wx;
	     wy <= next_wy;
	     direction <= next_direction;
	     all_done <= next_all_done;
	     move_done <= next_move_done;
	     load_done <= next_load_done;
	     count <= next_count;
	     count9 <= next_count9;
	     n_done <= next_9_done;
	     i_done <= next_i_done;
	     w_done <= next_w_done;	     
	     
	  end
	end

always_comb
	begin
	   next_rx = rx;
	   next_ry = ry;
	   next_wx = wx;
	   next_wy = wy;
	   next_addr_r = addr_r;
	   next_addr_w = addr_w;

	   next_all_done = all_done;	   
	   next_move_done = move_done;
	   next_direction = direction;
	   next_load_done = load_done;
	   next_count = count;
	   next_count9 = count9;
	   next_9_done = n_done;
	   next_i_done = i_done;
	   next_w_done = w_done;
	   
	   if (load_initial == 1)
		begin
		   next_addr_r = initial_addr_r;
		   next_addr_w = initial_addr_w;
		   next_rx = 1;
		   next_ry = 1;
		   next_wx = 1;
		   next_wy = 1;
		   next_all_done = 0;
		   next_move_done = 0;
		   next_direction = 2'b01;
		   next_load_done = 1;
		   next_count = 0;
		   next_count9 = 0;
		   next_9_done = 0;
		   next_i_done = 0;
		   next_w_done = 0;		   
		   
		end 
	   if (start_move == 1 && !move_done && !all_done)
		begin	   
// direction
		if (wy == (width - 2) && direction == 2'b11)
			begin
			   next_all_done = 1;
			end		   
		else if (wx == 2 && direction == 2'b10)
			begin
			   next_direction = 2'b11;
			end
		else if (wx == (length - 1) && direction == 2'b01)
			begin
			   next_direction = 2'b11;
			end

		else if (wx == 1 && direction == 2'b11)
			begin
			   next_direction = 2'b01;
			   next_wx = 2;
			   
			end
		else if (wx == (length) && direction == 2'b11)
			begin
			   next_direction = 2'b10;
			   next_wx = length - 1;
			   
			end
		end // if (start_move == 1 && !move_done)

	   if (start_write && !w_done && !all_done)
	 	begin
// write address
		if (direction == 2'b01) //move(right, left, up)
			begin			   
			   next_addr_w = addr_w + 1;
			   next_wx = wx + 1;
			   next_w_done = 1;		      
			end
		else if (direction == 2'b10)
			begin
			   next_addr_w = addr_w - 1;
			   next_wx = wx - 1;
			   next_w_done = 1;
			end
		else if (direction == 2'b11)
			begin
			   next_addr_w = addr_w + length;
			   next_wy = wy + 1'b1;
			   if (wx == (length - 1))
			     begin
				next_wx = length;
			     end
			   else if (wx == 2)
			     begin
				next_wx = 1;
			     end
							   
			   next_w_done = 1;
			end
		end			
	   if (start_i_read && !i_done && !all_done)
		begin
//normal read address
		if (direction == 2'b01) //move right
		  begin // reposition read address
//		     if (rx == 3)
//		       begin
//			  next_addr_r = addr_r + 1 - length - length;
//		       end
//		     else
//		       begin
//			  next_addr_r = addr_r + 1 - length - length;
//		       end
		     next_rx = rx + 1;
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
		     else if (count == 3)
		       begin
			  next_addr_r = addr_r - length - length;
		       end
		     next_count = count + 1'b1;
		     next_i_done = 1;
		  end
		else if (direction == 2'b10) //move left
		  begin
		     next_rx = rx - 1;
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
		     else if (count == 3)
		       begin
			  next_addr_r = addr_r - length - length;
		       end
		     next_count = count + 1'b1;
		     next_i_done = 1;
		  end // if (direction == 2'b10)			   
		else if (direction == 2'b11)
		  begin
		     next_ry = ry + 1'b1;		     
		     if (count == 0)
		       begin
			  if (wx == 2)
			    begin
			       next_addr_r = addr_r + length + length + length;
			    end
			  else if (wx == (length - 1))
			    begin
			       next_addr_r = addr_r + length + length + length - 2;
			    end			       
		       end
		     else if (count == 1)
		       begin						   
			  next_addr_r = addr_r + 1;
		       end
		     else if (count == 2)
		       begin						   
			  next_addr_r = addr_r + 1;
		       end

		     else if (count == 3)
		       begin
			  if (wx == 2)
			    begin
			       next_addr_r = addr_r - length - length;
			    end
			  else if (wx == (length - 1))
			    begin
			       next_addr_r = addr_r - 2 - length - length;
			    end
		       end // if (count == 3)
		     next_count = count + 1'b1;
		     next_i_done = 1; 	     			 
		  end // if (direction == 2'b11)

		   
		   
		  if (count == 3)
		    begin
		       next_count = 0;
		    end		   
		end
	   if (start_9_read && !n_done && !all_done)
		begin
// first 9 address read
		   if (count9 == 0)
		     begin
			next_addr_r = addr_r;
		     end		   
		   else if (count9 == 1)
		     begin
			next_addr_r = addr_r + 1;
		     end
		   else if (count9 == 2)
		     begin
			next_addr_r = addr_r + 1;
		     end
		   else if (count9 == 3)
		     begin
			next_addr_r = addr_r + length - 2;
		     end
		   else if (count9 == 4)
		     begin
			next_addr_r = addr_r + 1;
		     end
		   else if (count9 == 5)
		     begin
			next_addr_r = addr_r + 1;
		     end
		   else if (count9 == 6)
		     begin
			next_addr_r = addr_r + length - 2;
		     end
		   else if (count9 == 7)
		     begin
			next_addr_r = addr_r + 1;
		     end
		   else if (count9 == 8)
		     begin
			next_addr_r = addr_r + 1;
			next_rx = 3;
			next_ry = 3;
		     end
		   next_count9 = count9 + 1'b1;
		   next_9_done = 1;
		   if (count9 == 9)
		     begin
			next_addr_r = addr_r - length - length;
		     end   
		end // if (start_9_read)
	   if (n_done == 1 && start_9_read == 1)
	     begin
		next_9_done = 0;
	     end
//	   else
//	     begin
//		next_9_done = n_done;
//	     end		
	   if (move_done == 1 && start_move == 1)
	     begin
	     	next_move_done = 0;
	     end
//	   else
//	     begin
//		next_move_done = move_done;
//	     end	   
	   if (w_done == 1 && start_write == 1)
	     begin
	     	next_w_done = 0;
	     end
//	   else
//	     begin
//		next_w_done = w_done;
//	     end	   
	   if (i_done == 1 && start_i_read == 1)
	     begin
	     	next_i_done = 0;
	     end
//	   else
//	     begin
//		next_i_done = i_done;
//	     end
	   
	end // always_comb

  
endmodule

