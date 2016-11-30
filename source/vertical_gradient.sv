module vertical_gradient(

//input wire grad_start,	
	input reg [7:0] windowBuffer[0:8],
	input reg start_calculations,
	output signed [10:0] gy,
	
);

	wire signed [10:0] abs_gy;
	wire [7:0] P0;
	wire [7:0] P1;
	wire [7:0] P2;
	wire [7:0] P3;
	wire [7:0] P4;
	wire [7:0] P5;
	wire [7:0] P6;
	wire [7:0] P7;
	wire [7:0] P8;
	
	
	assign P0 = windowBuffer[0];
	assign P1 = windowBuffer[1];
	assign P2 = windowBuffer[2];
	assign P3 = windowBuffer[3];
	assign P4 = windowBuffer[4];
	assign P5 = windowBuffer[5];
	assign P6 = windowBuffer[6];
	assign P7 = windowBuffer[7];
	assign P8 = windowBuffer[8];
	
	always_comb
	begin
		if (start_calculation == 1)
			assign abs_gy=((P0-P6)+((P1-P7)<<1)+(P2-P8)); //sobel mask for gradient in vertical direction 
	end
	
	assign gy = (abs_gy[10]? ~abs_gy+1 : abs_gy);

endmodule
