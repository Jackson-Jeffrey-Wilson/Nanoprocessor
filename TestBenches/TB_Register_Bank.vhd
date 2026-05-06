library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity TB_Register_Bank is
end TB_Register_Bank;

architecture Behavioral of TB_Register_Bank is
    component Register_Bank is
    Port(
        Reg_en: in STD_LOGIC_VECTOR (2 downto 0);
        Clk: in STD_LOGIC;
        Reset: in STD_LOGIC;
        Inp: in STD_LOGIC_VECTOR (3 downto 0);
        Q0 : out STD_LOGIC_VECTOR (3 downto 0);
        Q1 : out STD_LOGIC_VECTOR (3 downto 0);
        Q2 : out STD_LOGIC_VECTOR (3 downto 0);
        Q3 : out STD_LOGIC_VECTOR (3 downto 0);
        Q4 : out STD_LOGIC_VECTOR (3 downto 0);
        Q5 : out STD_LOGIC_VECTOR (3 downto 0);
        Q6 : out STD_LOGIC_VECTOR (3 downto 0);
        Q7 : out STD_LOGIC_VECTOR (3 downto 0)
    );
    end component;

signal Reg_en_TB : STD_LOGIC_VECTOR (2 downto 0);
signal Clk_TB, Reset_TB : STD_LOGIC := '0';
signal Inp_TB : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal Q0_TB, Q1_TB, Q2_TB, Q3_TB, Q4_TB, Q5_TB, Q6_TB, Q7_TB : STD_LOGIC_VECTOR (3 downto 0);

begin

UUT : Register_Bank
    port map (
        Reg_en => Reg_en_TB,
        Clk    => Clk_TB,
        Reset  => Reset_TB,
        Inp    => Inp_TB,
        Q0     => Q0_TB,
        Q1     => Q1_TB,
        Q2     => Q2_TB,
        Q3     => Q3_TB,
        Q4     => Q4_TB,
        Q5     => Q5_TB,
        Q6     => Q6_TB,
        Q7     => Q7_TB
    );

-- Stimulus process
process
begin
    -- Initial state
    Reg_en_TB <= "000";
    Inp_TB    <= "0000";
    wait for 100 ns;

    -- Write 15 (1111) to R1
    Reg_en_TB <= "001";
    Inp_TB    <= "1111";
    wait for 100 ns;

    -- Write 10 (1010) to R2
    Reg_en_TB <= "010";
    Inp_TB    <= "1010";
    wait for 100 ns;

    -- Write 5 (0101) to R4
    Reg_en_TB <= "100";
    Inp_TB    <= "0101";
    wait for 100 ns;

    -- Write 15 (1111) to R5
    Reg_en_TB <= "101";
    Inp_TB    <= "1111";
    wait for 100 ns;

    -- Write 12 (1100) to R7
    Reg_en_TB <= "111";
    Inp_TB    <= "1100";
    wait for 100 ns;

    wait;
end process;

-- Clock process
process
begin
    Clk_TB <= (not Clk_TB);
    wait for 5ns;
end process;

-- Reset process
-- Reset_TB stays '0' throughout (no reset applied in this test)
process
begin
    Reset_TB <= '0';
    wait;
end process;

end Behavioral;