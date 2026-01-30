module fifo(
input clk,rst,wr_enb,rd_enb,
input [7:0] data_in,
output reg [7:0] data_out,
output full,empty

    );
    
    reg [2:0] write_ptr,rd_ptr;// for representing our 8 locations we need 3 bit ptr
    reg [7:0] mem [0:7]; // 8 bit 8 reg memories
     
     
    always@(posedge clk or posedge rst)
    begin
    
    if (rst)
    begin
      write_ptr <= 3'b000;
      rd_ptr    <= 3'b000;
      data_out  <= 8'b00000000;
    end
    
    else begin 
    if(wr_enb && !full)
    begin
    mem[write_ptr] <= data_in;
    write_ptr <= write_ptr + 1'b1;
    end
    
    
    if(rd_enb && !empty) // empty == 1 means all blocks are empty then what should we read!!!
    begin
    data_out <= mem[rd_ptr];
    rd_ptr <= rd_ptr + 1'b1;
    end
    
    end
    
    end
    
     assign empty = (write_ptr == rd_ptr);
    
    assign full = ((write_ptr + 1'b1) == rd_ptr) ? 1'b1 : 1'b0;

    
