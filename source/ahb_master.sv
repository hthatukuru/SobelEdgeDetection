module ahb_master
(
	//transfer and response

	input reg 	  hresp,
	input reg 	  hready,
	input reg [31:0]  hrdata,
	input wire 	  HRESET,
	input wire 	  HCLK,
	output reg [31:0] haddr,
	output reg 	  hwrite,
	output reg [2:0]  hsize,
	output reg [31:0] hwdata,
	 input reg [7:0] data_w,
	 input reg [1:0] instruction,
	 input reg [7:0] addr_r,
	 input reg [7:0] addr_w,
	 output reg [7:0] data_r,
	 output reg busy
);
	reg [31:0] next_haddr;
	reg next_hwrite;
	reg next_hsize;
	reg [31:0] next_hwdata;
	reg [31:0] next_rdata;
   reg 		   rdata;


	always_ff @ (posedge HCLK, negedge HRESET)
	begin
		if (!HRESET)
		begin
			haddr <= 0;
			hwrite <= 0;
			hsize <= 0;
			hwdata <= 0;
			rdata <= 0;		
		end
		else
		begin
			haddr <= next_haddr;
			hwrite <= next_hwrite;
			hsize <= next_hsize;
			hwdata <= next_hwdata;
			rdata <= next_rdata;
			if (!hready)
			begin
				hwdata <= hwdata;
				rdata <= rdata;
			end
		end		
	end

	always_comb
	begin
		if (instruction == 2'b10) //write
		begin
			next_hwrite = 1;
			next_hsize = 3'b000;//write 1 byte 
			next_haddr = addr_w;
			next_hwdata = data_w;
			if (!hready)
			begin
				next_haddr = haddr;
				next_hwdata = hwdata;
			end
			
		end
		else if (instruction == 2'b01)//read
		begin
			next_hwrite = 0;
			next_hsize = 3'b000;//read 1 byte
			next_haddr = addr_r;
			next_rdata = hrdata;
			next_hwdata = 0;
			if (!hready)
			begin
				next_haddr = haddr;
				next_rdata = rdata;
			end
		end
		else
		begin
			next_hwrite = 0;
			next_hsize = 3'b000;
			next_haddr = 0;
			next_hwdata = 0;
		end
	end
endmodule
