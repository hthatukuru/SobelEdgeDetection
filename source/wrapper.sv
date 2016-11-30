
module wrapper(

	input reg [7:0] windowBuffer[0:8],
	input reg start_calculations,
	output wire signed [7:0] g
	
);
	wire signed [10:0] gx1;
	wire signed [10:0] gy1;
	wire signed [7:0] g1;

	horizontal_gradient HZ (.windowBuffer(windowBuffer) , .start_calculations(start_calculations), .gx(gx1));

	vertical_gradient VT (.windowBuffer(windowBuffer) , .start_calculations(start_calculations), .gy(gy1));

	total_gradient T (.gx(gx1) , .gy(gy1), .g(g1));

	assign g = g1;

endmodule
