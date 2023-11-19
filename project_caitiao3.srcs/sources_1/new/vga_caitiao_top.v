`timescale 1ns / 1ps


module vga_caitiao_top(
    input clk_100m,
    input rst_n,
    output vga_hs,
    output vga_vs,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b
    );
    wire clk_ref;

    clk_wiz_0 u0
  (
  // Clock out ports  
  .clk_ref(clk_ref),
  // Status and control signals               
  .reset(!rst_n), 
  .locked(),
 // Clock in ports
  .clk_in1(clk_100m)
  );

    wire [11:0] vga_data;
    wire [11:0] x_pos;
    wire [11:0] y_pos;

    vga_caitiao_driver u1
    (
        .clk_65m(clk_ref),
        .rst_n(rst_n),
        .vga_data(vga_data),
        .vga_hs(vga_hs),
        .vga_vs(vga_vs),
        .vga_rgb({vga_r,vga_g,vga_b}),
        .x_pos(x_pos),
        .y_pos(y_pos)
    );

    vga_caitiao_diplay u2
    (
        .clk_65m(clk_ref),
        .rst_n(rst_n),
        .x_pos(x_pos),
        .y_pos(y_pos),
        .vga_data(vga_data)
    );
endmodule
