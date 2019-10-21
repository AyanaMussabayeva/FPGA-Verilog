module alu(
	input wire [7:0] A,
	input wire [7:0] B, 
	input wire [1:0] Op,
	output wire [7:0] O
);

wire [7:0] adderOut;
wire [7:0] substractOut;
wire [7:0] comparOut;

module adder adder1(
	.A(A), 
	.B(B),
	.O(adderOut)
);

module subtractor sub1(
	.A(A), 
	.B(B),
	.O(substractOut)
);
module comparator(
	.A(A), 
	.B(B),
	.O(comparOut)
);

assign O = (Op == 0)? adderOut: ((Op == 1)? substractOut : comparOut)
endmodule 