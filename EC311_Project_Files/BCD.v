`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 11:26:12 AM
// Design Name: 
// Module Name: BCD
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


module BCD(input [3:0] binary,
           output reg [3:0]tens,         // tens place (0 or 1)
           output reg [3:0] units); 
           
           initial begin tens = 0;     
           units = 0; end// units place (0 to 9)

    always @(*) begin
        if (binary >= 4'b1010) begin     //binary >= 10
            tens <= 4'b0001;             // binary numbers 10-15 --> tens digit is 1
            units <= binary - 4'b1010;   // Units digit --> subtract 10
        end else begin                   // if binary < 10
            tens = 4'b0000;              // binary numbers 0-9 --> tens digit is 0
            units <= binary;             // Units digit is the same as the binary input
        end
    end

endmodule

