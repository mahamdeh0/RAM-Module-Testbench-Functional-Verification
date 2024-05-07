`ifndef	RAM_INTERFACE
`define	RAM_INTERFACE

interface ram_interface(input logic clk);
  
  parameter D_WIDTH = 16;
  parameter A_WIDTH = 4;
  parameter A_MAX = 16; 

  logic                             rst;
  logic     [A_WIDTH-1:0]       address;
  logic     [D_WIDTH-1:0]    data_write;
  logic                    write_enable;
  logic     [D_WIDTH-1:0]     data_read;


endinterface
`endif