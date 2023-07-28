

module ring_counter (
   
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
   
      
   
   
`endif

    input Clock, Reset, output [3:0] Count_out, output wire [3:0] io_oeb);
    
    reg [3:0] Count_temp;
    assign io_oeb = 4'b0000;

    //Whenever the Clock changes from 0 to 1(positive edge) or 
    //a change in Reset, execute the always block.
    always @(posedge Clock or posedge Reset)
    begin
        if(Reset == 1'b1)   begin  //when Reset is high 
            Count_temp = 4'b0001;   end  //The Count value is reset to "0001".
        else if(Clock == 1'b1)  begin  //When the Clock is high
            //Left shift the Count value.
            Count_temp = {Count_temp[2:0],Count_temp[3]};   end 
    end
    
    //The Count value is assigned to final output port.
    assign Count_out = Count_temp;
    
endmodule
`default_nettype wire
