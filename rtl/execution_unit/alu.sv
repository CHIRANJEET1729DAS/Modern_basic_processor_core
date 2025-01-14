module alu(input wire clk , input wire[4:0] operand_1 , input wire [4:0] operand_2 , input wire [3:0] alu_control ,output reg[31:0] result);

always @(posedge clk)begin
	 case(alu_control)
		 4'b0001:begin
                   result <= operand_1+operand_2;
		 end
		 4'b0010:begin
		   result <= operand_1 - operand_2;
	         end 
                 4'b0011:begin
	           result <= operand_1 & operand_2;
	         end
                 4'b0100:begin
	           result <= operand_1 << operand_2[4:0];
                 end
                 4'b0101:begin
		   result <= operand_1 >> operand_2[4:0];
	         end	
	         4'b0110:begin
		   result <= operand_1 & operand_2;
		 end
		 4'b0111:begin
		   result <= operand_1 | operand_2;
		 end
		 4'b1000:begin
		   result <= operand_1 * operand_2;
		 end 
		 4'b1001:begin
		   result <= (operand_1 < operand_2) ? 1:0;
		 end
		 4'b1010:begin
		   result <= (operand_1 > operand_2) ? 1:0;
		 end
		 4'b1011:begin
		   result <= (operand_1 == operand_2) ? 1:0;
                 end
         endcase
 end 
endmodule

module tb;
reg clk;
reg[4:0] operand_1;
reg[4:0] operand_2;
reg[3:0] alu_control;

//output
wire[31:0] result;

alu uut(.clk(clk),.operand_1(operand_1),.operand_2(operand_2),.alu_control(alu_control),.result(result));

always begin
	#5 clk =~clk;
end
initial begin
	//initiate the signals
	clk = 1'b0;
	operand_1 = 5'b0;
	operand_2 = 5'b0;
	alu_control = 4'b0;
	//hold
	#10
	//operation_1
	operand_1 = 5'h1;
	operand_2 = 5'h12;
	alu_control = 4'b0001;
	$display("the operation is addition and the result is ::%1h ",result);
	#10
	//operation_2
	operand_1 = 5'h1;
        operand_2 = 5'h12;
        alu_control = 4'b0010;
	$display("the operation id R type substraction and the result is ::%1h ",result);
        $finish;
end
endmodule













