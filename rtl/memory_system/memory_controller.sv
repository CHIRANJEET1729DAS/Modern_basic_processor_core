module memory_controller(input wire clk,input reset);

wire [1023:0] instruction_cache,data_cache;
wire [31:0] instruction,data;
wire [1:0] index_for_quick_access;

instruction_cache_unit ins_init (.clk(clk),.reset(reset),.instruction_cache(instruction_cache),.instruction(instruction),.index_for_qick_access(index_for_quick_access));

data_cache_unit data_init (.clk(clk),.reset(reset),.data_cache(data_cache),.data(data),.index_for_quick_access(index_for_quick_access));

always @(posedge clk or posedge reset) begin
	if(reset) begin
		index_for_quick_access <= 2'b0;
	end
end
endmodule
