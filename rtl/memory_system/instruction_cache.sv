module instruction_cache(input wire clk,input wire reset,input wire[1023:0] instruction_cache,input wire[31:0] instruction,output wire index_for_quick_access);
 
reg hit ;
integer index_for_cache = 0;

always @(posedge clk or posedge reset)begin
	if (reset)begin
		hit <= 0;
		index_for_cache <= 0;
        end
	else begin
		for (index = 0; index<32;index=index+1)begin
				if (instruction_cache[index*32+:32] == instruction)begin
				 hit <= 1'b0;
				 index_for_quick_access <= index*32;
			        end
			 
			if (~hit)begin
				instruction_cache[index_for_cache*32+:32] = instruction;
				index_for_quick_access <= index+32;
				index_for_cache = index_for_cache + 1;
			end
		end 
        end
end
endmodule


                                

