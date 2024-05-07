`ifndef	RAM_ENVIROMENT
`define	RAM_ENVIROMENT

`include "ram_interface.sv"
`include "ram_driver.sv"
`include "ram_generator.sv"
`include "ram_monetor.sv"
`include "ram_ref_mod.sv"
`include "ram_scoreboard.sv"

class ram_environment;
  
  //objects handler
  ram_driver 		ram_driver_ins;
  ram_generator	    ram_generator_ins;
  ram_monetor		ram_monetor_ins;
  ram_ref_mod		ram_ref_mod_is;
  ram_scoreboard	ram_scoreboard_ins;
  
  //virtual interface
  virtual ram_interface ram_interface_ins;
  
  //mailbox
  mailbox gen2drive;
  mailbox mon2ref;
  mailbox mon2score;
  mailbox ref2score;
  
  function new(virtual ram_interface ram_interface_ins);
    
    //connect virtual interface
    this.ram_interface_ins=ram_interface_ins;
    
    //create nailbox
    gen2drive	=new();
    mon2ref		=new();
    mon2score	=new();
    ref2score	=new();
    
    //objects instantiation
    ram_driver_ins 		    = new (ram_interface_ins , gen2drive             );
    ram_generator_ins 		= new (gen2drive                                 );
    ram_monetor_ins 		= new (ram_interface_ins , mon2ref , mon2score   );
    ram_ref_mod_is 		    = new (mon2ref , ref2score                       );
    ram_scoreboard_ins 	    = new (mon2score , ref2score                     );
    
  endfunction
 
  task run();
    fork 
      begin
        ram_generator_ins.generating();
      end
      
      begin
        ram_driver_ins.drive();
      end
      
      begin
        ram_monetor_ins.input_monetor();
      end
      
      begin
        ram_monetor_ins.output_monetor();
      end
      
      begin
        ram_ref_mod_is.ref_model();
      end
      begin
        
        ram_scoreboard_ins.compare();
      end
      
    join
  endtask

endclass

`endif

