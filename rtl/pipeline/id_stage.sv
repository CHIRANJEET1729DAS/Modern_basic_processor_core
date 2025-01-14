module decode(input wire clk,input wire [31:0] instruction,input wire [31:0] general_purpose_register,output reg [4:0] operand_1,output reg [4:0] operand_2,output reg [4:0] gpr_destination_address,output reg [3:0] alu_control,output reg reg_write,output reg [15:0] immediate_value); 

// Decoding the instruction
wire [5:0] opcode = instruction[31:26];
wire [4:0] rs = instruction[25:21];
wire [4:0] rt = instruction[20:16];
wire [4:0] rd = instruction[15:11];
wire [15:0] immediate = instruction[15:0];

// Combinational logic
always @(opcode or general_purpose_register[rs] or general_purpose_register[rt] or gpr_destination_address[rd] or immediate) begin
    case(opcode)
        6'b000000: begin // R type instruction (like add, subtract, division etc)
            alu_control <= 4'b0001;
            operand_1 <= general_purpose_register[rs];
            operand_2 <= general_purpose_register[rt];
            gpr_destination_address <= rd;
            immediate_value <= 16'b0;
            reg_write <= 1'b1;
        end
        6'b000001: begin // I-type instruction (addi)
            alu_control <= 4'b0010;
            operand_1 <= general_purpose_register[rs];
            operand_2 <= general_purpose_register[rt];
            gpr_destination_address <= rt; // destination should be rt for I-type instructions
            immediate_value <= immediate;
            reg_write <= 1'b1;
        end
        6'b000010: begin // J-type instruction format
            alu_control <= 4'b0000;
            operand_1 <= general_purpose_register[rs];
            operand_2 <= general_purpose_register[rt];
            gpr_destination_address <= rd; // destination is rd for J-type (but may be unused)
            immediate_value <= 16'b0;
            reg_write <= 1'b1;
        end
    endcase
end

endmodule

module tb;
//input parameters

reg clk;
reg[31:0] general_purpose_register;
reg[31:0] instruction;

//output parameters

wire[4:0] operand_1;
wire[4:0] operand_2;
wire[4:0] gpr_destination_address;
wire[3:0] alu_control;
wire reg_write;
wire[15:0] immediate_value;

//load the parameters to the module 
decode uut(.clk(clk),.general_purpose_register(general_purpose_register),.instruction(instruction),.operand_1(operand_1),.operand_2(operand_2),.gpr_destination_address(gpr_destination_address),.reg_write(reg_write),.immediate_value(immediate_value));
always begin 
 #5 clk = ~clk;
end 
initial begin
	//intitialize the signal 
	 clk = 0;
	 general_purpose_register = 32'b0;
	 instruction = 32'b0;
	//hold
	 #10
	//operation
	 general_purpose_register = 32'h12_13;
	 instruction = 32'h342;
         $display("the instruction has be decoded");
	 $finish;
         
end
endmodule
  
