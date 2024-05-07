`ifndef	RAM_GENERATOR
`define	RAM_GENERATOR

`include "ram_transaction.sv"

class ram_generator;

  //number of transactions
  rand int num_of_trans;

  //mailbox 
  mailbox gen2drive;

  function new ( mailbox gen2drive );

    this.gen2drive = gen2drive;

  endfunction

  // This task is used to generate stimulus and send it to Driver
  task generating ();

    //transaction object handler

    ram_transaction ram_transaction_ins;

    num_of_trans=$urandom_range(300,400);

    for (int i =0; i< num_of_trans; i++) begin 

      //transaction object instantiation
      ram_transaction_ins=new();

      //transaction object randomization
      ram_transaction_ins.randomize();

      // Write Trans to MailBox
      gen2drive.put(ram_transaction_ins);
    end

  endtask

endclass

`endif