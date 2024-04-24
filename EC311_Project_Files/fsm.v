`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 05:13:19 PM
// Design Name: 
// Module Name: fsm
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


module fsm(
        input clock,
        input [11:0] twelve_bit_number,
        output [6:0] cathode,
        output reg [7:0] anode
    );
    
    reg [3:0] four_bit_number;
    // instantiate decoder that decodes the four bit number into the cathode
    decoder D(.number(four_bit_number), .cathode(cathode));
    reg [1:0] state; // stores state of FSM
    
    initial begin
		state = 0;
		anode = 8'b11111111; // All displays off initially
	end
    
    always @(posedge clock)
	begin
	   case(state)
	       0: begin
	           anode = 8'b11111110; //units
	           four_bit_number = twelve_bit_number[3:0]; 
	           state = 1; end //take last 4 bits of the full 16 bit number
	       
            1: begin
	           anode = 8'b11111101;
	           four_bit_number = twelve_bit_number[7:4];
	           state = 2; end
	          
            2: begin
	           anode = 8'b01111111; // Activate 4th display (4th LST of anode set to 0)
	           four_bit_number = twelve_bit_number[11:8]; // 4 most significant boits
	           state = 0; end
	           
               default: begin
	           state = 0; end 
	        endcase
	    // if state is unknown, reset               
	    // increment state
		// set anode (which display do you want to set?)
		//   hint: if state == 0, then set only the LSB of anode to zero,
		//         if state == 1, then set only the second to LSB to zero.
		// set the four bit number to be the approprate slice of the 16-bit number
	end
endmodule

