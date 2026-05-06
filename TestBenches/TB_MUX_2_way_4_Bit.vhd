library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_MUX_2_way_4_Bit is
end TB_MUX_2_way_4_Bit;

architecture Behavioral of TB_MUX_2_way_4_Bit is

    component MUX_2_way_4_Bit
        Port (
            Adder_Sub_Out : in  STD_LOGIC_VECTOR (3 downto 0);
            Imd_Value     : in  STD_LOGIC_VECTOR (3 downto 0);
            Load          : in  STD_LOGIC;
            Q             : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal Adder_Sub_Out_TB : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal Imd_Value_TB     : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal Load_TB          : STD_LOGIC := '0';
    signal Q_TB             : STD_LOGIC_VECTOR (3 downto 0);

begin

    UUT : MUX_2_way_4_Bit
        port map (
            Adder_Sub_Out => Adder_Sub_Out_TB,
            Imd_Value     => Imd_Value_TB,
            Load          => Load_TB,
            Q             => Q_TB
        );

    stimulus : process
    begin

        Adder_Sub_Out_TB <= "0000";
        Imd_Value_TB     <= "1111";
        Load_TB          <= '0';
        wait for 100 ns;

        Adder_Sub_Out_TB <= "1010";
        Imd_Value_TB     <= "0101";
        Load_TB          <= '0';
        wait for 100 ns;

        Adder_Sub_Out_TB <= "1111";
        Imd_Value_TB     <= "0000";
        Load_TB          <= '0';
        wait for 100 ns;

        Adder_Sub_Out_TB <= "0110";
        Imd_Value_TB     <= "1001";
        Load_TB          <= '0';
        wait for 100 ns;

        Adder_Sub_Out_TB <= "0000";
        Imd_Value_TB     <= "0001";
        Load_TB          <= '1';
        wait for 100 ns;

        Adder_Sub_Out_TB <= "1010";
        Imd_Value_TB     <= "0010";
        Load_TB          <= '1';
        wait for 100 ns;

        Adder_Sub_Out_TB <= "1111";
        Imd_Value_TB     <= "0011";
        Load_TB          <= '1';
        wait for 100 ns;

        Adder_Sub_Out_TB <= "0101";
        Imd_Value_TB     <= "1111";
        Load_TB          <= '1';
        wait for 100 ns;

        Adder_Sub_Out_TB <= "1100";
        Imd_Value_TB     <= "0011";
        Load_TB          <= '1';
        wait for 50 ns;

        Load_TB <= '0';
        wait for 50 ns;

        Adder_Sub_Out_TB <= "1001";
        Imd_Value_TB     <= "0110";
        Load_TB          <= '0';
        wait for 50 ns;

        Load_TB <= '1';
        wait for 50 ns;

        wait;
    end process;

end Behavioral;