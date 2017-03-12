module arty_debug (
    input           sys_clk,
    input           sys_rst_n,
    
    input           uart_rxd,
    output          uart_txd,
    
    output [13:0]   ddr3_addr,
    output [2:0]    ddr3_ba,
    output          ddr3_cas_n,
    output [0:0]    ddr3_ck_n,
    output [0:0]    ddr3_ck_p,
    output [0:0]    ddr3_cke,
    output [1:0]    ddr3_dm,
    inout  [15:0]   ddr3_dq,
    inout  [1:0]    ddr3_dqs_n,
    inout  [1:0]    ddr3_dqs_p,
    output [0:0]    ddr3_odt,
    output          ddr3_ras_n,
    output          ddr3_reset_n,
    output          ddr3_we_n,
      
    ulpi_phy_iface.io phy
);

logic       ulpi_clk;
logic       ulpi_rst;

logic       axi_aclk;
logic       axi_aresetn;

logic [31:0]    m_axi_reg_araddr;
logic [2:0]     m_axi_reg_arprot;
logic           m_axi_reg_arready;
logic           m_axi_reg_arvalid;
logic [31:0]    m_axi_reg_awaddr;
logic [2:0]     m_axi_reg_awprot;
logic           m_axi_reg_awready;
logic           m_axi_reg_awvalid;
logic           m_axi_reg_bready;
logic [1:0]     m_axi_reg_bresp;
logic           m_axi_reg_bvalid;
logic [31:0]    m_axi_reg_rdata;
logic           m_axi_reg_rready;
logic [1:0]     m_axi_reg_rresp;
logic           m_axi_reg_rvalid;
logic [31:0]    m_axi_reg_wdata;
logic           m_axi_reg_wready;
logic [3:0]     m_axi_reg_wstrb;
logic           m_axi_reg_wvalid;


logic [1:0]     s_axi_mem_arburst;
logic [3:0]     s_axi_mem_arcache;
logic [3:0]     s_axi_mem_arid;
logic [7:0]     s_axi_mem_arlen;
logic [0:0]     s_axi_mem_arlock;
logic [2:0]     s_axi_mem_arprot;
logic [3:0]     s_axi_mem_arqos;
logic [0:0]     s_axi_mem_arready;
logic [2:0]     s_axi_mem_arsize;
logic [0:0]     s_axi_mem_arvalid;
logic [31:0]    s_axi_mem_awaddr;
logic [1:0]     s_axi_mem_awburst;
logic [3:0]     s_axi_mem_awcache;
logic [3:0]     s_axi_mem_awid;
logic [7:0]     s_axi_mem_awlen;
logic [0:0]     s_axi_mem_awlock;
logic [2:0]     s_axi_mem_awprot;
logic [3:0]     s_axi_mem_awqos;
logic [0:0]     s_axi_mem_awready;
logic [2:0]     s_axi_mem_awsize;
logic [0:0]     s_axi_mem_awvalid;
logic [3:0]     s_axi_mem_bid;
logic [0:0]     s_axi_mem_bready;
logic [1:0]     s_axi_mem_bresp;
logic [0:0]     s_axi_mem_bvalid;
logic [31:0]    s_axi_mem_rdata;
logic [3:0]     s_axi_mem_rid;
logic [0:0]     s_axi_mem_rlast;
logic [0:0]     s_axi_mem_rready;
logic [1:0]     s_axi_mem_rresp;
logic [0:0]     s_axi_mem_rvalid;
logic [31:0]    s_axi_mem_wdata;
logic [0:0]     s_axi_mem_wlast;
logic [0:0]     s_axi_mem_wready;
logic [3:0]     s_axi_mem_wstrb;
logic [0:0]     s_axi_mem_wvalid;

