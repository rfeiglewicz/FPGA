module Debouncer (input CLK,CEI,PUSH,CLR,
                output  PE);

reg [2:0] DELAY;

always @(posedge CLK, posedge CLR) begin
    if ( CLR == 1'b1) DELAY <= 0;
    else if (CLK == 1'b1) 
        if(CEI == 1'b1)  DELAY <= {DELAY[1:0],PUSH};   //from simulation you must add propagation delay
    
end

assign  PE = (DELAY == 3'b011 && CEI == 1'b1)? 1'b1 : 1'b0;

endmodule