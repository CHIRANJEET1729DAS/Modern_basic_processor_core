module execute(input wire clk , input wire[4:0] operand_1 , input wire [4:0] operand_2 , input wire [31:0] gpr_destination_address , input wire [3:0] alu_control , input wire reg_write, input wire [15:0] immediate_value,output reg[31:0] PC,output reg[31:0] result);

reg [31:0]  general_purpose_register [31:0];

always @(posedge clk)begin
	 case(alu_control)
		 4'b0001:begin
		   general_purpose_register[gpr_destination_address] <= operand_1+operand_2;
		   result <= general_purpose_register[gpr_destination_address];
			
		 end
                 4'b0010:begin
	           general_purpose_register[gpr_destination_address] <= operand_1 + immediate_value;
		   result <= general_purpose_register[gpr_destination_address];
		 end
		 4'b0011:begin
	           result <= {PC[31:28],gpr_destination_address,2'b0};
		   PC <= result;
		   general_purpose_register[gpr_destination_address]<= result;
	         end
         endcase
 end 
endmodule 

module tb;

//input vectors 
reg clk;
reg[4:0] operand_1;
reg[4:0] operand_2;
reg[31:0] gpr_destination_address;
reg[3:0] alu_control;
reg reg_write;
reg[15:0] immediate_value;
//output vectors
wire[31:0] PC;
wire[31:0] result;

execute uut(.clk(clk),.operand_1(operand_1),.operand_2(operand_2),.gpr_destination_address(gpr_destination_address),.alu_control(alu_control),.reg_write(reg_write),.immediate_value(immediate_value),.PC(PC),.result(result));

always begin
	#5 clk =~clk;
end
initial begin
	//initiate the signals
	clk = 1'b0;
	operand_1 = 5'b0;
	operand_2 = 5'b0;
	gpr_destination_address = 32'b0;
	alu_control = 4'b0;
	immediate_value = 16'b0;
	//hold
	#10
	//operation_1
	operand_1 = 5'h1;
	operand_2 = 5'h12;
	gpr_destination_address = 32'h21;
	alu_control = 4'b0001;
	immediate_value = 16'h12_12;
	$display("the operation is R type addition and the result is ::%1h ",result);
	#10
	//operation_2
	operand_1 = 5'h1;
        operand_2 = 5'h12;
        gpr_destination_address = 32'h21;
        alu_control = 4'b0010;
        immediate_value = 16'h12_12;
        $display("the operation is I type addi and the result is ::%1h ",result);
	//operand_3
	operand_1 = 5'h1;
        operand_2 = 5'h12;
        gpr_destination_address = 32'h21;
        alu_control = 4'b0011;
        immediate_value = 16'h12_12;
        $display("the operation is J type and the result is ::%1h ",result);
        $finish;
end
endmodule
