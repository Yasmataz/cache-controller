library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SDRAMController is
    Port ( 
			  clk			: in STD_LOGIC;
			  ADDR 		: in  STD_LOGIC_VECTOR (15 downto 0);
           WR_RD 		: in  STD_LOGIC;
           MEMSTRB 	: in  STD_LOGIC;
           DIN 		: in  STD_LOGIC_VECTOR (7 downto 0);
           DOUT 		: out  STD_LOGIC_VECTOR (7 downto 0));
end SDRAMController;

architecture Behavioral of SDRAMController is
    
	 type ram_type is array (7 downto 0, 31 downto 0) of std_logic_vector(7 downto 0);
    signal RAM: ram_type;
	 
	 type sd_ram is array (4095 downto 0) of ram_type; --to correctly load SDRAM this needs to be implemented - only loading 1 block now to test
    signal test: sd_ram;
	 	 
	signal loaded : integer := 0;
begin

process (CLK)
    begin
        if CLK'event and CLK = '1' then		  
            if loaded = 0 then -- load SDRAM with arbitrary value
					for I in 0 to 7 loop
						for J in 0 to 31 loop
							RAM(i,j) <= std_logic_vector(to_unsigned(J, 8));
							end loop;
						end loop;
						loaded <= 1;
					end if;
				
				if MEMSTRB = '1' then
					if WR_RD = '1' then 	--if write enable write Din from sram to sdram
						RAM(to_integer(unsigned(ADDR(7 downto 5))),to_integer(unsigned(ADDR(4 downto 0)))) <= DIN;    
               ELSE -- otherwise return output at specified SDRAM addr
						DOUT <= RAM(to_integer(unsigned(ADDR(7 downto 5))),to_integer(unsigned(ADDR(4 downto 0))));
					end if;
				end if;
        end if;
    end process;


end Behavioral;

