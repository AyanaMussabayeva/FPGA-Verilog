//sequential circuits

module dff(
	//by default all inputs and outputs are WIREs
	input d, //may write input wire d;
	input clk, 
	input reset, 
	input preset,
	output reg q
);

//posedge = RE: clock goes from 0 to 1
//negedge = FE
always @(posedge clk) // sensitivity list (posedge clk), which means the circuit is sensitive only for clock 
	if(reset == 1)
		q <= 0;
	else if(preset == 1)
		q <= 1;
	else
		q <= d; //<= non-blocking assignment 
	// =  is blocking assignment 
	//all the left hand signals inside an always block should be reg type (see line 8)
	//all the right signals can be any type

endmodule 