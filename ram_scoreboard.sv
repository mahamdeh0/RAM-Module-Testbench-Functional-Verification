`ifndef	RAM_SCOREBOARD
`define	RAM_SCOREBOARD

`include "ram_transaction.sv"

class ram_scoreboard;

  //mailbox 
  mailbox mon2score;
  mailbox ref2score;

  // constructor
  function new (mailbox mon2score , mailbox ref2score);

    //connect mailboxes
    this.mon2score	= mon2score;
    this.ref2score 	= ref2score;
    
  endfunction

  // This task is used to drive stimulus on the interface
  task compare();

    //transaction object handler
    ram_transaction ram_transaction_exp_ins;
    ram_transaction ram_transaction_act_ins;

    forever begin 
      //transaction object instantiation
      ram_transaction_exp_ins=new();   
      ram_transaction_act_ins=new();

      // get transactions from mailboxes
      ref2score.get(ram_transaction_exp_ins);
      mon2score.get(ram_transaction_act_ins);

      //check if exp == act
      if (ram_transaction_exp_ins.data_read === ram_transaction_act_ins.data_read)
        begin
          $display ("The expected result %d, is equivalent actual result  %d.",ram_transaction_exp_ins.data_read,ram_transaction_act_ins.data_read);
        end
      else 
        begin
          $display ("The expected result:%d is NOT equal the actual result:%d",ram_transaction_exp_ins.data_read,ram_transaction_act_ins.data_read);
        end
    end
  endtask

endclass

`endif