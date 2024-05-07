`ifndef TB_RAM
`define TB_RAM

`include "ram_interface.sv"
`include "ram_top.sv"

module tb_ram;

  // Ports Definition
  // Clk Generation    

  bit clk;

  initial begin  clk = 0;  end 

  always #5 clk = ~clk; 

  // interface
  ram_interface ram_interface_ins (clk);

  // top program
  ram_top ram_top_in (ram_interface_ins);   
  
  
  // DUT Instantiation
  ram #(
    .D_WIDTH(ram_interface_ins.D_WIDTH), 
    .A_WIDTH(ram_interface_ins.A_WIDTH), 
    .A_MAX(ram_interface_ins.A_MAX)
  )
  RAM (
    .clk(ram_interface_ins.clk),
    .address(ram_interface_ins.address),
    .data_write(ram_interface_ins.data_write),
    .write_enable(ram_interface_ins.write_enable),
    .rst(ram_interface_ins.rst),
    .data_read(ram_interface_ins.data_read)
  );

  initial begin #1000; $finish; end
  
  initial begin $dumpfile("dump.vcd"); $dumpvars; end
  
endmodule
`endif