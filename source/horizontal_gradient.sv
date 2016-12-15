module horizontal_gradient(

//input wire grad_start,	
	input reg [7:0] windowBuffer[0:8],
	input reg start_calculations,
	output reg signed [10:0] gx,
	output reg h_done
	
);
	
	reg signed [10:0] abs_gx;
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
	assign P1= windowBuffer[1];
	assign P2 = windowBuffer[2];
	assign P3 = windowBuffer[3];
	assign P4 = windowBuffer[4];
	assign P5 = windowBuffer[5];
	assign P6 = windowBuffer[6];
	assign P7 = windowBuffer[7];
	assign P8 = windowBuffer[8];
	
	
	always_comb
	begin

		if (start_calculations == 1)	
		begin
			abs_gx=((P2-P0)+((P5-P3)<<1)+(P8-P6));	//sobel mask for gradient in horiz. direction 
			if (abs_gx[10] == 1) // && start_calculations == 1)
			begin
				gx = ~abs_gx + 1;
				h_done = 1;
			end	
			else
			begin
				gx = abs_gx;
				h_done = 1;
			end
		end
		
		else
		begin
			gx = 0;
			h_done = 0;

		end

	end


	//assign gx = (abs_gx[10]? ~abs_gx+1 : abs_gx);

endmodule

