library verilog;
use verilog.vl_types.all;
entity DataPath is
    port(
        clk             : in     vl_logic;
        Databus         : inout  vl_logic_vector(15 downto 0);
        Addressbus      : out    vl_logic_vector(15 downto 0);
        ResetPC         : in     vl_logic;
        PCplusI         : in     vl_logic;
        PCplus1         : in     vl_logic;
        RplusI          : in     vl_logic;
        Rplus0          : in     vl_logic;
        Rs_on_AddressUnitRSide: in     vl_logic;
        Rd_on_AddressUnitRSide: in     vl_logic;
        EnablePC        : in     vl_logic;
        B15to0          : in     vl_logic;
        AandB           : in     vl_logic;
        AorB            : in     vl_logic;
        notB            : in     vl_logic;
        shlB            : in     vl_logic;
        shrB            : in     vl_logic;
        AaddB           : in     vl_logic;
        AsubB           : in     vl_logic;
        AmulB           : in     vl_logic;
        AcmpB           : in     vl_logic;
        RFLwrite        : in     vl_logic;
        RFHwrite        : in     vl_logic;
        WPreset         : in     vl_logic;
        WPadd           : in     vl_logic;
        IRload          : in     vl_logic;
        SRload          : in     vl_logic;
        Address_on_Databus: in     vl_logic;
        ALU_on_Databus  : in     vl_logic;
        IR_on_LOpndBus  : in     vl_logic;
        IR_on_HOpndBus  : in     vl_logic;
        RFright_on_OpndBus: in     vl_logic;
        Cset            : in     vl_logic;
        Creset          : in     vl_logic;
        Zset            : in     vl_logic;
        Zreset          : in     vl_logic;
        Shadow          : in     vl_logic;
        Instruction     : out    vl_logic_vector(15 downto 0);
        Cout            : out    vl_logic;
        Zout            : out    vl_logic
    );
end DataPath;