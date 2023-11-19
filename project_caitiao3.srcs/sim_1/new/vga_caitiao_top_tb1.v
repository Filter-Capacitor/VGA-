`timescale 1ns / 1ps

module vga_caitiao_top_tb1();
    reg clk_100m;
    reg rst_n;
    wire vga_hs;
    wire vga_vs;
    wire [3:0]vga_r;
    wire [3:0]vga_g;
    wire [3:0]vga_b;
    vga_caitiao_top inst1(clk_100m,rst_n,vga_hs,vga_vs,vga_r,vga_g,vga_b);

    always #5 clk_100m = ~clk_100m;
    initial begin
        clk_100m = 0; rst_n = 1;
        #10 rst_n = 0;
        #5 rst_n =1;
    end
endmodule
