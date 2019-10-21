//store 16 8-bit positive data in fifo
//find largest 

module findLargest(
	input wire i_clock,
	input wire i_reset,

	input wire i_fifo_wr_valid,
	output wire o_fifo_wr_ready,
	input wire [7:0] i_fifo_wr_data,

	//read interface 
	//input i_fifo_rd_ready

	//output interface 

	output wire [7:0] o_largest,
	output wire o_done;
	);

reg [7:0] largest;
reg [1:0] state;
reg fifo_rd;
reg [4:0] counter;
wire fifo_rd_valid,
wire [7:0] fifo_rd_data;
localparam IDLE = 2'b0; 
localparam FIFO_READ = 2'b1;
localparam COMPARE = 2'b10; 
 
assign o_largest = largest;
assign o_done = (counter == 5'd16)? 1'b1 : 1'b0; 
//all the formal outputs should be wire types
//FIFO instantiation 
myFifo myFifo (
  .s_axis_aresetn(i_reset),  // input wire s_axis_aresetn
  .s_axis_aclk(i_clock),        // input wire s_axis_aclk
  .s_axis_tvalid(i_fifo_wr_valid),    // input wire s_axis_tvalid
  .s_axis_tready(o_fifo_wr_ready),    // output wire s_axis_tready
  .s_axis_tdata(i_fifo_wr_data),      // input wire [7 : 0] s_axis_tdata
  .m_axis_tvalid(fifo_valid_data),    // output wire m_axis_tvalid
  .m_axis_tready(fifo_rd),    // input wire m_axis_tready
  .m_axis_tdata(fifo_rd_data)      // output wire [7 : 0] m_axis_tdata
);

always @(posedge i_clock) begin
	if (!i_reset) begin
		largest <= 8'd0; //when reset is applied every signal on the lhs 
		state <= IDLE; 
		fifo_rd <= 1'b0;
		counter <= 0;
	else 
		case(state)
			IDLE: begin  //in IDLE statew we chack whether there is data in FIFO. if yes, then go to s1, else stay in IDLE
				if(fifo_valid_data) begin
					fifo_rd <= 1'b1;
					state <= FIFO_READ;
				end
				else begin
					state <= IDLE;
					fifo_rd <= 1'b0;
				end
			end
			FIFO_READ: begin
				fifo_rd <= 1'b0; // restrict the output of FIFO as only one data 
				state <= COMPARE;
			end
			COMPARE: begin
				if(largest < fifo_rd_data)
					largest <= fifo_rd_data;
				state <= IDLE;
				counter <= counter + 1;
			end
		endcase
	
end

endmodule; 