module img_proc(	oRed,
				oGreen,
				oBlue,
				oDVAL,
				iX_Cont,
				iY_Cont,
				iDATA,
				iDVAL,
				iCLK,
				iRST
				);

input	[10:0]	iX_Cont;
input	[10:0]	iY_Cont;
input	[11:0]	iDATA;
input			iDVAL;
input			iCLK;
input			iRST;
output	[11:0]	oRed;
output	[11:0]	oGreen;
output	[11:0]	oBlue;
output			oDVAL;
reg				mDVAL;
reg [11:0] pixel_out;

reg [11:0] shift_reg [10:0];

wire	[11:0]	mDATA_0;
wire	[11:0]	mDATA_1;
reg		[11:0]	mDATAd_0;
reg		[11:0]	mDATAd_1;

assign oRed = pixel_out;
assign oGreen = pixel_out;
assign oBlue = pixel_out;
assign	oDVAL	=	mDVAL;

Line_Buffer1 u0(.clken(iDVAL),
						.clock(iCLK),
						.shiftin(iDATA),
						.taps0x(mDATA_1),
						.taps1x(mDATA_0));

always @(posedge iCLK or negedge iRST) begin
    if (!iRST) begin
        mDVAL <= 0;
    end
    else begin
        mDATAd_0 <= mDATA_0;
        mDATAd_1 <= mDATA_1;

        pixel_out <= ((mDATA_0 + mDATAd_0 + mDATA_1 + mDATAd_1) >> 2);
        mDVAL	  <= {iY_Cont[0]|iX_Cont[0]}	?	1'b0	:	iDVAL;
    end

end

endmodule

