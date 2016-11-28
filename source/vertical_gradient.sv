module vertical_gradient(

//input wire grad_start,	
	input reg [7:0] P0,
	input reg [7:0] P1,
	input reg [7:0] P2,
	input reg [7:0] P3,
	input reg [7:0] P4,
	input reg [7:0] P5,
	input reg [7:0] P6,
	input reg [7:0] P7,
	input reg [7:0] P8,
	input reg start_calculations,
	output signed [10:0] gy,
	
);

always_comb	
	  if (start_calculation == 1)
		begin	
			assign gy=((P0-P6)+((P1-P7)<<1)+(P2-P8));//sobel mask for gradient in vertical direction 
		end
endmodule
