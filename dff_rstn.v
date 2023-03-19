module tb_d_dff_rstn();

	reg d;
	reg clk = 0;
	reg reset_n;
	wire q;
	wire q_not;
	reg [1:0] delay;
	integer i;
	
	d_ff_sync_rstn DFF0(
		.reset_n(reset_n),
		.clk(clk),
		.d(d),
		.q(q),
		.q_not(q_not)
	);
	
	//generate clock signal
	always begin
		#0.5 clk = ~clk;
	end
	
	//create stimulus
	initial begin
		reset_n = 0; d = 0;
		for(i=0;i<4;i=i+1) begin
			delay = $urandom_range(1,3);
			#(delay) d = ~d; // toggle the FF at random times
		end
		
		reset_n = 1;
		for(i=0;i<4;i=i+1) begin
			delay = #urandom_range(1,3);
			#(delay) d = ~d;
		end
		
		d = 1'b1; // make sure D is set
		
		#(0.2);reset_n = 0; //reset the FF again
	end
	
	initial begin
		#40 $finish;
	end
endmodule

module d_ff_sync_rstn(
	input reset_n,
	input clk,
	input d,
	output reg q,
	output q_not
);

	always@(posedge clk) begin
		if(!reset_n)
			q <= 1'b0;
		else
			q <= d;
	end
	
	assign q_not = ~q;
endmodule