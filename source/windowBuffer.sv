
// File name:   windowBuffer.sv
// Author:      Harika Thatukuru
// Description: Window Buffer Block

module windowBuffer
(
  input clk,
  input n_rst,
  input start_shift,
  input start_read,
  input shift_direc,
  input reg [7:0] data_r,
  input reg [7:0] windowBufferIn[0:8],
  output read_done,
  output shift_done,
  output reg [7:0] windowBufferOut[0:8]
);

  reg [7:0] tempWindowBuffer[0:8];

  always_comb
  begin
    if(start_shift)
    begin

      if(shift_direc == 2'b01)  // shift left
      begin
        tempWindowBuffer [0] = tempWindowBuffer [3];
        tempWindowBuffer [1] = tempWindowBuffer [4];
        tempWindowBuffer [2] = tempWindowBuffer [5];
        tempWindowBuffer [3] = tempWindowBuffer [6];
        tempWindowBuffer [4] = tempWindowBuffer [7];
        tempWindowBuffer [5] = tempWindowBuffer [8];
        tempWindowBuffer [6] = 0;
        tempWindowBuffer [7] = 0;
        tempWindowBuffer [8] = 0;
      end

      else if(shift_direc == 2'b10) // shift right
      begin
        tempWindowBuffer [8] = tempWindowBuffer [5];
        tempWindowBuffer [7] = tempWindowBuffer [4];
        tempWindowBuffer [6] = tempWindowBuffer [3];
        tempWindowBuffer [5] = tempWindowBuffer [2];
        tempWindowBuffer [4] = tempWindowBuffer [1];
        tempWindowBuffer [3] = tempWindowBuffer [0];
        tempWindowBuffer [0] = 0;
        tempWindowBuffer [1] = 0;
        tempWindowBuffer [2] = 0;
      end

      else if(shift_direc == 2'b11) // shift down
      begin
        tempWindowBuffer [2] = tempWindowBuffer [1];
        tempWindowBuffer [5] = tempWindowBuffer [4];
        tempWindowBuffer [8] = tempWindowBuffer [7];
        tempWindowBuffer [1] = tempWindowBuffer [0];
        tempWindowBuffer [4] = tempWindowBuffer [3];
        tempWindowBuffer [7] = tempWindowBuffer [6];
        tempWindowBuffer [0] = 0;
        tempWindowBuffer [3] = 0;
        tempWindowBuffer [6] = 0;
      end

    end
    else if(start_read)
    begin

    end
  end
endmodule
