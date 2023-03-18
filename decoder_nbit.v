module decoder_nbit #(parameter N = 3)(
	input [N-1:0] a,
	input enable,
	output reg [2**n-1:0] y
);

	always@(*) begin
		if(enable == 0)
			y = 0;
		else
			y = (1 << a);
	end
	
endmodule

// testbench
module tb_decoder_nbit();

	parameter DEC_WIDTH = 3;
	reg [DEC_WIDTH-1:0] a;
	reg enable;
	wire [2**DEC_WIDTH-1:0] y;
	
	integer i; //used in the for loop
	
	//instantiate the DUT
	decoder_nbit #(.N(DEC_WIDTH)) DEC1(
		.a(a),
		.enable(enable),
		.y(y)
	);
	
	initial begin
		$monitor($time,"a = %d enable = %b y = %b",a,enable,y);
		#1; a = 0; enable = 0;
		for (i = 0; i<2**DEC_WIDTH; i=i+1) begin
			#1; a = i; enable = 1;
		end
	end
endmodule