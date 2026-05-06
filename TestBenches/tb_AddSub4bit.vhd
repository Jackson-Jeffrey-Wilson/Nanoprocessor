-- ============================================================
-- Testbench: AddSub4bit
-- Tests: addition, subtraction, overflow, zero flag,
--        NEG via (0 - R) pattern used by Instruction Decoder
-- ============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity tb_AddSub4bit is
end tb_AddSub4bit;

architecture Behavioral of tb_AddSub4bit is

    component AddSub4bit
        Port (
            A       : in  STD_LOGIC_VECTOR(3 downto 0);
            B       : in  STD_LOGIC_VECTOR(3 downto 0);
            AddSub  : in  STD_LOGIC;
            Result  : out STD_LOGIC_VECTOR(3 downto 0);
            Overflow: out STD_LOGIC;
            Zero    : out STD_LOGIC
        );
    end component;

    signal A, B    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal AddSub  : STD_LOGIC := '0';
    signal Result  : STD_LOGIC_VECTOR(3 downto 0);
    signal Overflow: STD_LOGIC;
    signal Zero    : STD_LOGIC;

    -- Helper procedure to print test results
    procedure check(
        test_name : string;
        A_val, B_val : STD_LOGIC_VECTOR(3 downto 0);
        op        : STD_LOGIC;
        exp_result: STD_LOGIC_VECTOR(3 downto 0);
        exp_ovf   : STD_LOGIC;
        exp_zero  : STD_LOGIC;
        actual_res: STD_LOGIC_VECTOR(3 downto 0);
        actual_ovf: STD_LOGIC;
        actual_zero:STD_LOGIC
    ) is
        variable l : line;
    begin
        write(l, string'("TEST: ") & test_name);
        writeline(output, l);
        if actual_res = exp_result and actual_ovf = exp_ovf and actual_zero = exp_zero then
            write(l, string'("  PASS"));
        else
            write(l, string'("  FAIL"));
            write(l, string'("  Expected Result="));
            write(l, exp_result);
            write(l, string'(" OVF="));
            write(l, exp_ovf);
            write(l, string'(" ZERO="));
            write(l, exp_zero);
            write(l, string'("  Got Result="));
            write(l, actual_res);
            write(l, string'(" OVF="));
            write(l, actual_ovf);
            write(l, string'(" ZERO="));
            write(l, actual_zero);
        end if;
        writeline(output, l);
    end procedure;

begin

    UUT: AddSub4bit
        port map (A => A, B => B, AddSub => AddSub,
                  Result => Result, Overflow => Overflow, Zero => Zero);

    stim: process
    begin
        -- --------------------------------------------------------
        -- ADDITION TESTS (AddSub = '0')
        -- --------------------------------------------------------

        -- Test 1: 3 + 4 = 7  (0011 + 0100 = 0111), No overflow, Not zero
        A <= "0011"; B <= "0100"; AddSub <= '0'; wait for 20 ns;
        check("ADD 3+4=7", A, B, AddSub, "0111", '0', '0', Result, Overflow, Zero);

        -- Test 2: 0 + 0 = 0  → Zero flag set
        A <= "0000"; B <= "0000"; AddSub <= '0'; wait for 20 ns;
        check("ADD 0+0=0 ZERO", A, B, AddSub, "0000", '0', '1', Result, Overflow, Zero);

        -- Test 3: 5 + 5 = 10 → 1010 in binary, signed = -6, OVERFLOW
        --   Both operands positive (+5), result negative → overflow
        A <= "0101"; B <= "0101"; AddSub <= '0'; wait for 20 ns;
        check("ADD 5+5 OVERFLOW", A, B, AddSub, "1010", '1', '0', Result, Overflow, Zero);

        -- Test 4: -1 + -1 = -2  (1111 + 1111 = 1110), No overflow (both neg, result neg)
        A <= "1111"; B <= "1111"; AddSub <= '0'; wait for 20 ns;
        check("ADD -1+-1=-2", A, B, AddSub, "1110", '0', '0', Result, Overflow, Zero);

        -- Test 5: -8 + -1 = -9 → wraps to 0111 (+7), OVERFLOW
        --   Both negative, result positive → overflow
        A <= "1000"; B <= "1111"; AddSub <= '0'; wait for 20 ns;
        check("ADD -8+-1 OVERFLOW", A, B, AddSub, "0111", '1', '0', Result, Overflow, Zero);

        -- --------------------------------------------------------
        -- SUBTRACTION TESTS (AddSub = '1')
        -- --------------------------------------------------------

        -- Test 6: 5 - 3 = 2  (0101 - 0011 = 0010)
        A <= "0101"; B <= "0011"; AddSub <= '1'; wait for 20 ns;
        check("SUB 5-3=2", A, B, AddSub, "0010", '0', '0', Result, Overflow, Zero);

        -- Test 7: 4 - 4 = 0 → Zero flag set
        A <= "0100"; B <= "0100"; AddSub <= '1'; wait for 20 ns;
        check("SUB 4-4=0 ZERO", A, B, AddSub, "0000", '0', '1', Result, Overflow, Zero);

        -- Test 8: 0 - 1 = -1  (0000 - 0001 = 1111)
        A <= "0000"; B <= "0001"; AddSub <= '1'; wait for 20 ns;
        check("SUB 0-1=-1", A, B, AddSub, "1111", '0', '0', Result, Overflow, Zero);

        -- Test 9: 7 - (-1) = 8 → 1000 = -8, OVERFLOW
        --   Positive minus negative → positive expected, got negative
        A <= "0111"; B <= "1111"; AddSub <= '1'; wait for 20 ns;
        check("SUB 7-(-1) OVERFLOW", A, B, AddSub, "1000", '1', '0', Result, Overflow, Zero);

        -- Test 10: -8 - 1 = -9 → 0111 = +7, OVERFLOW
        A <= "1000"; B <= "0001"; AddSub <= '1'; wait for 20 ns;
        check("SUB -8-1 OVERFLOW", A, B, AddSub, "0111", '1', '0', Result, Overflow, Zero);

        -- --------------------------------------------------------
        -- NEG SIMULATION TESTS
        -- NEG R is implemented by Instruction Decoder as: 0 - R
        -- i.e., A = R0 = 0000, B = R, AddSub = '1'
        -- --------------------------------------------------------

        -- Test 11: NEG(1) = -1  → 0000 - 0001 = 1111
        A <= "0000"; B <= "0001"; AddSub <= '1'; wait for 20 ns;
        check("NEG 1 = -1", A, B, AddSub, "1111", '0', '0', Result, Overflow, Zero);

        -- Test 12: NEG(5) = -5  → 0000 - 0101 = 1011
        A <= "0000"; B <= "0101"; AddSub <= '1'; wait for 20 ns;
        check("NEG 5 = -5", A, B, AddSub, "1011", '0', '0', Result, Overflow, Zero);

        -- Test 13: NEG(-3) = +3  → 0000 - 1101 = 0011
        A <= "0000"; B <= "1101"; AddSub <= '1'; wait for 20 ns;
        check("NEG -3 = +3", A, B, AddSub, "0011", '0', '0', Result, Overflow, Zero);

        -- Test 14: NEG(0) = 0  → 0000 - 0000 = 0000, Zero flag set
        A <= "0000"; B <= "0000"; AddSub <= '1'; wait for 20 ns;
        check("NEG 0 = 0 ZERO", A, B, AddSub, "0000", '0', '1', Result, Overflow, Zero);

        -- Test 15: NEG(-8) = +8 → overflow! -8 cannot be represented as +8 in 4-bit signed
        --   0000 - 1000 = 1000, OVERFLOW
        A <= "0000"; B <= "1000"; AddSub <= '1'; wait for 20 ns;
        check("NEG -8 OVERFLOW", A, B, AddSub, "1000", '1', '0', Result, Overflow, Zero);

        -- --------------------------------------------------------
        -- PROGRAM TRACE TESTS (from the lab's sample program)
        -- MOVI R1,10 → R1=1010; MOVI R2,1 → R2=0001
        -- NEG R2     → R2 = 0-1 = 1111 (-1)
        -- ADD R1,R2  → R1 = 1010 + 1111 = 1001 (10 + (-1) = 9)
        -- --------------------------------------------------------

        -- Test 16: ADD R1(10) + R2(-1) = 9
        A <= "1010"; B <= "1111"; AddSub <= '0'; wait for 20 ns;
        check("PROG ADD 10+(-1)=9", A, B, AddSub, "1001", '0', '0', Result, Overflow, Zero);

        wait;
    end process;

end Behavioral;
