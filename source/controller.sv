module controller (

input wire clk, n_rst, start, move_done, all_done, write_done, read_done, shift_done, calculation_done, load_done, read_data_done, h_done, v_done
output reg start_write, start_move, start_shift, start_read, start_calculation, load_initial, start_i_read, start_t_grad

);


    typedef enum bit [5:0] {IDLE, LOAD_PARAM, R_PIXEL1, R_PIXEL2, R_PIXEL3, R_PIXEL4,R_PIXEL5,R_PIXEL6, R_PIXEL7, R_PIXEL8, R_PIXEL9, L_PIXEL1, L_PIXEL2, L_PIXEL3, L_PIXEL4, L_PIXEL5, L_PIXEL6, L_PIXEL7, L_PIXEL8, L_PIXEL9, GRADIENT, T_GRADIENT, CHECK_EDGE, WRITE, SHIFT_P1, SHIFT_P2, SHIFT_P3, CHECK_PIXEL, READ_P1, READ_P2, READ_P3, IMAGE_DONE} stateType;	//SHIFT only needs 1 state 
stateType state;
stateType next_state;

always_ff @ (negedge n_rst, posedge clk)
begin : REG_LOGIC
    if (n_rst == 0)
    begin
        state<=IDLE;
        //start_write <= 0;
        //start_move <= 0;
        //start_shift <= 0;
        //start_read <= 0;
        //start_calculation <= 0;
    end
    else
    begin
        state<=next_state;
    end
    
end


always_comb
begin : NEXT_STATE_LOGIC
  next_state = state;
  
  
  case (state)
      
    IDLE:
    begin
        if (start == 1)
            next_state = LOAD_PARAM;
        else if (all_done == 1)
	    next_state = IMAGE_DONE;
	else
            next_state = IDLE;
    end
      
    LOAD_PARAM: 
    begin
	if (load_done == 1)
       		next_state = R_PIXEL1;  
	else if (all_done == 1)
		next_state = IMAGE_DONE;
	else
		next_state = LOAD_PARAM;
    end
    
    R_PIXEL1:
        begin
		if (read_data_done == 1)
           		next_state = L_PIXEL1; 
		else 
			next_state = R_PIXEL1;
        end

	
      
     L_PIXEL1:
        begin
		if (read_done == 1)
           		next_state = R_PIXEL2; 
		else
			next_state = L_PIXEL1;
        end

     R_PIXEL2:
        begin
		if (read_data_done == 1)
           		next_state = L_PIXEL2; 
		else 
			next_state = R_PIXEL2;
        end
      
     L_PIXEL2:
        begin
		if (read_done == 1)
           		next_state = R_PIXEL3; 
		else
			next_state = L_PIXEL2;
        end
      
    R_PIXEL3:
        begin
		if (read_data_done == 1)
           		next_state = L_PIXEL3; 
		else 
			next_state = R_PIXEL3;
        end
      
     L_PIXEL3:
        begin
		if (read_done == 1)
           		next_state = R_PIXEL4; 
		else
			next_state = L_PIXEL3;
        end

R_PIXEL4:
        begin
		if (read_data_done == 1)
           		next_state = L_PIXEL4; 
		else 
			next_state = R_PIXEL4;
        end
      
     L_PIXEL4:
        begin
		if (read_done == 1)
           		next_state = R_PIXEL5; 
		else
			next_state = L_PIXEL4;
        end

R_PIXEL5:
        begin
		if (read_data_done == 1)
           		next_state = L_PIXEL5; 
		else 
			next_state = R_PIXEL5;
        end
      
     L_PIXEL5:
        begin
		if (read_done == 1)
           		next_state = R_PIXEL6; 
		else
			next_state = L_PIXEL5;
        end

R_PIXEL6:
        begin
		if (read_data_done == 1)
           		next_state = L_PIXEL6; 
		else 
			next_state = R_PIXEL6;
        end
      
     L_PIXEL6:
        begin
		if (read_done == 1)
           		next_state = R_PIXEL7; 
		else
			next_state = L_PIXEL6;
        end

