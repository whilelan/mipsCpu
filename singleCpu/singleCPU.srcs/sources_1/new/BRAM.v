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
input clk,               //ʱ��
input rst                //��λ�źţ��͵�ƽ��Ч
    );    
	
reg[8:0]     w_addr;      //RAM PORT A д��ַ
reg[15:0]    w_data;     //RAM PORT  A д����
reg          wea;        //RAM PORT  A дʹ�ܣ��ߵ�ƽ��Ч
reg          enb;        //RAM PORT  B ��ʹ�ܣ��ߵ�ƽ��Ч
reg[8:0]     r_addr;     //RAM PORT  B ����ַ
wire[15:0]   r_data;    //RAM PORT   B ������


//����RAM PORTA дʹ���ź�
always@(posedge clk or negedge rst) begin
      if(!rst)
	     wea <= 1'b0;
	  else begin
	      if(&w_addr)                       //w_addr��bitλȫΪ1����д��512�����ݣ�д�����
	         wea <= 1'b0;
		  else 
		     wea <= 1'b1;                  //RAM дʹ��
	  end 
end 

//����RAM PORTB ��ʹ���ź�
always@(posedge clk or negedge rst) begin
      if(!rst)
	     enb <= 1'b0;
	  else begin
	      if(&r_addr)                       //r_addr��bitλȫΪ1��������512�����ݣ��������
	         enb <= 1'b0;
		  else 
		     enb <= 1'b1;                  //RAM ��ʹ��
	  end 
end 

//����RAM PORTAд��ĵ�ַ������
always@(posedge clk or negedge rst) begin
      if(!rst) begin
	      w_addr <= 9'd0;
		  w_data <= 16'd1;
	  end
      else begin
	      if(wea) begin                    //ramдʹ����Ч 
		      if(&w_addr) begin           //w_addr��bitλȫΪ1����д��512�����ݣ�д����� 
			      w_addr <= w_addr;      //д�����ʱ����ַ�����ݵ�ֵ���֣���������ֻдһ��RAM
				  w_data <= w_data;
			  end 
			  else begin
			      w_addr <= w_addr + 1'b1;
				  w_data <= w_data + 1'b1;
			  end
		  end 
	  end 
end 

//����RAM PORTB ����ַ
always@(posedge clk or negedge rst) begin
      if(!rst) begin
	      r_addr <= 9'd0;
	  end
      else begin
	      if(enb) begin                    //ram��ʹ����Ч 
		      if(&r_addr) begin           //r_addr��bitλȫΪ1��������512�����ݣ�������� 
			      r_addr <= r_addr;      //�������ʱ����ַ��ֵ����
			  end 
			  else begin
			      r_addr <= r_addr + 1'b1;
			  end
		  end 
	  end 
end 
////////////////////////////////////////////////
//ʵ����RAM 
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
