  module total_gradient (  
  input signed [10:0] gy,
  input signed [10:0] gx,
  input reg start_t_grad,
  output reg [7:0] g
);


//wire signed [10:0] abs_gx,abs_gy;	//it is used to find the absolute value of gx and gy 
reg [10:0] sum;			//the max value is 255*8. here no sign bit needed. 
reg [10:0] final_sum;

	//assign sum = (gx+gy);
//assign g =(|sum[10:8])?8'hff : sum[7:0];
	
  

	
		//assign g = (start_t_grad ? ((sum[10] | sum[9] | sum[8]) ? 8'b11111111 : sum[7:0]) : 0;
	//assign final_sum = (sum[10] | sum[9] | sum[8]) ? 8'b11111111 : sum[7:0];
	
	//assign g = (sum[10] | sum[9] | sum[8]) ? 8'b11111111 : sum[7:0];

	always_comb
	begin
		if (start_t_grad == 1)
		begin
			sum = (gx+gy);
			if (sum[10] | sum[9] | sum[8])
				g = 8'b11111111;
			else
				g = sum[7:0];
		end
		else
		begin
			g = 0;
		end
	end


	
	
endmodule
  
