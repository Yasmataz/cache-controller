----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_2to1 is
 Port ( 	  x : in  STD_LOGIC_VECTOR (31 downto 0);
           y : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           muxOut : out  STD_LOGIC_VECTOR (31 downto 0));
end mux_2to1;

architecture Behavioral of mux_2to1 is

begin
	process(sel)
	begin
	if(sel = '0') then
		muxOut <= x;
	else
		muxOut <= y;
	end if;
	end process;

end Behavioral;
