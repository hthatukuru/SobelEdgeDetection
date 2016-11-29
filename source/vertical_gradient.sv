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

	wire signed [10:0] abs_gy
	
	if (start_calculation == 1)
	begin	
		assign abs_gy=((P0-P6)+((P1-P7)<<1)+(P2-P8));//sobel mask for gradient in vertical direction 
	end
	
	assign gy = (abs_gy[10]? ~abs_gy+1 : abs_gy);

endmodule
