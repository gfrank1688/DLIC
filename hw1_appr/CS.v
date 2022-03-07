module CS(
  input                                 clk, 
  input                                 reset,
  input                           [7:0] X,
  output                  reg     [9:0] Y
);

reg [3:0] i;
reg [7:0] near;
reg [11:0] avg;
reg [11:0] S;
reg [7:0] temp [0:8]; 
//reg [9:0] temp_Y;
always@(posedge clk or posedge reset)begin
  if(reset)begin
      for(i=0;i<9;i=i+1)
        temp[i] <= 8'd0;  
      S <= 0 ;
  end  
  else begin
    /*
      temp[0] <= temp[1];
      temp[1] <= temp[2];
      temp[2] <= temp[3];
      temp[3] <= temp[4];
      temp[4] <= temp[5];
      temp[5] <= temp[6];
      temp[6] <= temp[7];
      temp[7] <= temp[8];
      temp[8] <= X;
    */
    for(i=0;i<8;i=i+1)begin
      temp[i] <= temp[i+1];
    end
    temp[8] <= X;    
    S <= S - temp[0] + X;
  end
end


always@(*) begin
  near = 8'd0;
  for( i=0; i<9;i=i+1)begin
    avg = (temp[i]<<3) + temp[i];
    if(avg <= S & temp[i] > near)begin
        near = temp[i];
    end
    else
        ;


  end

end

always @(negedge clk or posedge reset) begin
  if(reset)begin
    Y <= 10'd0;
  end
  else
    Y <= ((S+(near<<3)+near)) >> 3;
 end


endmodule
