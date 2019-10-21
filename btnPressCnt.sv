/*Build a circuit which counts the number of times you press a push button on the
ZedBoard. The number of times that you pressed the button should be displayed using
the LEDs. There should be provision for reset which makes the LED output as zero.
*/
module btnPressCnt(
	input clk,
	input reset, 
	input btn, 
	output reg [7:0] pressCnt
	);

reg [25:0] cnt; 
always @(posedge clk) begin
	if (reset) begin
		cnt <= 26'd0;
	end
	else if (btn & cnt < 26'b11111111111111111111111111) begin
		cnt <= cnt + 1;
	end
	else if (!btn) begin
		cnt <= 0;
	end
end

always @(posedge clk)
begin
    if(reset)
        pressCnt <= 0;
    else if(cnt == 50000000)
        pressCnt <= pressCnt+1;
end

endmodule