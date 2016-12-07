module flex_counter 

#
(
	parameter 	NUM_CNT_BITS 	= 	4
)

(
	input 	wire 	clk,
	input 	wire 	n_rst,
	input 	wire 	clear,
	input 	wire 	count_enable,
	input 	wire 	[ NUM_CNT_BITS - 1: 0 ] rollover_val,
	output 	wire 	[ NUM_CNT_BITS - 1: 0 ] count_out,
	output 	wire	rollover_flag
);

	reg [ NUM_CNT_BITS - 1: 0 ] count;
	reg [ NUM_CNT_BITS - 1: 0 ] next_count;
	reg rollover;
	reg rollover2;

	always_ff @ ( posedge clk, negedge n_rst )
	begin
		if( n_rst == 0 )
		begin
			count <= 0;
			rollover <= 0;
		end
		else
		begin
			count <= next_count;
			rollover <= rollover2;
		end
	end

	always_comb
	begin
		if( clear == 1 )
		begin
			next_count = 0;
			rollover2 = 0;
		end
		else
		begin
			if( count_enable == 1 )
			begin
				if( count == rollover_val )
					next_count = 1;
				else
					next_count = count + 1;

				if( next_count == rollover_val )
					rollover2 = 1;
				else
					rollover2 = 0;
			end
			else
			begin
				next_count = count;
				if( next_count == rollover_val )
					rollover2 = 1;
				else
					rollover2 = 0;
			end
		end
	end


	assign count_out = count;
	assign rollover_flag = rollover;

endmodule
