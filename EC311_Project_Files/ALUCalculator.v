`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 11:21:30 AM
// Design Name: 
// Module Name: ALUCalculator
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


module ALUCalculator(A, B,Opcode,clk, reset, overflow,anode,cathode);
    input [3:0] A;
    input [3:0] B;
    input [3:0] Opcode;
    input reset;
    input clk;
    
    output [6:0] cathode;
    output [7:0] anode;
    reg [7:0] result;
    output reg overflow;
    wire [11:0]twelve_bit_number;
    wire [3:0]tens;       
    wire [3:0]units;
    wire fsmClk;
    reg reset_state; //make reset state
    
    initial overflow = 0;
    initial result = 0;

    always @(posedge fsmClk) begin
        if (reset) begin
            result <= 4'b0000;
            overflow <= 0; end
        else begin   
            case (Opcode)
                4'b0000: result = A + 4'b0001;
                4'b0001: result = B + 4'b0001;
                4'b0010: result = A - B;
                4'b0011: result = A + B;
                4'b0100: result = A * B;
                4'b0101: result = A >> 1;
                4'b0110: result = A << 1;
                4'b0111: result = B >> 1;
                4'b1000: result = B << 1;
                4'b1001: result = A % B;
                4'b1010: result = A & B; // Bitwise AND
                4'b1011: result = A | B; // Bitwise OR
                4'b1100: result = A ^ B; // Bitwise XOR
                default: result = 4'b0000; //Handles underfined behavior
            endcase
            
            // Check for overflow based on operation
/*            if (((Opcode == 4'b0011) && (result < A || result < B)) || // Addition overflow check
                ((Opcode == 4'b0100) && (result < A && B != 0)) || // Multiplication overflow check
                ((Opcode == 4'b0010) && ((A < B && result[3] == 0))) // Subtraction overflow when result should be negative
               ) overflow <= 1;*/
               
               if (result > 16 || (Opcode == 4'b0010) && ((A < B && result[8] == 1))) overflow <= 1; else overflow <= 0;
        end
    end
    
    //Register as one to the PGA
    Clock_divider clkdivider(.in_clk(clk),.out_clk(fsmClk));
    BCD bcd(.binary(result),.tens(tens),.units(units));
    assign twelve_bit_number = {Opcode, tens, units};
    fsm FSM(.clock(fsmClk),.twelve_bit_number(twelve_bit_number),.cathode(cathode),.anode(anode));
endmodule

