module write_back(input wire clk , input wire[31:0]RAM,input [31:0]address, input wire[31:0]destination_address);

reg[31:0] GPR[31:0];

always @(posedge clk)begin
	GPR[destination_address] <= RAM[address];
end
endmodule

module testbench;
reg clk;
reg[31:0] RAM;
reg[31:0] address;
reg[31:0] destination_address;

write_back uut (.clk(clk),.RAM(RAM),.address(address),.destination_address(destination_address));

always begin
	#10 clk = ~clk;
end

initial begin
	clk = 32'b0;
	RAM = 32'b0;
	address = 32'b0;
	destination_address = 32'b0;
        
	#10

	RAM = 32'h12;
	address = 32'h21;
	destination_address = 32'h11;

	$display("The result is successfully transferred to the destination GPR");
	$finish;  
end
endmodule 
