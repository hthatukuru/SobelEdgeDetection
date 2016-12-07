
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
  // input reg [7:0] windowBufferIn[0:8],
  output reg read_done,
  output reg shift_done,
  output reg [7:0] windowBuffer[0:8]
);

  reg [7:0] tempWindowBuffer[0:8];
  
  reg [3:0] count = 0;
  
 /* 
  always_ff @ (negedge n_rst, posedge clk)
	begin :	resetting
		if( n_rst == 1'b0 )
		begin
			count <= 0;
		end
		
	end
*/


  always_comb
  begin
    // tempWindowBuffer = windowBufferIn;
    //nextCount = count;

    if(start_shift == 1)
    begin

      if(shift_direc == 2'b01)  // shift left
      begin
        tempWindowBuffer [0] = tempWindowBuffer [1];
        tempWindowBuffer [3] = tempWindowBuffer [4];
        tempWindowBuffer [6] = tempWindowBuffer [7];
        tempWindowBuffer [1] = tempWindowBuffer [2];
        tempWindowBuffer [4] = tempWindowBuffer [5];
        tempWindowBuffer [7] = tempWindowBuffer [8];
        tempWindowBuffer [2] = 0;
        tempWindowBuffer [5] = 0;
        tempWindowBuffer [8] = 0;
        
        read_done = 0;
        shift_done = 1;
	
      end

      else if(shift_direc == 2'b10) // shift right
      begin
	tempWindowBuffer [2] = tempWindowBuffer [1];
        tempWindowBuffer [5] = tempWindowBuffer [4];
        tempWindowBuffer [8] = tempWindowBuffer [7];
        tempWindowBuffer [1] = tempWindowBuffer [0];
        tempWindowBuffer [4] = tempWindowBuffer [3];
        tempWindowBuffer [7] = tempWindowBuffer [6];
        tempWindowBuffer [6] = 0;
        tempWindowBuffer [3] = 0;
        tempWindowBuffer [0] = 0;
        
        read_done = 0;
        shift_done = 1;
      end

      else if(shift_direc == 2'b11) // shift down
      begin
        tempWindowBuffer [6] = tempWindowBuffer [3];
        tempWindowBuffer [7] = tempWindowBuffer [4];
        tempWindowBuffer [8] = tempWindowBuffer [5];
        tempWindowBuffer [3] = tempWindowBuffer [0];
        tempWindowBuffer [4] = tempWindowBuffer [1];
        tempWindowBuffer [5] = tempWindowBuffer [2];
        tempWindowBuffer [0] = 0;
        tempWindowBuffer [1] = 0;
        tempWindowBuffer [2] = 0;
        
        read_done = 0;
        shift_done = 1;
      end
      
	count = 0;
    end
    
    else if(start_read == 1)
    begin
        
	if(shift_direc == 2'b00 )
	begin
		
		if(count == 0)
		begin
			tempWindowBuffer[6] = data_r;
			//nextCount = count + 1;
			
		end
		else if(count == 1)
		begin
			tempWindowBuffer[7] = data_r;
			
		end
		else if(count == 2)
		begin
			tempWindowBuffer[8] = data_r;
			
		end
		else if(count == 3)
		begin
			tempWindowBuffer[3] = data_r;
			
		end
		else if(count == 4)
		begin
			tempWindowBuffer[4] = data_r;
			
		end
		else if(count == 5)
		begin
			tempWindowBuffer[5] = data_r;
			
		end
		else if(count == 6)
		begin
			tempWindowBuffer[0] = data_r;
			
		end
		else if(count == 7)
		begin
			tempWindowBuffer[1] = data_r;
			//nextCount = count + 1;
		end
		else if(count == 8)
		begin
			tempWindowBuffer[2] = data_r;
			
		end
		
		count++;
		
	end
	else if(shift_direc == 2'b01)
	begin
		if(count == 0)
		begin
			tempWindowBuffer[8] = data_r;
		end
		else if(count == 1)
		begin
			tempWindowBuffer[5] = data_r;
		end
		else if(count == 2)
		begin
			tempWindowBuffer[2] = data_r;
		end

		
		count++;
	end
	else if(shift_direc == 2'b10)
	begin
		if(count == 0)
		begin
			tempWindowBuffer[6] = data_r;
		end
		else if(count == 1)
		begin
			tempWindowBuffer[3] = data_r;
		end
		else if(count == 2)
		begin
			tempWindowBuffer[0] = data_r;
		end

		count++;
	
	end
        else if(shift_direc == 2'b11)
	begin
		if(count == 0)
		begin
			tempWindowBuffer[0] = data_r;
		end
		else if(count == 1)
		begin
			tempWindowBuffer[1] = data_r;
		end
		else if(count == 2)
		begin
			tempWindowBuffer[2] = data_r;
		end

		count++;
	end

	read_done = 1;
        shift_done = 0;
    end
    
    windowBuffer = tempWindowBuffer;
    // windowBufferIn = tempWindowBuffer;
  end
  
endmodule
