// $Id: $
// File name:   ahb_slave.sv
// Created:     4/27/2016
// Author:      Junyan Shi
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: ahb_slave
module ahb_slave
(
 input reg [31:0]  haddr,
 input reg 	  hwrite,
 input reg [2:0]   hsize,
 input reg 	  hsel,
 input reg [31:0]  hwdata,
 input wire 	  HRESET,
 input wire 	  HCLK,
 output reg 	  hready,
 output reg 	  hreadyout,
 output reg 	  hresp,
 output reg [31:0] hrdata,
 output reg start,
 output reg [11:0] width,
 output reg [11:0] length,
 output reg [7:0] initial_addr_r,
 output reg [7:0] initial_addr_w
);

always_comb
  begin
     start = hreadyout;
     width = hwdata[11:0];
     length = hwdata[23:12];

     initial_addr_r = haddr[7:0];
     initial_addr_w = haddr[15:8];
     
  end
   
endmodule
