module PWM (sw0,sw1,sw2,sw3,clk,out);

input[3:0] sw0,sw1,sw2,sw3;
input clk;
output reg out;
reg[1:0] a; //вспомогательный счётчик для модуляции каждого импульса в always-блоке 
wire clk25MHz;
integer c;
integer sw0_sum, sw1_sum, sw2_sum, sw3_sum;

PLLPWM pllpwm1
(
.inclk0(clk),
.c0(clk25MHz)
); 

initial begin
sw0_sum = sw0[0] + sw0[1] + sw0[2] + sw0[3];
sw1_sum = sw1[0] + sw1[1] + sw1[2] + sw1[3];
sw2_sum = sw2[0] + sw2[1] + sw2[2] + sw2[3]; 
sw3_sum = sw3[0] + sw3[1] + sw3[2] + sw3[3];
c=0;
end

always@( posedge clk25MHz)
begin

//1ый импульс
if (a==2'b00)
begin
	if(c<sw0_sum)
		out <=1'b1;
	else 
		out <=1'b0;
	c<=c+1;
	if (c==3) 
	begin
		a<=2'b01;
		c<=0;
	end
	sw0_sum <= sw0[0] + sw0[1] + sw0[2] + sw0[3];
end

//2ой импульс
if (a==2'b01)
begin
	if(c<sw1_sum)
		out <=1'b1;
	else 
		out <=1'b0;
	c<=c+1;
	if (c==3) 
	begin
		a<=2'b10;
		c<=0;
	end
	sw1_sum <= sw1[0] + sw1[1] + sw1[2] + sw1[3];
end

//3ий импульс
if (a==2'b10)
begin
	if(c<sw2_sum)
		out <=1'b1;
	else 
		out <=1'b0;
	c<=c+1;
	if (c==3) 
	begin
		a<=2'b11;
		c<=0;
	end
	sw2_sum <= sw2[0] + sw2[1] + sw2[2] + sw2[3]; 
end

//4ый импульс
if (a==2'b11)
begin
	if(c<sw3_sum) 
		out <=1'b1;
	else 
		out <=1'b0;
	c<=c+1;
		if (c==3) 
	begin
		a<=2'b00;
		c<=0;
	end
	sw3_sum <= sw3[0] + sw3[1] + sw3[2] + sw3[3];
end


end

endmodule






