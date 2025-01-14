module fetch_stage(input wire clk , input wire [15:0] cache_address , output reg [15:0] general_purpose_register , output reg [15:0] data_out);
  always @(posedge clk)begin
	  data_out <= cache_address;
	  general_purpose_register <= data_out;
  end
endmodule

module tb;
   // input 
  reg clk;
  reg [15:0] cache_address;
   //output
  wire [15:0] general_purpose_register;  
  wire [15:0] data_out;
  
  fetch_stage uut(.clk(clk),.cache_address(cache_address),.general_purpose_register(general_purpose_register),.data_out(data_out));

   //clk intitialisation
  always begin
        #5 clk = ~clk; 
  end
  
  initial begin	  
   //initiate the signals 
   clk = 0;
   cache_address = 16'b0;
   

   //hold for a period
   #10
   
   //implement the first operation
   cache_address = 16'h12_12;
   $display("the data fetched and passed for the next state : : %1h",data_out);
   $finish;
  end
endmodule

  
