`timescale 1ns / 100ps

module tb_ahb_master
();

   reg         tb_hresp; 
   reg 	       tb_hready;   
   reg [31:0]  tb_hrdata;   
//   reg 	       tb_write;    
   wire        tb_HRESET;   
   wire        tb_HCLK;     
   reg [31:0]  tb_haddr;  
   reg 	       tb_hwrite;   
   reg [2:0]  tb_hsize;   
   reg [31:0]  tb_hwdata;   
   reg [7:0]   tb_data_w;   
   reg [1:0]   tb_instruction;   
   reg [7:0]   tb_addr_r;   
   reg [7:0]   tb_addr_w;   
   reg [7:0]   tb_data_r;   
   reg 	       tb_busy;     
  integer testcase;
   reg [31:0]  tb_expected_haddr;  
   reg 	       tb_expected_hwrite;   
   reg [2:0]   tb_expected_hsize;   
   reg [31:0]  tb_expected_hwdata;
   reg [7:0]   tb_expected_data_r;   
   reg 	       tb_expected_busy;   
  
  ahb_master DUT (.hresp(tb_hresp), .hready(tb_hready), .hrdata(tb_hrdata), .HRESET(tb_HRESET), .HCLK(tb_HCLK), .haddr(tb_expected_haddr), .hwrite(tb_expected_hwrite), .hsize(tb_expected_hsize), .hwdata(tb_expected_hwdata), .data_r(tb_expected_data_r), .busy(tb_expected_busy), .data_w(tb_data_w), .instruction(tb_instruction), .addr_r(tb_addr_r), .addr_w(tb_addr_w));
   

  
  initial
    begin
  
  //initialization
 


    end // initial begin
   
endmodule

