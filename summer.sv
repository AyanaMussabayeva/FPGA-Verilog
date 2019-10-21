module summer(
	input clk,
	input reset_n, // active low reset
	//axi_stream slave interface 
	input s_valid, 
	input [31:0] s_data,
	//aci_stream master interface
	output s_ready, 
	output reg m_valid, 
	output reg [31:0] m_data,
	input m_ready);

assign  s_ready = m_ready;

always @(posedge clk) begin

	if (!reset_n) begin
		m_data <= 32'd0;
	end

	else if (s_valid & s_ready) begin
		m_data <= m_data + s_data;
	end

end

always @(posedge clk) begin

	if(!reset_n) begin
		m_valid <= 1'b0;
	end

	else begin
		m_valid <= s_valid;
	end

end