R_PIXEL7:
        begin
		if (read_data_done == 1)
           		next_state = L_PIXEL7; 
		else 
			next_state = R_PIXEL7;
        end
      
     L_PIXEL7:
        begin
		if (read_done == 1)
           		next_state = R_PIXEL8; 
		else
			next_state = L_PIXEL7;
        end

	R_PIXEL8:
        begin
		if (read_data_done == 1)
           		next_state = L_PIXEL8; 
		else 
			next_state = R_PIXEL8;
        end
      
     L_PIXEL8:
        begin
		if (read_done == 1)
           		next_state = R_PIXEL9; 
		else
			next_state = L_PIXEL8;
        end

	R_PIXEL9:
        begin
		if (read_data_done == 1)
           		next_state = L_PIXEL9; 
		else 
			next_state = R_PIXEL9;
        end
	
      L_PIXEL9:
        begin
	   if (read_done == 1)
           	next_state = GRADIENT; 
	   else if (all_done == 1)
		next_state = IMAGE_DONE;
	   else
		next_state = L_PIXEL9;
        end
      
      GRADIENT:
          begin
	       if (v_done == 1 && h_done == 1)	
               		next_state = T_GRADIENT;
		else 
			next_state = GRADIENT; 
          end
      
      T_GRADIENT:
          begin
	      if (calculation_done == 1)
              	next_state = WRITE;
	      else
		next_state = T_GRADIENT;
          end
      
      /*CHECK_EDGE:
          begin
              if (write_done == 1) 
             	next_state = WRITE; 
	      else if (all_done == 1)
		next_state = IMAGE_DONE;
          end*/
      
      WRITE:
          begin
		if (write_done == 1)
              		next_state = CHECK_PIXEL;
		else 
			next_state = WRITE;
          end
      
      CHECK_PIXEL:
          begin
              if (move_done == 1)
                next_state = SHIFT_P1;
              else if (all_done == 1)
                next_state = IMAGE_DONE;	
	      else
		next_state = CHECK_PIXEL;
	      
          end

	SHIFT_P1:
	begin
	      if (all_done == 0 && shift_done == 1)
		 next_state = READ_P1;
 	      else if (all_done == 1)
		 next_state = IMAGE_DONE;
	      else
		 next_state = SHIFT_P1;

	end
/*
	SHIFT_P2:
	begin
	      if (all_done == 0 && read_done == 0 && shift_done == 1 && move_done == 0)
		 next_state = SHIFT_P3;
 	      else if (all_done == 1)
		 next_state = IMAGE_DONE;
	      else
		 next_state = SHIFT_P2;

	end

	SHIFT_P3:
	begin
	      if (all_done == 0 && read_done == 0 && shift_done == 1 && move_done == 0)
		 next_state = READ_P1;
 	      else if (IMAGE_DONE == 1)
		 next_state = IMAGE_DONE;
	      else
		 next_state = SHIFT_P3;

	end
	
*/

      READ_P1:
          begin
		if (all_done == 0 && read_data_done == 1)
             		next_state = LOAD_P1;
		else if (all_done == 1)
			next_state = IMAGE_DONE;
		else
			next_state = READ_P1;
          end

      LOAD_P1:
	begin
		if (read_done == 1)
			next_state = READ_P2;
		else if (all_done == 1)
			next_state = IMAGE_DONE;
		else
			next_state = LOAD_P1;

	end

	READ_P2:
          begin
		if (all_done == 0 && read_data_done == 1)
             		next_state = LOAD_P2;
		else if (all_done == 1)
			next_state = IMAGE_DONE;
		else
			next_state = READ_P2;
          end

      LOAD_P2:
	begin
		if (read_done == 1)
			next_state = READ_P3;
		else if (all_done == 1)
			next_state = IMAGE_DONE;
		else
			next_state = LOAD_P2;

	end
      

      READ_P3:
            begin
                if (all_done == 0 && read_data_done == 1)
             		next_state = LOAD_P3;
		else if (all_done == 1)
			next_state = IMAGE_DONE;
		else
			next_state = READ_P3;
	    end

	LOAD_P3:
	begin
		if (read_done == 1 && all_done == 0)
			next_state = GRADIENT;
		else if (all_done == 1)
			next_state = IMAGE_DONE;
		else
			next_state = LOAD_P3;

	end
      IMAGE_DONE:
          begin
                next_state = IDLE; 
          end
      
      
    
  endcase

end

    
always@ (state)
begin 
	
  case (state)
      
    IDLE:
    begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	load_initial = 0;
	start_i_read = 0;
	read_data_done = 0;
	start_t_grad = 0;
    end
      
    LOAD_PARAM: 
    begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	load_initial = 1;
	start_i_read = 0;
	read_data_done = 0;
    end
	
    R_PIXEL1:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	start_i_read = 1;
	load_initial = 0;
        end
      
     L_PIXEL1:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 1; 
        start_calculation = 0;
	start_i_read = 0;
	load_initial = 0;
        end

R_PIXEL2:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	start_i_read = 1;
	load_initial = 0;
        end
      
     L_PIXEL2:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 1; 
        start_calculation = 0;
	start_i_read = 0;
	load_initial = 0;
        end

R_PIXEL3:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	start_i_read = 1;
	load_initial = 0;
        end
      
     L_PIXEL3:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 1; 
        start_calculation = 0;
	start_i_read = 0;
	load_initial = 0;
        end

