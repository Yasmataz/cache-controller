
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity bit_register_file is
    Port ( clk : in  STD_LOGIC;
           writeEnable : in  STD_LOGIC;
           index : in  STD_LOGIC_VECTOR (2 downto 0);
           dataIn : in  STD_LOGIC;
           dataOut : out  STD_LOGIC);
end bit_register_file;

architecture Behavioral of bit_register_file is
	type registerFile is array(0 to 7) of std_logic;
	signal registers : registerFile;
begin
	regFile : process(clk) is
	begin
		if rising_edge(clk) then
			dataOut <= registers(to_integer(unsigned(index)));
			if writeEnable = '1' then
				registers(to_integer(unsigned(index)))<= dataIn;
			end if;
		end if;
	end process;	
end Behavioral;