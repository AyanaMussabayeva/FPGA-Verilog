//linear feedback shift reguster
module lfsr(
	input wire clk,
	input wire reset 
	output reg [7:0] led
);

reg [26:0] counter;

always @(posedge clk)
begin
	if(counter < 27'd100000000) //27 flip flops (bits) needed to store 10^8 decimal (for delay to be exactly one second) 
		counter <= counter + 1;
	else
		counter <= 27'd0; 
end


always @(posedge clk)
begin
	/*led[0] <= led[1];
	led[1] <= led[2];
	led[2] <= led[3];
	led[3] <= led[4];
	led[4] <= led[5];
	led[5] <= led[6];
	led[6] <= led[7];
	led[7] <= led[0];*/
	if(reset)//if resett is pressed initialize to 00000001
		led[7:0] <= 8'b00000001; //8 bits binary 1
	else if(counter  == 27'd0)  // if counter == 27 bits decimal 0 and reset is not pressed
		led[7:0] <= {led[0], led[7:1]};
	//else output remains as before
end

endmodule