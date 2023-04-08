`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/24 15:23:55
// Design Name: 
// Module Name: BRAM
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


module BRAM(
input clk,               //时钟
input rst                //复位信号，低电平有效
    );    
	
reg[8:0]     w_addr;      //RAM PORT A 写地址
reg[15:0]    w_data;     //RAM PORT  A 写数据
reg          wea;        //RAM PORT  A 写使能，高电平有效
reg          enb;        //RAM PORT  B 读使能，高电平有效
reg[8:0]     r_addr;     //RAM PORT  B 读地址
wire[15:0]   r_data;    //RAM PORT   B 读数据


//产生RAM PORTA 写使能信号
always@(posedge clk or negedge rst) begin
      if(!rst)
	     wea <= 1'b0;
	  else begin
	      if(&w_addr)                       //w_addr的bit位全为1，共写入512个数据，写入完成
	         wea <= 1'b0;
		  else 
		     wea <= 1'b1;                  //RAM 写使能
	  end 
end 

//产生RAM PORTB 读使能信号
always@(posedge clk or negedge rst) begin
      if(!rst)
	     enb <= 1'b0;
	  else begin
	      if(&r_addr)                       //r_addr的bit位全为1，共读出512个数据，读出完成
	         enb <= 1'b0;
		  else 
		     enb <= 1'b1;                  //RAM 读使能
	  end 
end 

//产生RAM PORTA写入的地址及数据
always@(posedge clk or negedge rst) begin
      if(!rst) begin
	      w_addr <= 9'd0;
		  w_data <= 16'd1;
	  end
      else begin
	      if(wea) begin                    //ram写使能有效 
		      if(&w_addr) begin           //w_addr的bit位全为1，共写入512个数据，写入完成 
			      w_addr <= w_addr;      //写入完成时将地址和数据的值保持，本测试中只写一次RAM
				  w_data <= w_data;
			  end 
			  else begin
			      w_addr <= w_addr + 1'b1;
				  w_data <= w_data + 1'b1;
			  end
		  end 
	  end 
end 

//产生RAM PORTB 读地址
always@(posedge clk or negedge rst) begin
      if(!rst) begin
	      r_addr <= 9'd0;
	  end
      else begin
	      if(enb) begin                    //ram读使能有效 
		      if(&r_addr) begin           //r_addr的bit位全为1，共读出512个数据，读出完成 
			      r_addr <= r_addr;      //读出完成时将地址的值保持
			  end 
			  else begin
			      r_addr <= r_addr + 1'b1;
			  end
		  end 
	  end 
end 
////////////////////////////////////////////////
//实例化RAM 
iCache iCache_inst ( 
  .clka      (clk          ),            // input clka 
  .wea       (wea          ),            // input [0 : 0] wea 
  .addra     (w_addr       ),            // input [8 : 0] addra 
  .dina      (w_data       ),            // input [15 : 0] dina 
   .clkb     (clk          ),            // input clkb 
   .enb      (enb)          ,
   .addrb    (r_addr       ),            // input [8 : 0] addrb 
   .doutb    (r_data       )             // output [15 : 0] doutb 
  ); 
  
dCache dCache_inst ( 
  .clka      (clk          ),            // input clka 
  .wea       (wea          ),            // input [0 : 0] wea 
  .addra     (w_addr       ),            // input [8 : 0] addra 
  .dina      (w_data       ),            // input [15 : 0] dina 
   .clkb     (clk          ),            // input clkb 
   .enb      (enb)          ,
   .addrb    (r_addr       ),            // input [8 : 0] addrb 
   .doutb    (r_data       )             // output [15 : 0] doutb 
  ); 

endmodule
