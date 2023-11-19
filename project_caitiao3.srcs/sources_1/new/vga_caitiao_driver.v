`timescale 1ns / 1ps
`include "vga_para.v"

module vga_caitiao_driver(
    input clk_65m,
    input rst_n,
    input [11:0] vga_data,
    output vga_hs,
    output vga_vs,
    output [11:0] vga_rgb,
    output [11:0]x_pos,
    output [11:0]y_pos
    );

    //行扫描计数
reg [11:0] hcnt; 
always @ (posedge clk_65m or negedge rst_n)
begin
	if (!rst_n)
		hcnt <= 12'd0;
	else
		begin
        if(hcnt < `H_TOTAL - 1'b1)		//line over			
            hcnt <= hcnt + 1'b1;
        else
            hcnt <= 12'd0;
		end
end 
assign	vga_hs = (hcnt <= `H_SYNC - 1'b1) ? 1'b0 : 1'b1;

//------------------------------------------
//列扫描计数
reg [11:0] vcnt;
always@(posedge clk_65m or negedge rst_n)
begin
	if (!rst_n)
		vcnt <= 12'b0;
	else if(hcnt == `H_TOTAL - 1'b1)		//line over
		begin
		if(vcnt < `V_TOTAL - 1'b1)		//frame over
			vcnt <= vcnt + 1'b1;
		else
			vcnt <= 12'd0;
		end
end
assign	vga_vs = (vcnt <= `V_SYNC - 1'b1) ? 1'b0 : 1'b1;


wire vga_en;
wire vga_request;

assign	vga_en		=	(hcnt >= `H_SYNC + `H_BACK  && hcnt < `H_SYNC + `H_BACK + `H_DISP) && (vcnt >= `V_SYNC + `V_BACK  && vcnt < `V_SYNC + `V_BACK + `V_DISP) ? 1'b1 : 1'b0;
assign	vga_rgb 	= 	vga_en ? vga_data : 12'h000000;	

//------------------------------------------
//
localparam	H_AHEAD = 	12'd1;
assign	vga_request	=	(hcnt >= `H_SYNC + `H_BACK - H_AHEAD && hcnt < `H_SYNC + `H_BACK + `H_DISP - H_AHEAD) && (vcnt >= `V_SYNC + `V_BACK && vcnt < `V_SYNC + `V_BACK + `V_DISP)  ? 1'b1 : 1'b0;
//vga xpos & ypos
assign	x_pos	= 	vga_request ? (hcnt - (`H_SYNC + `H_BACK - H_AHEAD)) : 12'd0;
assign	y_pos	= 	vga_request ? (vcnt - (`V_SYNC + `V_BACK)) : 12'd0;
endmodule
