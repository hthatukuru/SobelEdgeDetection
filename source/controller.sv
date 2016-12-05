module controller (

input wire clk, n_rst, start, move_done, all_done, write_done, read_done, shift_done, calculation_done,
ouput reg start_write, start_move, start_shift, start_read, start_calculation

);


typedef enum bit [7:0] {IDLE, } stateType;
stateType state;
stateType next_state;

always_ff @ (negedge n_rst, posedge clk)
begin : REG_LOGIC
    if (n_rst == 0)
    begin
        state<=IDLE;
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
    
    end
    
  endcase
end


endmodule
