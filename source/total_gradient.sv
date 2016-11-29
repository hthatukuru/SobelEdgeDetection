 module total_gradient (  
  input signed [10:0] gy,
  input signed [10:0] gx,
  output reg [7:0] G
);


wire signed [10:0] abs_gx,abs_gy;	//it is used to find the absolute value of gx and gy 
wire [10:0] sum;			//the max value is 255*8. here no sign bit needed. 


assign sum = (gx+gy);
assign G = (|sum[10:8])?8'hff : sum[7:0];

endmodule 
  
