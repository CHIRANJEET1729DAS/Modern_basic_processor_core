module control_unit(input wire clk, input wire [31:0] instruction,output reg [3:0] ALU_control,output reg [3:0] FPU_control);

wire [5:0] opcode = instruction[31:26];
wire [4:0] fmt  = instruction[25:21];
wire [5:0] funct = instruction[5:0];

always @(opcode or fmt or funct) begin
   case (opcode)
	   6'b000001 : begin
		   case (fmt)
			   5'b00001 : begin
				   case (funct)
					   6'b000001 : begin //addition
						   ALU_control = 4'b0001;
					   end
					   6'b000010 : begin //substraction
					           ALU_control = 4'b0010;
					   end
					   6'b000011 : begin //and
					           ALU_control = 4'b0011;
					   end
      					   6'b000100 : begin //left shift  
					           ALU_control = 4'b0100;
				           end
					   6'b000101 : begin //right shift
					           ALU_control = 4'b0101;
					   end
					   6'b000110 : begin //or  
					           ALU_control = 4'b0110;
					   end
					   6'b000111 : begin //lessthan comparision
					           ALU_control = 4'b0111;
				           end
					   6'b001000 : begin //morethan comaparision
					           ALU_control = 4'b1000;
				           end
					   6'b001001 : begin
						   ALU_control = 4'b1001;
					   end
					   default : ALU_control = 4'b000;
		                    endcase
			    end
			    5'b00010 :  begin
				    case (funct) 
                                           6'b000001 :  begin //addition
					           FPU_control = 4'b0001;
				           end
					   6'b000010 : begin // substraction
					           FPU_control = 4'b0010;
					   end
					   6'b000011 : begin //and
						   FPU_control = 4'b0011;
					   end
					   6'b000100 : begin //left shift
						   FPU_control = 4'b0100;
					   end
					   6'b000101 : begin //right shift
						   FPU_control = 4'b0101;
				           end
					   6'b000111 : begin //and
						   FPU_control = 4'b0110;
					   end
					   6'b001000 : begin //or
						   FPU_control = 4'b0111;
					   end
					   6'b001001 : begin //multiplication
						   FPU_control = 4'b1000;
					   end
					   6'b001010 : begin //less than comparision
						   FPU_control = 4'b1001;
					   end
					   6'b001011 : begin //greater than comparision
						   FPU_control = 4'b1010;
					   end
					   6'b001100 : begin // equality comparision
						   FPU_control = 4'b1011;
				           end
					   6'b001101 : begin // absoltute 
					 	   FPU_control = 4'b1100;
					   end
					   6'b001110 : begin // division
						   FPU_control = 4'b1101;
					   end
				           6'b001111 : begin // square root 
						   FPU_control = 4'b1110;
					   end
					   6'b010000 : begin // float to int 
						   FPU_control = 4'b1111;
					   end
					   default : FPU_control = 4'b000;
				   endcase
			    end
	           endcase
	   end
           6'b000010 : begin // I type addi 
		   ALU_control = 4'b0001;
		   FPU_control = 4'b0010;
	   end
	   6'b000011 : begin // J type jump
		   ALU_control = 4'b0010;
		   FPU_control = 4'b0011;
           end
   endcase
 end
 endmodule

	   
		 








					   
					           

