`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 04:51:41 PM
// Design Name: 
// Module Name: clock_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Clock_divider(
    input in_clk,      // 100 MHz clock
    output reg out_clk); // 1 Hz clock);
	
	reg [32:0] count;
	parameter BIG_NUM = 100000; 
	//100,000 for 1KHz output clock frequence
	// for 1Hz clock: 50,000,000: The number of cycles in 1/s seconds is 100,000,000*(0.5)
    
    //initialize the register to 0 before all
	initial begin
		count = 0;
		out_clk = 0;
	end
	
	always @(negedge in_clk)
	begin
		// increment count by one (use blocking assignment)
		count = count + 1;
		
		// if count equals to some big number (that you need to calculate),
		//     (Think: how many input clock cycles do you need to see 
		//     for it to be half a second)
		if (count == BIG_NUM) begin
		//     then flip the output clock,   (use non-blocking assignment)
		//     and reset count to zero.      (use non-blocking assignment)
		  out_clk <= ~out_clk;
		  count <= 0;
		end
	end
endmodule
