module memstate(input wire clk,input wire[31:0] general_purpose_register,input wire[31:0]address,input wire[31:0] destination_address);

reg [31:0] RAM[31:0];

always @(posedge clk)begin
	RAM[destination_address]<=general_purpose_register[address];
end 
endmodule

module testbench;

reg clk;
reg[31:0] general_purpose_register;
reg[31:0]address;
reg[31:0] destination_address;

memstate uut(.clk(clk),.general_purpose_register(general_purpose_register),.address(address),.destination_address(destination_address));

always begin
	#10 clk = ~clk;
end

initial begin
	clk = 1'b0;
	general_purpose_register = 32'b0;
	address = 32'b0;
	destination_address = 32'b0;
        #10
	general_purpose_register = 32'h12;
	address = 32'h1;
	destination_address = 32'h2;
	$display("The result is transferred to the RAM successfully");
end
endmodule
