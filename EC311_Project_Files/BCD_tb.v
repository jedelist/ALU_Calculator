`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 11:53:05 AM
// Design Name: 
// Module Name: BCD_tb
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


module BCD_tb();
    wire [3:0] units, tens;
    reg [3:0]inp;
    
    BCD C1(.binary(inp), .tens(tens), .units(units));
    
    initial begin
        for (inp=0; inp<16; inp=inp+1)
        begin
            
            #10;
        end
        #10
        $finish;
    end
    
endmodule