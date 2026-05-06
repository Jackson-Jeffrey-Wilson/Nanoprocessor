library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Decoder_3_to_8 is
end TB_Decoder_3_to_8;

architecture Behavioral of TB_Decoder_3_to_8 is

    component Decoder_3_to_8
        port ( I  : in  std_logic_vector(2 downto 0);
               EN : in  std_logic;
               Y  : out std_logic_vector(7 downto 0));
    end component;

    signal I  : std_logic_vector(2 downto 0);
    signal EN : std_logic;
    signal Y  : std_logic_vector(7 downto 0);

begin

    UUT: Decoder_3_to_8 port map(
        I  => I,
        EN => EN,
        Y  => Y);

    process
    begin
        -- Test with EN = '1' (active)
        EN <= '1';
        I <= "000"; WAIT FOR 50ns;
        I <= "001"; WAIT FOR 50ns;
        I <= "010"; WAIT FOR 50ns;
        I <= "011"; WAIT FOR 50ns;
        I <= "100"; WAIT FOR 50ns;
        I <= "101"; WAIT FOR 50ns;
        I <= "110"; WAIT FOR 50ns;
        I <= "111"; WAIT FOR 50ns;

        -- Test with EN = '0' (disabled, all outputs should be 0)
        EN <= '0';
        I <= "000"; WAIT FOR 50ns;
        I <= "001"; WAIT FOR 50ns;
        I <= "010"; WAIT FOR 50ns;
        I <= "011"; WAIT FOR 50ns;
        I <= "100"; WAIT FOR 50ns;
        I <= "101"; WAIT FOR 50ns;
        I <= "110"; WAIT FOR 50ns;
        I <= "111"; WAIT FOR 50ns;

        WAIT;
    end process;

end Behavioral;