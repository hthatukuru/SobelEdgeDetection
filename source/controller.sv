module controller (

input wire clk, n_rst, start, move_done, all_done, write_done, read_done, shift_done, calculation_done,
ouput reg start_write, start_move, start_shift, start_read, start_calculation

);


    typedef enum bit [7:0] {IDLE, LOAD_PARAM, L_PIXEL1, L_PIXEL2, L_PIXEL3, L_PIXEL4, L_PIXEL5, L_PIXEL6, L_PIXEL7, L_PIXEL8, L_PIXEL9, GRADIENT, T_GRADIENT, CHECK_EDGE, WRITE, READ_P1, READ_P2, READ_P3, IMAGE_DONE} stateType;
stateType state;
stateType next_state;

always_ff @ (negedge n_rst, posedge clk)
begin : REG_LOGIC
    if (n_rst == 0)
    begin
        state<=IDLE;
        start_write <= 0;
        start_move <= 0;
        start_shift <= 0;
        start_read <= 0;
        start_calculation <= 0;
    end
    else
    begin
        state<=next_state;
    end
    
end


always_comb
begin : Next State
  next_state = state;
  case (state)
    IDLE:
    begin
        if (start == 1)
            next_state = LOAD_PARAM;
    end
      
    LOAD_PARAM: 
    begin
       next_state = L_PIXEL1;  
    end
      
     L_PIXEL1:
        begin
           next_state = L_PIXEL2; 
        end
      
      L_PIXEL2:
        begin
           next_state = L_PIXEL3; 
        end
      
      L_PIXEL3:
        begin
           next_state = L_PIXEL4; 
        end
      L_PIXEL4:
        begin
           next_state = L_PIXEL5; 
        end
      
      L_PIXEL5:
        begin
           next_state = L_PIXEL6; 
        end
      
      L_PIXEL6:
        begin
           next_state = L_PIXEL7; 
        end
      
      L_PIXEL7:
        begin
           next_state = L_PIXEL8; 
        end
      
      L_PIXEL8:
        begin
           next_state = L_PIXEL9; 
        end
      
      L_PIXEL9:
        begin
           next_state = GRADIENT; 
        end
      
      GRADIENT:
          begin
               next_state = T_GRADIENT;
          end
      
      T_GRADIENT:
          begin
              next_state = CHECK_EDGE;
          end
      
      CHECK_EDGE:
          begin
             next_state = WRITE; 
          end
      
      WRITE:
          begin
              next_state = CHECK_PIXEL;
          end
      
      CHECK_PIXEL:
          begin
             next_state = READ_P1; 
          end
      
      READ_P1:
          begin
             next_state = READ_P2;
          end
      READ_P2:
            begin
               next_state = READ_P3; 
            end
      
      READ_P3:
            begin
                    next_state = IMAGE_DONE;    // need if and else statment here
            end
      IMAGE_DONE:
          begin
                next_state = IDLE; 
          end
      
      
    
  endcase
end


endmodule
