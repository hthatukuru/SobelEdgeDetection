module horizontal_gradient(

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
	output signed [10:0] gx
	
);
	
	wire signed [10:0] abs_gx;

		
		if (start_calculation == 1)
		begin	
			assign abs_gx=((P2-P0)+((P5-P3)<<1)+(P8-P6));//sobel mask for gradient in horiz. direction 
		end

	assign gx = (abs_gx[10]? ~abs_gx+1 : abs_gx);


endmodule



