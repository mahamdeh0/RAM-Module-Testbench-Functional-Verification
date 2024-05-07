`ifndef	RAM_DRIVER
`define	RAM_DRIVER

`include "ram_transaction.sv"
`include "ram_interface.sv"

class ram_driver;

  //virtual interface 
  virtual ram_interface ram_interface_ins;

  //mailbox 
  mailbox gen2drive;

  // constructor
  function new (virtual ram_interface ram_interface_ins , mailbox gen2drive);

    //connect interface
    this.ram_interface_ins=ram_interface_ins;

    //connect mailbox
    this.gen2drive=gen2drive;

  endfunction

  // this task is used to drive stimulus on the interface
  task drive ();

    //transaction object handler
    ram_transaction ram_transaction_ins;

    forever @(posedge ram_interface_ins.clk) begin 

      //transaction object instantiation
      ram_transaction_ins=new();

      // get transactions
      gen2drive.get(ram_transaction_ins);

      // writing on the interface
      ram_interface_ins.rst	            = 0;
      ram_interface_ins.data_write		= ram_transaction_ins.data_write;
      ram_interface_ins.write_enable	= ram_transaction_ins.write_enable;
      ram_interface_ins.address		    = ram_transaction_ins.address;
    end
  endtask

endclass

`endif