`ifndef	RAM_MON
`define	RAM_MON

`include "ram_transaction.sv"
`include "ram_interface.sv"

class ram_monetor;

  //virtual interface 
  virtual ram_interface ram_interface_ins;

  //mailbox
  mailbox mon2ref;
  mailbox mon2score;

  // constructor
  function new (virtual ram_interface ram_interface_ins , mailbox mon2ref , mailbox mon2score);
    
    //connect interface
    this.ram_interface_ins	= ram_interface_ins;

    //connect mailboxes
    this.mon2ref	= mon2ref;
    this.mon2score 	= mon2score;
    
  endfunction

  // this task is used to drive stimulus on the interface
  task input_monetor ();

    //transaction object handler
    ram_transaction ram_transaction_in_ins;
    

    forever @(negedge ram_interface_ins.clk) begin 
      
      //transaction object instantiation
      ram_transaction_in_ins=new();   

      // reading inputs from interface
      ram_transaction_in_ins.rst 	=  ram_interface_ins.rst;
      ram_transaction_in_ins.address		=  ram_interface_ins.address	;
      ram_transaction_in_ins.write_enable		=  ram_interface_ins.write_enable;
      ram_transaction_in_ins.data_write		=  ram_interface_ins.data_write;


      // put transactions
      mon2ref.put(ram_transaction_in_ins);            
    end
  endtask

  // this task is used to drive stimulus on the interface
  task output_monetor ();

    //transaction object handler
    ram_transaction ram_transaction_out_ins;

    // To sync between the mailboxes
     @(negedge ram_interface_ins.clk);

    forever @(negedge ram_interface_ins.clk) begin 
      //transaction object instantiation
      ram_transaction_out_ins=new();

      // reading outputs from interface
      ram_transaction_out_ins.data_read		= ram_interface_ins.data_read;

      // put transactions
      mon2score.put(ram_transaction_out_ins);
    end
  endtask

endclass

`endif