module horizontal_gradient(

//input wire grad_start,	
	input reg [7:0] windowBuffer[0:8],
	input reg start_calculations,
	output signed [10:0] gx
	
);
	
	wire signed [10:0] abs_gx;
	reg [7:0] P0,
	reg [7:0] P1,
	reg [7:0] P2,
	reg [7:0] P3,
	reg [7:0] P4,
	reg [7:0] P5,
	reg [7:0] P6,
	reg [7:0] P7,
	reg [7:0] P8,
	
	
	P0 = windowBuffer[0];
	P1= windowBuffer[1];
	P2 = windowBuffer[2];
	P3 = windowBuffer[3];
	P4 = windowBuffer[4];
	P5 = windowBuffer[5];
	P6 = windowBuffer[6];
	P7 = windowBuffer[7];
	P8 = windowBuffer[8];
	
	
		
		if (start_calculation == 1)
		begin	
			assign abs_gx=((P2-P0)+((P5-P3)<<1)+(P8-P6));//sobel mask for gradient in horiz. direction 
		end

		assign gx = (abs_gx[10]? ~abs_gx+1 : abs_gx);


endmodule



