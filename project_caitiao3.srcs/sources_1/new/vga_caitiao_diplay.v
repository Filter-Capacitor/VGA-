`timescale 1ns / 1ps
`include "vga_para.v"
module vga_caitiao_diplay(
    input clk_65m,
    input rst_n,
    input [11:0]x_pos,
    input [11:0]y_pos,
    output reg [11:0] vga_data
    );

`define RED      12'b1111_0000_0000
`define GREEN    12'b0000_1111_0000
`define BLUE     12'b0000_0000_1111
`define WHITE    12'b1111_1111_1111
`define BLACK    12'b0000_0000_0000
`define YELLOW   12'b1111_1111_0000
`define CYAN     12'b1111_0000_1111
`define ROYAL    12'b0000_1111_1111

always@(posedge clk_65m or negedge rst_n)
begin
	if(!rst_n)
		vga_data <= 12'h0;
	else
		begin
		if	(y_pos >= 0 && y_pos < (`V_DISP/8)*1)
			vga_data <= `RED;
		else if(y_pos >= (`V_DISP/8)*1 && y_pos < (`V_DISP/8)*2)
			vga_data <= `GREEN;
		else if(y_pos >= (`V_DISP/8)*2 && y_pos < (`V_DISP/8)*3)
			vga_data <= `BLUE;
		else if(y_pos >= (`V_DISP/8)*3 && y_pos < (`V_DISP/8)*4)
			vga_data <= `WHITE;
		else if(y_pos >= (`V_DISP/8)*4 && y_pos < (`V_DISP/8)*5)
			vga_data <= `BLACK;
		else if(y_pos >= (`V_DISP/8)*5 && y_pos < (`V_DISP/8)*6)
			vga_data <= `YELLOW;
		else if(y_pos >= (`V_DISP/8)*6 && y_pos < (`V_DISP/8)*7)
			vga_data <= `CYAN;
		else if(y_pos >= (`V_DISP/8)*7 && y_pos < (`V_DISP/8)*8)
			vga_data <= `ROYAL;
		end
end
endmodule
