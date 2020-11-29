library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALl;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tag_register_file is
    Port ( clk : in  STD_LOGIC;
           writeEnable : in  STD_LOGIC;
           index : in  STD_LOGIC_VECTOR (2 downto 0);
           dataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end tag_register_file;

architecture Behavioral of tag_register_file is
	type registerFile is array(0 to 7) of std_logic_vector(7 downto 0);
	signal registers : registerFile;
begin
	
	regFile : process(clk) is
	begin
		if rising_edge(clk) then
			dataOut <= registers(to_integer(unsigned(index)));
			if writeEnable ='1' then
				registers(to_integer(unsigned(index))) <= dataIn;
			end if;
		end if;
	end process;	
end Behavioral;