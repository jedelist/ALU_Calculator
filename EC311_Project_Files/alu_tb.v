`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 12:48:34 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
    reg [3:0] A, B, Opcode; 
    reg reset, clk;
    wire [6:0]cathode;
    wire [7:0] anode;
    wire overflow;
    wire [7:0]result;
    
    
    ALUCalculator ALU(.A(A), .B(B), .Opcode(Opcode),.clk(clk), .reset(reset), .overflow(overflow), .anode(anode), .cathode(cathode));
    
    initial begin
        reset = 0;
        clk = 0;
        Opcode <= 4'b0000;
        A <= 4'b0000;
        B <= 4'b0000;
/*        
        #20
        
        Opcode = 4'b0001;
        B = 4'b0001;
        #20
        Opcode = 4'b0000;
        A = 4'b0001;*/
        
        #20
        
        A <= 4'b1010;
        B <= 4'b1010;
        Opcode <= 4'b0011;
        #20
        
        A <= 4'b0011;
        B <= 4'b1000;
        Opcode <= 4'b0010;
        
        #20
        $finish;
    end
    always #2 clk = ~clk;
endmodule
