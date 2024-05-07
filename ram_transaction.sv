`ifndef	RAM_TRANSACTION
`define	RAM_TRANSACTION

class ram_transaction;

  parameter D_WIDTH = 16;
  parameter A_WIDTH = 4;
  parameter A_MAX = 16; 

  rand logic                             rst;
  rand logic     [A_WIDTH-1:0]       address;
  rand logic     [D_WIDTH-1:0]    data_write;
  rand logic                    write_enable;
  logic     [D_WIDTH-1:0]     data_read;
  
  
endclass
`endif