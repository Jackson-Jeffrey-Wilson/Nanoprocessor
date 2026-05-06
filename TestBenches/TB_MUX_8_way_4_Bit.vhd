library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity TB_MUX_8_way_4_Bit is
end TB_MUX_8_way_4_Bit;
 
architecture Behavioral of TB_MUX_8_way_4_Bit is
 
    component MUX_8_way_4_Bit
        Port (
            Reg_Sel : in  STD_LOGIC_VECTOR (2 downto 0);
            R0      : in  STD_LOGIC_VECTOR (3 downto 0);
            R1      : in  STD_LOGIC_VECTOR (3 downto 0);
            R2      : in  STD_LOGIC_VECTOR (3 downto 0);
            R3      : in  STD_LOGIC_VECTOR (3 downto 0);
            R4      : in  STD_LOGIC_VECTOR (3 downto 0);
            R5      : in  STD_LOGIC_VECTOR (3 downto 0);
            R6      : in  STD_LOGIC_VECTOR (3 downto 0);
            R7      : in  STD_LOGIC_VECTOR (3 downto 0);
            Q       : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
 
    signal Reg_Sel_TB : STD_LOGIC_VECTOR (2 downto 0) := "000";
 
    signal R0_TB : STD_LOGIC_VECTOR (3 downto 0) := "0000"; 
    signal R1_TB : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    signal R2_TB : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    signal R3_TB : STD_LOGIC_VECTOR (3 downto 0) := "0011";
    signal R4_TB : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    signal R5_TB : STD_LOGIC_VECTOR (3 downto 0) := "0101";
    signal R6_TB : STD_LOGIC_VECTOR (3 downto 0) := "0110";
    signal R7_TB : STD_LOGIC_VECTOR (3 downto 0) := "0111";
 
    signal Q_TB : STD_LOGIC_VECTOR (3 downto 0);
 
begin
 
    UUT : MUX_8_way_4_Bit
        port map (
            Reg_Sel => Reg_Sel_TB,
            R0 => R0_TB, R1 => R1_TB, R2 => R2_TB, R3 => R3_TB,
            R4 => R4_TB, R5 => R5_TB, R6 => R6_TB, R7 => R7_TB,
            Q  => Q_TB
        );
 
    stimulus : process
    begin

        Reg_Sel_TB <= "000"; wait for 100 ns;

        Reg_Sel_TB <= "001"; wait for 100 ns;

        Reg_Sel_TB <= "010"; wait for 100 ns;

        Reg_Sel_TB <= "011"; wait for 100 ns;

        Reg_Sel_TB <= "100"; wait for 100 ns;

        Reg_Sel_TB <= "101"; wait for 100 ns;

        Reg_Sel_TB <= "110"; wait for 100 ns;

        Reg_Sel_TB <= "111"; wait for 100 ns;
 
        R0_TB <= "0000"; 
        R1_TB <= "0000"; 
        R2_TB <= "0000";
        R3_TB <= "0000";
        R4_TB <= "0011"; 
        R5_TB <= "0010";
        R6_TB <= "0000"; 
        R7_TB <= "0001"; 
        wait for 10 ns; 

        Reg_Sel_TB <= "111"; wait for 100 ns;
 
        Reg_Sel_TB <= "101"; wait for 100 ns;

        R7_TB <= "0011"; wait for 10 ns;

        Reg_Sel_TB <= "111"; wait for 100 ns;

        Reg_Sel_TB <= "100"; wait for 100 ns;

        R7_TB <= "0110"; wait for 10 ns;

        Reg_Sel_TB <= "111"; wait for 100 ns;
 
        R0_TB <= "0000";
        Reg_Sel_TB <= "000"; wait for 100 ns;

        R7_TB      <= "1010";
        Reg_Sel_TB <= "111";
        wait for 50 ns;

 
        R7_TB <= "0101";
        wait for 50 ns;

        R4_TB      <= "1100";
        R5_TB      <= "0011";
        Reg_Sel_TB <= "100";
        wait for 50 ns;
 
        Reg_Sel_TB <= "101";
        wait for 50 ns;
 
        wait;
    end process;
 
end Behavioral;
