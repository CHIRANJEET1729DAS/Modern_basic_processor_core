module memstate(input wire clk,input wire[31:0] general_purpose_register,input wire[31:0]address_on_gpr,input wire[31:0] destination_address_on_ram);

reg [31:0] RAM[31:0];

always @(posedge clk)begin
	RAM[destination_address_on_ram]<=general_purpose_register[address_on_gpr];
end 
endmodule

module testbench;

reg clk;
reg[31:0] general_purpose_register;
reg[31:0]address_on_gpr;
reg[31:0] destination_address_on_ram;

memstate uut(.clk(clk),.general_purpose_register(general_purpose_register),.address_on_gpr(address_on_gpr),.destination_address_on_ram(destination_address_on_ram));

always begin
	#10 clk = ~clk;
end

initial begin
	clk = 1'b0;
	general_purpose_register = 32'b0;
	address_on_gpr = 32'b0;
	destination_address_on_ram = 32'b0;
        #10
	general_purpose_register = 32'h12;
	address_on_gpr = 32'h1;
	destination_address_on_ram = 32'h2;
	$display("The result is transferred to the RAM successfully");
end
endmodule
