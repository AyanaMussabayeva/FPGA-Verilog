/*Using the above circuit, build a simple voting machine. Use the 4 push buttons to
represent 4 candidates and use the 5th push button as reset. To see the number of votes
received by each candidate, use the DIP switch. Meaning when the first DIP switch is
turned on, number of votes received by first candidate should be shown. When the
second switch is on, number of votes received by second candidate should be shown, so
on and so forth. The limitation is since there are only 8 LEDs, the maximum vote for a
candidate cannot be more than 255. */

module button(
  input   clk,
  input   reset,
  input   button1,
  input   button2,
  input   button3,
  input   button4,
  input   cand_1,
  input   cand_2,
  input   cand_3,
  input   cand_4,
  output reg[7:0]  counter_vote
  );

reg [7:0] press_counter_1;
reg [7:0] press_counter_2;
reg [7:0] press_counter_3;
reg [7:0] press_counter_4;

reg [25:0] counter1;
reg [25:0] counter2;
reg [25:0] counter3;
reg [25:0] counter4;

always @(posedge clk)
  begin
    if(reset)
        counter1 <= 26'd0;
  else if(button1 & (counter1 < 26'h3ffffff))
        counter1 <= counter1 + 1;
  else if(!button1)
        counter1 <= 0;
  
end
always @(posedge clk)
begin
    if(reset)
        counter2 <= 26'd0;
  else if(button2 & (counter2 < 26'h3ffffff))
        counter2 <= counter2 + 1;
  else if(!button2)
        counter2 <= 0;
  
end
always @(posedge clk)
begin
    if(reset)
        counter3 <= 26'd0;
  else if(button3 & (counter3 < 26'h3ffffff))
        counter3 <= counter3 + 1;
  else if(!button3)
        counter3 <= 0;
  
end
always @(posedge clk)
begin
    if(reset)
        counter4 <= 26'd0;
  else if(button4 & (counter4 < 26'h3ffffff))
        counter4 <= counter4 + 1;
  else if(!button4)
        counter4 <= 0;
  
end     
        
always @(posedge clk)
begin
  if(reset) begin
    press_counter_1 <= 0;
    press_counter_2 <= 0;
    press_counter_3 <= 0;
    press_counter_4 <= 0;
  end
  else if(counter1 == 50000000)
        press_counter_1 <= press_counter_1 + 1;
  else if(counter2 == 50000000)
    press_counter_2 <= press_counter_2 + 1;
  else if(counter3 == 50000000 )
    press_counter_3 <= press_counter_3 + 1;
  else if(counter4 == 50000000)
    press_counter_4 <= press_counter_4 + 1;  
  
end

always @(posedge clk) begin
  if(reset)
    counter_vote <= 0;
  else if(cand_1)
    counter_vote <= press_counter_1;
  else if(cand_2)
    counter_vote <= press_counter_2;
  else if(cand_3)
    counter_vote <= press_counter_3;
  else if(cand_4)
    counter_vote <= press_counter_4;

end

endmodule