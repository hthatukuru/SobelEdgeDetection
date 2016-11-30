
// File name:   windowBuffer.sv
// Author:      Harika Thatukuru
// Description: Window Buffer Block

module windowBuffer
(
  input reg start_shift,
  input reg start_read,
  input reg [1:0] shift_direc,
  input reg [7:0] data_r,
  input reg [7:0] windowBufferIn[0:8],
  output reg read_done,
  output reg shift_done,
  output reg [7:0] windowBuffer[0:8]
);

  reg [7:0] tempWindowBuffer[0:8];
  reg i = 0;
  reg notFound = 1;
  reg firstEmpty = 0;
  
  always_comb
  begin
    tempWindowBuffer = windowBufferIn;
    
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
      
    end
    
    else if(start_read == 1)
    begin
      
      while ( (i < 9) && notFound )
      begin
        if (tempWindowBuffer[i] == 0)
          begin
            firstEmpty = i;
            notFound = 0;
          end
        i = i + 1;
      end
      
      tempWindowBuffer[firstEmpty] = data_r;
      read_done = 1;
      shift_done = 0;
      
    end
    
    windowBuffer = tempWindowBuffer;
    // windowBufferIn = tempWindowBuffer;
  end
  
endmodule
