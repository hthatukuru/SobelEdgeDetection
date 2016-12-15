`timescale 1ns / 100ps

module tb_ahb_slave
();

   reg [31:0]  tb_haddr; 
   reg 	       tb_hwrite;   
   reg [2:0]   tb_hsize;   
   reg 	       tb_hsel;   
   reg [31:0]  tb_hwdata;   
   wire        tb_HRESET;   
   wire        tb_HCLK;   
   reg 	       tb_hready;   
   reg 	       tb_hreadyout;   
   reg 	       tb_hresp;   
   reg [31:0]  tb_hrdata;  
   reg 	       tb_start;   
   reg [11:0]  tb_width;   
   reg [11:0]  tb_length;   
   reg [7:0]   tb_initial_addr_r;   
   reg [7:0]   tb_initial_addr_w;      
  integer testcase;
   reg 	  tb_expected_hready;   
   reg 	  tb_expected_hreadyout;   
   reg 	  tb_expected_hresp;   
   reg [31:0] tb_expected_hrdata ;   
   reg 	      tb_expected_start;   
   reg [11:0] tb_expected_width;   
   reg [11:0] tb_expected_length;   
   reg [7:0]  tb_expected_initial_addr_r;  
   reg [7:0]  tb_expected_initial_addr_w;
   
  
  ahb_slave DUT (.haddr(tb_haddr), .hwrite(tb_hwrite), .hsize(tb_hsize), .hsel(tb_hsel), .hwdata(tb_hwdata), .HRESET(tb_HRESET), .HCLK(tb_HCLK), .hready(tb_expected_hready), .hreadyout(tb_expected_hreadyout), .hresp(tb_expected_hresp), .hrdata(tb_expected_hrdata), .start(tb_expected_start), .width(tb_expected_width), .length(tb_expected_length), .initial_addr_r(tb_expected_initial_addr_r), .initial_addr_w(tb_expected_initial_addr_w));
   

  
  initial
    begin
  
  //initialization
 


    end // initial begin
   
endmodule

