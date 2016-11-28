module Read_Write (
input reg [7:0] data_r,
input reg busy,
input reg [7:0] addr_w_mc,
input reg [7:0] addr_r_mc,
input reg [7:0] edge,
input reg start_write,
output reg [7:0] data_w,
output reg [1:0] instruction,
output reg [7:0] addr_w,
output reg [7:0] addr_r,
output reg write_done,
output reg [7:0] data_r_o 
);





endmodule
