module horizontal_gradient(

//input wire grad_start,	
	input reg [7:0] P1,
	input reg [7:0] P2,
	input reg [7:0] P3,
	input reg [7:0] P4,
	input reg [7:0] P5,
	input reg [7:0] P6,
	input reg [7:0] P7,
	input reg [7:0] P8,
	input reg [7:0] P9,
	output reg [7:0] gx,
	//output reg [7:0] gy
	//output wire grad_done
);


always_comb
	begin
		//if (grad_start)
		//begin
			//gx				
			gx = (P7 + P8 * 2 + P9) - (P1 + P2 * 2 + P3);
			if ((P7 + P8 * 2 + P9) - (P1 + P2 * 2 + P3) < 0)
			begin
				gx = 0;
			end
			else if ((P7 + P8 * 2 + P9) - (P1 + P2 * 2 + P3) > 255)
			begin 
				gx = 255;
			end
			//gy
			gy = (P3 + P6 * 2 + P9) - (P1 + P4 * 2 + P7);
			
			if ((P3 + P6 * 2 + P9) - (P1 + P4 * 2 + P7) < 0)
			begin
				gy = 0;
			end
			else if ((P3 + P6 * 2 + P9) - (P1 + P4 * 2 + P7) > 255)
			begin 
				gy = 255;
			end


		//end
		//else
		//begin
		//	gx = 0;
		//	gy = 0;
		//end	
	end





endmodule
