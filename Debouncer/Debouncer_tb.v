`timescale 1 ns / 100 ps
module Debouncer_tb;

reg CLK,CEI,PUSH,CLR;
wire PE;
localparam period = 4; //clock half period
Debouncer UUT (.CLK(CLK),.CEI(CEI),.PUSH(PUSH),.CLR(CLR),.PE(PE));


initial begin
    CLK = 1'b1;
    CEI = 1'b0;
    PUSH = 1'b0;
    CLR = 1'b1;

end


always begin //clock 
   #period CLK = ~CLK;
end

always begin //clear after 5 ns  
   #5 CLR = 1'b0;
end

always  begin // Prescaler output
 #(29*period);
 #4.5;
 CEI = 1'b1;
 #(2*period);
 CEI = 1'b0;   
end

//PUSH stimulus
always begin
    #(62*period);//key setting
    #1 PUSH = 1'b1;
    #17 PUSH = 1'b0;
    #1 PUSH = 1'b1;
    #1 PUSH = 1'b0;
    #1 PUSH = 1'b1;
	#(100*period);
	PUSH = 1'b0;
	#(40*period)  PUSH = 1'b1;
	

    #(200*period);
    $finish;

end

endmodule