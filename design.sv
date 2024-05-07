/* 
 * Random Access Memory (RAM) with
 * 1 read port and 1 write port
 */
module ram (clk, address,
            data_write, write_enable,
            rst,data_read);

  parameter D_WIDTH = 16;
  parameter A_WIDTH = 4;
  parameter A_MAX = 16; // 2^A_WIDTH

  input                clk,rst;
  input  [A_WIDTH-1:0] address;
  input  [D_WIDTH-1:0] data_write;
  input                write_enable;
  output reg [D_WIDTH-1:0] data_read;

  
  // Memory as multi-dimensional array
  reg [D_WIDTH-1:0] memory [A_MAX-1:0];

  // Write data to memory
  always @(posedge clk) begin
    if(rst) begin
      for(int i =0; i<D_WIDTH; i=i+1) begin
        for(int j =0; j< A_MAX; j=j+1) begin
          memory[i][j]=0;
        end
      end
      data_read=0;
    end//rst
    
    else begin
      if (write_enable) begin
        memory[address] <= data_write;
      end
      else begin   // Read data from memory
        data_read <= memory[address];
      end

    end//not rst

  end
endmodule