`ifndef	RAM_REF_MOD
`define	RAM_REF_MOD

`include "ram_transaction.sv"

class ram_ref_mod;

  //mailbox 
  mailbox mon2ref;
  mailbox ref2score;

  parameter D_WIDTH = 16;
  parameter A_WIDTH = 4;
  parameter A_MAX = 16; 
  reg [D_WIDTH-1:0] memory [A_MAX-1:0];

  // constructor
  function new (mailbox mon2ref , mailbox ref2score);

    //connect mailboxes
    this.mon2ref	= mon2ref;
    this.ref2score 	= ref2score;

  endfunction

  // this task is used to drive stimulus on the interface
  task ref_model ();

    //transaction object handler
    ram_transaction ram_transaction_in_ins;
    ram_transaction ram_transaction_out_ins;
    

    forever begin 

      //transaction object instantiation
      ram_transaction_in_ins=new();   
      ram_transaction_out_ins=new();


      // get transactions from monitor mailbox
      mon2ref.get(ram_transaction_in_ins);

      if (ram_transaction_in_ins.rst) begin
        for(int i =0; i<D_WIDTH; i=i+1) begin
          for(int j =0; j< A_MAX; j=j+1) begin
            memory[i][j]=0;
          end
        end
        ram_transaction_out_ins.data_read=0;
      end
      else begin
        if (ram_transaction_in_ins.write_enable) begin

          memory[ram_transaction_in_ins.address] <= ram_transaction_in_ins.data_write;

        end
        else begin
          ram_transaction_out_ins.data_read <= memory[ram_transaction_in_ins.address];
        end
      end
      
    ref2score.put(ram_transaction_out_ins);
    end
  endtask

endclass

`endif