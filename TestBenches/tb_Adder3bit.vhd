-- ============================================================
-- Testbench: Adder3bit
-- Verifies PC increment (A + 1) for all 8 possible PC values
-- including wrap-around (7 + 1 = 0)
-- ============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity tb_Adder3bit is
end tb_Adder3bit;

architecture Behavioral of tb_Adder3bit is

    component Adder3bit
        Port (
            A   : in  STD_LOGIC_VECTOR(2 downto 0);
            Sum : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    signal A   : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal Sum : STD_LOGIC_VECTOR(2 downto 0);

begin
    UUT: Adder3bit port map (A => A, Sum => Sum);

    stim: process
        variable l : line;
    begin
        -- Test all 8 PC values
        -- PC=0 -> 1
        A <= "000"; wait for 20 ns;
        write(l, string'("PC=000 -> ")); write(l, Sum);
        writeline(output, l);

        -- PC=1 -> 2
        A <= "001"; wait for 20 ns;
        write(l, string'("PC=001 -> ")); write(l, Sum);
        writeline(output, l);

        -- PC=2 -> 3
        A <= "010"; wait for 20 ns;
        write(l, string'("PC=010 -> ")); write(l, Sum);
        writeline(output, l);

        -- PC=3 -> 4
        A <= "011"; wait for 20 ns;
        write(l, string'("PC=011 -> ")); write(l, Sum);
        writeline(output, l);

        -- PC=4 -> 5
        A <= "100"; wait for 20 ns;
        write(l, string'("PC=100 -> ")); write(l, Sum);
        writeline(output, l);

        -- PC=5 -> 6
        A <= "101"; wait for 20 ns;
        write(l, string'("PC=101 -> ")); write(l, Sum);
        writeline(output, l);

        -- PC=6 -> 7
        A <= "110"; wait for 20 ns;
        write(l, string'("PC=110 -> ")); write(l, Sum);
        writeline(output, l);

        -- PC=7 -> 0 (wrap-around, carry discarded)
        A <= "111"; wait for 20 ns;
        write(l, string'("PC=111 -> ")); write(l, Sum);
        write(l, string'("  (wrap-around, expect 000)"));
        writeline(output, l);

        wait;
    end process;

end Behavioral;