MicroblazeSystem SYSTEM
(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    
    
    .axi_aclk(axi_aclk),
    .axi_aresetn(axi_aresetn),
    
    
    .ddr3_addr(ddr3_addr),
    .ddr3_ba(ddr3_ba),
    .ddr3_cas_n(ddr3_cas_n),
    .ddr3_ck_n(ddr3_ck_n),
    .ddr3_ck_p(ddr3_ck_p),
    .ddr3_cke(ddr3_cke),
    .ddr3_cs_n(ddr3_cs_n),
    .ddr3_dm(ddr3_dm),
    .ddr3_dq(ddr3_dq),
    .ddr3_dqs_n(ddr3_dqs_n),
    .ddr3_dqs_p(ddr3_dqs_p),
    .ddr3_odt(ddr3_odt),
    .ddr3_ras_n(ddr3_ras_n),
    .ddr3_reset_n(ddr3_reset_n),
    .ddr3_we_n(ddr3_we_n),
    
        
    .uart_rxd(uart_rxd),
    .uart_txd(uart_txd),
    
        
    .m_axi_reg_araddr(m_axi_reg_araddr),
    .m_axi_reg_arprot(m_axi_reg_arprot),
    .m_axi_reg_arready(m_axi_reg_arready),
    .m_axi_reg_arvalid(m_axi_reg_arvalid),
    
    .m_axi_reg_awaddr(m_axi_reg_awaddr),
    .m_axi_reg_awprot(m_axi_reg_awprot),
    .m_axi_reg_awready(m_axi_reg_awready),
    .m_axi_reg_awvalid(m_axi_reg_awvalid),
    
    .m_axi_reg_bready(m_axi_reg_bready),
    .m_axi_reg_bresp(m_axi_reg_bresp),
    .m_axi_reg_bvalid(m_axi_reg_bvalid),
    
    .m_axi_reg_rdata(m_axi_reg_rdata),
    .m_axi_reg_rready(m_axi_reg_rready),
    .m_axi_reg_rresp(m_axi_reg_rresp),
    .m_axi_reg_rvalid(m_axi_reg_rvalid),
    
    .m_axi_reg_wdata(m_axi_reg_wdata),
    .m_axi_reg_wready(m_axi_reg_wready),
    .m_axi_reg_wstrb(m_axi_reg_wstrb),
    .m_axi_reg_wvalid(m_axi_reg_wvalid),
    
    
    .s_axi_mem_araddr(s_axi_mem_araddr),
    .s_axi_mem_arburst(s_axi_mem_arburst),
    .s_axi_mem_arcache(s_axi_mem_arcache),
    .s_axi_mem_arid(s_axi_mem_arid),
    .s_axi_mem_arlen(s_axi_mem_arlen),
    .s_axi_mem_arlock(s_axi_mem_arlock),
    .s_axi_mem_arprot(s_axi_mem_arprot),
    .s_axi_mem_arqos(s_axi_mem_arqos),
    .s_axi_mem_arready(s_axi_mem_arready),
    .s_axi_mem_arsize(s_axi_mem_arsize),
    .s_axi_mem_arvalid(s_axi_mem_arvalid),
    
    .s_axi_mem_awaddr(s_axi_mem_awaddr),
    .s_axi_mem_awburst(s_axi_mem_awburst),
    .s_axi_mem_awcache(s_axi_mem_awcache),
    .s_axi_mem_awid(s_axi_mem_awid),
    .s_axi_mem_awlen(s_axi_mem_awlen),
    .s_axi_mem_awlock(s_axi_mem_awlock),
    .s_axi_mem_awprot(s_axi_mem_awprot),
    .s_axi_mem_awqos(s_axi_mem_awqos),
    .s_axi_mem_awready(s_axi_mem_awready),
    .s_axi_mem_awsize(s_axi_mem_awsize),
    .s_axi_mem_awvalid(s_axi_mem_awvalid),
    
    .s_axi_mem_bid(s_axi_mem_bid),
    .s_axi_mem_bready(s_axi_mem_bready),
    .s_axi_mem_bresp(s_axi_mem_bresp),
    .s_axi_mem_bvalid(s_axi_mem_bvalid),
    
    .s_axi_mem_rdata(s_axi_mem_rdata),
    .s_axi_mem_rid(s_axi_mem_rid),
    .s_axi_mem_rlast(s_axi_mem_rlast),
    .s_axi_mem_rready(s_axi_mem_rready),
    .s_axi_mem_rresp(s_axi_mem_rresp),
    .s_axi_mem_rvalid(s_axi_mem_rvalid),
    
    .s_axi_mem_wdata(s_axi_mem_wdata),
    .s_axi_mem_wlast(s_axi_mem_wlast),
    .s_axi_mem_wready(s_axi_mem_wready),
    .s_axi_mem_wstrb(s_axi_mem_wstrb),
    .s_axi_mem_wvalid(s_axi_mem_wvalid)
);

/*assign m_axi_reg_arvalid = 1'b0;
assign m_axi_reg_awvalid = 1'b0;
assign m_axi_reg_bready = 1'b0;
assign m_axi_reg_rready = 1'b0;
assign m_axi_reg_wvalid = 1'b0;*/

axi_lite_iface ulpi_csr();
usb_state_iface usb_state();

ulpi_controller ULPI_CTL (
    .ulpi_phy(phy),
    
    .ulpi_clk(ulpi_clk),
    .ulpi_rst(ulpi_rst),
    
    .ulpi_csr(ulpi_csr),
    .usb_state(usb_state)
);

assign ulpi_rst = 1'b0;

endmodule