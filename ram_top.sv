`ifndef	RAM_TOP
`define	RAM_TOP

`include "ram_interface.sv"
`include "ram_environment.sv"

program ram_top (ram_interface ram_interface_ins);

  //virtual interface
  virtual ram_interface ram_interface_ins_h;

  //environment instance
  ram_environment ram_environment_ins;

  initial begin

    //connect virtual interface
    ram_interface_ins_h=ram_interface_ins;

    //objects instantiation
    ram_environment_ins = new (ram_interface_ins_h);   

    ram_environment_ins.run();

  end

endprogram

`endif