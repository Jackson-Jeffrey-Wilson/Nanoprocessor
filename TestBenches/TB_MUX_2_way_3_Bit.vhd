library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity TB_MUX_2_way_3_Bit is
end TB_MUX_2_way_3_Bit;
 
architecture Behavioral of TB_MUX_2_way_3_Bit is

    component MUX_2_way_3_Bit
        Port (
            Adder_out : in  STD_LOGIC_VECTOR (2 downto 0);
            Address   : in  STD_LOGIC_VECTOR (2 downto 0);
            Jump      : in  STD_LOGIC;
            Q         : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;
 
    signal Adder_out_TB : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal Address_TB   : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal Jump_TB      : STD_LOGIC := '0';
    signal Q_TB         : STD_LOGIC_VECTOR (2 downto 0);
 
begin

    UUT : MUX_2_way_3_Bit
        port map (
            Adder_out => Adder_out_TB,
            Address   => Address_TB,
            Jump      => Jump_TB,
            Q         => Q_TB
        );
 
    stimulus : process
    begin
 
        Adder_out_TB <= "001";
        Address_TB   <= "111";
        Jump_TB      <= '0';
        wait for 100 ns;
 
        Adder_out_TB <= "010";
        Address_TB   <= "110";
        Jump_TB      <= '0';
        wait for 100 ns;
 
        Adder_out_TB <= "011";
        Address_TB   <= "101";
        Jump_TB      <= '0';
        wait for 100 ns;
 
        Adder_out_TB <= "100";
        Address_TB   <= "000";
        Jump_TB      <= '0';
        wait for 100 ns;

        Adder_out_TB <= "111";
        Address_TB   <= "010";
        Jump_TB      <= '0';
        wait for 100 ns;

        Adder_out_TB <= "101";
        Address_TB   <= "000";
        Jump_TB      <= '1';
        wait for 100 ns;

        Adder_out_TB <= "001";
        Address_TB   <= "011";
        Jump_TB      <= '1';
        wait for 100 ns;

        Adder_out_TB <= "010";
        Address_TB   <= "111";
        Jump_TB      <= '1';
        wait for 100 ns;

        Adder_out_TB <= "100";
        Address_TB   <= "101";
        Jump_TB      <= '1';
        wait for 100 ns;

        Adder_out_TB <= "011";
        Address_TB   <= "110";
        Jump_TB      <= '1';
        wait for 50 ns;
 
        Jump_TB <= '0';
        wait for 50 ns;

        Adder_out_TB <= "010";
        Address_TB   <= "101";
        Jump_TB      <= '0';
        wait for 50 ns;
 
        Jump_TB <= '1';
        wait for 50 ns;
 
        wait;
    end process;
 
end Behavioral;