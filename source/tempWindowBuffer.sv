
// File name:   windowBuffer.sv
// Author:      Harika Thatukuru
// Description: Window Buffer Block

module windowBuffer
(
  input wire n_rst,
  input wire clk,
  input reg start_shift,
  input reg start_read,
  input reg [1:0] shift_direc,
  input reg [7:0] data_r,
  output reg read_done,
  output reg shift_done,
  output reg [7:0] windowBufferOut[0:8]
);

  reg [7:0] windowBuffer[0:8];
  reg [7:0] windowBufferNext[0:8];
  
  reg [3:0] count = 0;
  reg [3:0] countNext = 0;

  
  always_ff @ (negedge n_rst, posedge clk)
	begin :	resetting
		if( n_rst == 1'b0 )
		begin
			count <= 0;
			windowBuffer <= '{8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0};
		end
		else
		begin
			count <= countNext;
			windowBuffer <= windowBufferNext;
		end
		
	end


  always_comb
  begin
	countNext = count;
	windowBufferNext = windowBuffer;
	

    if(start_shift == 1 && start_read == 0)
    begin

      if (shift_direc == 2'b00 && count >= 0)
      begin
	read_done = 0;
	shift_done = 0;

      end
      
      else if(shift_direc == 2'b01 && count >= 0)  // shift left
      begin
        windowBufferNext [0] = windowBuffer [1];
        windowBufferNext [3] = windowBuffer [4];
        windowBufferNext [6] = windowBuffer [7];
        windowBufferNext [1] = windowBuffer [2];
        windowBufferNext [4] = windowBuffer [5];
        windowBufferNext [7] = windowBuffer [8];
        windowBufferNext [2] = 0;
        windowBufferNext [5] = 0;
        windowBufferNext [8] = 0;
        
        read_done = 0;
        shift_done = 1;
	
      end

      else if(shift_direc == 2'b10 && count >= 0) // shift right
      begin
	windowBufferNext [2] = windowBuffer [1];
        windowBufferNext [5] = windowBuffer [4];
        windowBufferNext [8] = windowBuffer [7];
        windowBufferNext [1] = windowBuffer [0];
        windowBufferNext [4] = windowBuffer [3];
        windowBufferNext [7] = windowBuffer [6];
        windowBufferNext [6] = 0;
        windowBufferNext [3] = 0;
        windowBufferNext [0] = 0;
        
        read_done = 0;
        shift_done = 1;
      end

      else if(shift_direc == 2'b11 && count >= 0) // shift down
      begin
        windowBufferNext [6] = windowBuffer [3];
        windowBufferNext [7] = windowBuffer [4];
        windowBufferNext [8] = windowBuffer [5];
        windowBufferNext [3] = windowBuffer [0];
        windowBufferNext [4] = windowBuffer [1];
        windowBufferNext [5] = windowBuffer [2];
        windowBufferNext [0] = 0;
        windowBufferNext [1] = 0;
        windowBufferNext [2] = 0;
        
        read_done = 0;
        shift_done = 1;
      end

	else
	begin
	windowBufferNext [6] = 0;
        windowBufferNext [7] = 0;
        windowBufferNext [8] = 0;
        windowBufferNext [3] = 0;
        windowBufferNext [4] = 0;
        windowBufferNext [5] = 0;
        windowBufferNext [0] = 0;
        windowBufferNext [1] = 0;
        windowBufferNext [2] = 0;
		read_done = 0;
		shift_done = 0;
	end
      
	countNext = 0;
    end
    
    else if(start_read == 1 && start_shift == 0)
    begin
        
	if(shift_direc == 2'b00 )
	begin

		if(count == 0)
		begin
			windowBufferNext[6] = data_r;
			
		end
		else if(count == 1)
		begin
			windowBufferNext[7] = data_r;
			
		end
		else if(count == 2)
		begin
			windowBufferNext[8] = data_r;
			
		end
		else if(count == 3)
		begin
			windowBufferNext[3] = data_r;
		end
		else if(count == 4)
		begin
			windowBufferNext[4] = data_r;
			
		end
		else if(count == 5)
		begin
			windowBufferNext[5] = data_r;
			
		end
		else if(count == 6)
		begin
			windowBufferNext[0] = data_r;
			
		end
		else if(count == 7)
		begin
			windowBufferNext[1] = data_r;
		end
		else if(count == 8)
		begin
			windowBufferNext[2] = data_r;
			
		end
		
		else
		begin
			windowBufferNext [6] = 0;
			windowBufferNext [7] = 0;
       	 		windowBufferNext [8] = 0;
        		windowBufferNext [3] = 0;
        		windowBufferNext [4] = 0;
			windowBufferNext [5] = 0;
			windowBufferNext [0] = 0;
			windowBufferNext [1] = 0;
			windowBufferNext [2] = 0;
		end
		
		countNext = count + 1;
		if(countNext > 8)
		begin
			countNext = 0;
		end
		
	end
	else if(shift_direc == 2'b01)
	begin
		if(count == 0)
		begin
			windowBufferNext[8] = data_r;
		end
		else if(count == 1)
		begin
			windowBufferNext[5] = data_r;
		end
		else if(count == 2)
		begin
			windowBufferNext[2] = data_r;
		end
		
		else
		begin
			windowBufferNext [6] = 0;
			windowBufferNext [7] = 0;
       	 		windowBufferNext [8] = 0;
        		windowBufferNext [3] = 0;
        		windowBufferNext [4] = 0;
			windowBufferNext [5] = 0;
			windowBufferNext [0] = 0;
			windowBufferNext [1] = 0;
			windowBufferNext [2] = 0;
		end

		
		countNext = count + 1;
		if(countNext > 2)
		begin
			countNext = 0;
		end
	end
	else if(shift_direc == 2'b10)
	begin
		if(count == 0)
		begin
			windowBufferNext[6] = data_r;
		end
		else if(count == 1)
		begin
			windowBufferNext[3] = data_r;
		end
		else if(count == 2)
		begin
			windowBufferNext[0] = data_r;
		end
		else
		begin
			windowBufferNext [6] = 0;
			windowBufferNext [7] = 0;
       	 		windowBufferNext [8] = 0;
        		windowBufferNext [3] = 0;
        		windowBufferNext [4] = 0;
			windowBufferNext [5] = 0;
			windowBufferNext [0] = 0;
			windowBufferNext [1] = 0;
			windowBufferNext [2] = 0;
		end
		

		countNext = count + 1;
		if(countNext > 2)
		begin
			countNext = 0;
		end
	
	end
        else if(shift_direc == 2'b11)
	begin
		if(count == 0)
		begin
			windowBufferNext[0] = data_r;
		end
		else if(count == 1)
		begin
			windowBufferNext[1] = data_r;
		end
		else if(count == 2)
		begin
			windowBufferNext[2] = data_r;
		end
		else
		begin
			windowBufferNext [6] = 0;
			windowBufferNext [7] = 0;
       	 		windowBufferNext [8] = 0;
        		windowBufferNext [3] = 0;
        		windowBufferNext [4] = 0;
			windowBufferNext [5] = 0;
			windowBufferNext [0] = 0;
			windowBufferNext [1] = 0;
			windowBufferNext [2] = 0;
		end
		countNext = count + 1;
		if(countNext > 2)
		begin
			countNext = 0;
		end
	end

	read_done = 1;
        shift_done = 0;
    end
    else
    begin
	read_done = 0;
	shift_done = 0;
    end
    windowBufferOut = windowBuffer;

  end

endmodule