R_PIXEL4:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	start_i_read = 1;
	load_initial = 0;
        end
      
     L_PIXEL4:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 1; 
        start_calculation = 0;
	start_i_read = 0;
	load_initial = 0;
        end

R_PIXEL5:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	start_i_read = 1;
	load_initial = 0;
        end
      
     L_PIXEL5:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 1; 
        start_calculation = 0;
	start_i_read = 0;
	load_initial = 0;
        end

R_PIXEL6:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	start_i_read = 1;
	load_initial = 0;
        end
      
     L_PIXEL6:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 1; 
        start_calculation = 0;
	start_i_read = 0;
	load_initial = 0;
        end


R_PIXEL7:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	start_i_read = 1;
	load_initial = 0;
        end
      
     L_PIXEL7:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 1; 
        start_calculation = 0;
	start_i_read = 0;
	load_initial = 0;
        end

R_PIXEL8:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	start_i_read = 1;
	load_initial = 0;
        end
      
     L_PIXEL8:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 1; 
        start_calculation = 0;
	start_i_read = 0;
	load_initial = 0;
        end

R_PIXEL9:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 0; 
        start_calculation = 0;
	start_i_read = 1;
	load_initial = 0;
        end
      
     L_PIXEL9:
        begin
        start_write = 0;
        start_move = 0;
        start_shift = 0; 
        start_read = 1; 
        start_calculation = 0;
	start_i_read = 0;
	load_initial = 0;
        end
      
     
      
      GRADIENT:
          begin
          start_write = 0;
          start_move = 0;
          start_shift = 0; 
          start_read = 0; 
          start_calculation = 1;
	  start_t_grad = 0;
	  start_i_read = 0;
	  load_initial = 0;
          end
      
      T_GRADIENT:
          begin
          start_write = 0;
          start_move = 0;
          start_shift = 0; 
          start_read = 0; 
          start_calculation = 0;
	  start_t_grad = 1;
	  start_i_read = 0;
	  load_initial = 0;
          end
      /*
      CHECK_EDGE:
          begin
          start_write = 0;
          start_move = 0;
          start_shift = 0; 
          start_read = 0; 
          start_calculation = 0; 
          end
      */

      WRITE:
          begin
          start_write = 1;
          start_move = 0;
          start_shift = 0; 
          start_read = 0; 
          start_calculation = 0;
	  start_t_grad = 0;
	  start_i_read = 0;
	  load_initial = 0;
          end
      
      CHECK_PIXEL:
          begin
          start_write = 0;
          start_move = 1;
          start_shift = 0; 
          start_read = 0; 
          start_calculation = 0;
	  start_t_grad = 0;
	  start_i_read = 0;
	  load_initial = 0;
          end

      SHIFT_P1:
 	  begin
	  start_write = 0;
          start_move = 0;
          start_shift = 1; 
          start_read = 0; 
          start_calculation = 0;
	  start_t_grad = 0;
	  start_i_read = 0;
	  load_initial = 0;
	  end
/*
       SHIFT_P2:
 	  begin
	  start_write = 0;
          start_move = 0;
          start_shift = 1; 
          start_read = 0; 
          start_calculation = 0;
	  end

	 SHIFT_P3:
 	  begin
	  start_write = 0;
          start_move = 0;
          start_shift = 1; 
          start_read = 0; 
          start_calculation = 0;
	  end
*/

      READ_P1:
          begin
          start_write = 0;
          start_move = 0;
          start_shift = 0; 
          start_read = 0; 
          start_calculation = 0;	
	  start_i_read = 1;
          end

	LOAD_P1:
	begin
	  start_write = 0;
          start_move = 0;
          start_shift = 0; 
          start_read = 1; 
          start_calculation = 0;	
	  start_i_read = 0;
	end
      
	 READ_P2:
          begin
          start_write = 0;
          start_move = 0;
          start_shift = 0; 
          start_read = 0; 
          start_calculation = 0;	
	  start_i_read = 1;
          end

	LOAD_P2:
	begin
	  start_write = 0;
          start_move = 0;
          start_shift = 0; 
          start_read = 1; 
          start_calculation = 0;	
	  start_i_read = 0;
	end

	 READ_P3:
          begin
          start_write = 0;
          start_move = 0;
          start_shift = 0; 
          start_read = 0; 
          start_calculation = 0;	
	  start_i_read = 1;
          end

	LOAD_P3:
	begin
	  start_write = 0;
          start_move = 0;
          start_shift = 0; 
          start_read = 1; 
          start_calculation = 0;	
	  start_i_read = 0;
	end

      IMAGE_DONE:
          begin
            start_write = 0;
            start_move = 0;
            start_shift = 0; 
            start_read = 0; 
            start_calculation = 0;
	    start_t_grad = 0;
	    start_i_read = 0;
	    load_initial = 0;
          end
      
      
    
  endcase
end

endmodule
