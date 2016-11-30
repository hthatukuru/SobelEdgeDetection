module vertical_gradient(

//input wire grad_start,	
	input reg [7:0] windowBuffer[0:8],
	input reg start_calculations,
	output signed [10:0] gy,
	
);

	wire signed [10:0] abs_gy;
	reg [7:0] P0;
	reg [7:0] P1;
	reg [7:0] P2;
	reg [7:0] P3;
	reg [7:0] P4;
	reg [7:0] P5;
	reg [7:0] P6;
	reg [7:0] P7;
	reg [7:0] P8;
	
	
	P0 = windowBuffer[0];
	P1 = windowBuffer[1];
	P2 = windowBuffer[2];
	P3 = windowBuffer[3];
	P4 = windowBuffer[4];
	P5 = windowBuffer[5];
	P6 = windowBuffer[6];
	P7 = windowBuffer[7];
	P8 = windowBuffer[8];
	
	if (start_calculation == 1)
	begin	
		assign abs_gy=((P0-P6)+((P1-P7)<<1)+(P2-P8)); //sobel mask for gradient in vertical direction 
	end
	
	assign gy = (abs_gy[10]? ~abs_gy+1 : abs_gy);

endmodule
