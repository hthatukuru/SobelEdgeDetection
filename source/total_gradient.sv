 module total_gradient (  
  input signed [10:0] gy,
  input signed [10:0] gx,
  output wire [7:0] g
);


//wire signed [10:0] abs_gx,abs_gy;	//it is used to find the absolute value of gx and gy 
wire [10:0] sum;			//the max value is 255*8. here no sign bit needed. 


	assign sum = (gx+gy);
//assign g =(|sum[10:8])?8'hff : sum[7:0];
  

	
	assign g = (sum[10] | sum[9] | sum[8]) ? 8'b11111111 : sum[7:0];

endmodule
  
