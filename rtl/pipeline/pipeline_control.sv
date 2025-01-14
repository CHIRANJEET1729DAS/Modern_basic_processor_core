module pipeline(input wire clk,input wire reset);

wire reg_write;
wire[3:0] alu_control;
wire[4:0] operand_1,operand_2,gpr_destination_addres;
wire[15:0] immediate_value,cache_address,general_purpose_register,data_out;
wire[31:0] gpr_destination_address,PC,result,destination_address_on_ram,address_on_gpr,instruction,general_purpose_register_1;

fetch_state if_stage_inst(.clk(clk),.cache_address(cache_address),.general_purpose_register(general_purpose_register),.data_out(data_out));

decode_stage id_stage_inst(.clk(clk),.instruction(instruction),.general_purpose_register(general_purpose_register),.operand_1(operand_1),.operand_2(operand_2),.gpr_destination_address(gpr_destination_address),.alu_control(alu_control),.reg_write(reg_write),.immediate_value(immediate_value));

execute ex_stage_inst(.clk(clk),.operand_1(operand_1),.operand_2(operand_2),.gpr_destination_address(gpr_destination_address),.alu_control(alu_control),.reg_write(reg_write),.immediate_value(immediate_value),.PC(PC),.result(result));

memstate mem_state_inst(.clk(clk),.general_purpose_register(general_purpose_register_1),.address_on_gpr(address_on_gpr),.destination_address_on_ram(destination_address_on_ram));

always @(posedge clk or posedge reset)begin
	if(reset)begin
		PC <= 32'b0;
	end
	else begin
		PC <= PC+4;
        end
end;
endmodule


