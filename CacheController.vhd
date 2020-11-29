LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CacheController IS
	PORT (
		clk : IN STD_LOGIC;
		wr_rd, memstrb, rdy, cs : OUT STD_LOGIC;
		state : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		addr : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		cpu_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		sram_address : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		sram_data_in : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		sram_data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		sdram_address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		sdram_data_in : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		sdram_data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END CacheController;

ARCHITECTURE Behavioral OF CacheController IS

	SIGNAL control0 : STD_LOGIC_VECTOR(35 DOWNTO 0);
 

---------------------------------------------------------
-- SDRAM.
---------------------------------------------------------
	COMPONENT SDRAMController
		PORT (
			clk : IN STD_LOGIC;
			ADDR : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			WR_RD : IN STD_LOGIC;
			MEMSTRB : IN STD_LOGIC;
			DIN : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			DOUT : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	END COMPONENT;
	
	--Signals
	SIGNAL sdram_Din, sdram_Dout : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL sdram_addr : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL mstrb, sdram_wr : STD_LOGIC;
	SIGNAL count : INTEGER := 0;
	SIGNAL sdram_offset : INTEGER := 0;
	
---------------------------------------------------------
-- SRAM.
---------------------------------------------------------
	COMPONENT SRAM
		PORT (
			clka : IN STD_LOGIC;
			wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
 
	--Signals
	SIGNAL Dbit : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	SIGNAL Vbit : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	SIGNAL sram_addr, sram_Din, sram_Dout : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL sram_wen : STD_LOGIC_VECTOR(0 DOWNTO 0);
	TYPE cachememory IS ARRAY (7 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL cache_tag : cachememory := ((OTHERS => (OTHERS => '0')));
	SIGNAL current_state : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

---------------------------------------------------------
-- CPU.
---------------------------------------------------------
	COMPONENT CPU_gen
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			trig : IN STD_LOGIC;
			Address : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			wr_rd : OUT STD_LOGIC;
			cs : OUT STD_LOGIC;
			Dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	END COMPONENT; 
	
	--Signals
	SIGNAL cpu_Dout, cpu_Din : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL cpu_addr : STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL cpu_wr, cpu_cs : STD_LOGIC;
	SIGNAL cpu_rdy : STD_LOGIC;
	SIGNAL cpu_tag : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL index : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL offset : STD_LOGIC_VECTOR(4 DOWNTO 0);
 
	COMPONENT icon
		PORT (
			CONTROL0 : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0)
		);
	END COMPONENT;
 

BEGIN
	--PORT MAPS:
	myCPU_gen : CPU_gen
	PORT MAP(
		clk, 
		'0', 
		cpu_rdy, 
		cpu_addr, 
		cpu_wr, 
		cpu_cs, 
		cpu_Dout
	);
	
	SDRAM : SDRAMController
	PORT MAP(
		clk, 
		sdram_addr, 
		sdram_wr, 
		mstrb, 
		sdram_Din, 
		sdram_Dout
	);
	
	mySRAM : SRAM
	PORT MAP(
		clk, 
		sram_wen, 
		sram_addr, 
		sram_Din, 
		sram_Dout
	);
	
myIcon : icon
PORT MAP(CONTROL0);

	
PROCESS (clk, cpu_cs) 
BEGIN
	IF (clk'EVENT AND clk = '1') THEN

		CASE current_state IS --FSM

			WHEN "000" => -- s3 default state
				cpu_rdy <= '1';
				--if (cpu_cs = '1') then
				current_state <= "001";
				-- end if;
				
			WHEN "001" => --s4 hit/miss check
				-- tag, index and offset set from CPU generated address
				cpu_tag <= cpu_addr(15 DOWNTO 8);
				index <= cpu_addr(7 DOWNTO 5);
				offset <= cpu_addr(4 DOWNTO 0);
				
				--main memory address set to address from cpu
				sdram_addr(15 DOWNTO 5) <= cpu_addr(15 DOWNTO 5);
				
				--sram adddress set to index
				sram_addr(7 DOWNTO 0) <= cpu_addr(7 DOWNTO 0);
				sram_wen <= "0";
				cpu_rdy <= '0';

				--check for D and V bit
				IF (Vbit(to_integer(unsigned(index))) = '1' AND cache_tag(to_integer(unsigned(index))) = cpu_tag) THEN -- HIT
					current_state <= "010";
				ELSE --MISS
					IF (Dbit(to_integer(unsigned(index))) = '1' AND Vbit(to_integer(unsigned(index))) = '1') THEN
						-- write to SDRAM then load SRAM
						current_state <= "011"; 
					ELSE -- no need to update SDRAM, just load SRAM
						current_state <= "100";
					END IF;
				END IF;
 
			WHEN "010" => --hit read/write
					IF (cpu_wr = '1') THEN --write cpu data to sram
						sram_wen <= "1"; --enable write
						
						--flip V and D bits because writing
						Dbit(to_integer(unsigned(index))) <= '1';
						Vbit(to_integer(unsigned(index))) <= '1';
						
						--set cpu and sram io
						sram_Din <= cpu_Dout;
						cpu_Din <= "00000000"; --data_out
 
					ELSE --read sram data into cpu
						cpu_Din <= sram_Dout;
					END IF;
 
					current_state <= "000"; --default state
 
			WHEN "100" => --Load SRAM from main mem, no need to update SDRAM
					IF (count = 64) THEN
						count <= 0;
						Vbit(to_integer(unsigned(index))) <= '1';
						cache_tag(to_integer(unsigned(index))) <= cpu_tag;
						sdram_offset <= 0; -- reset offset
						current_state <= "010";
					ELSE
						IF (count MOD 2 = 1) THEN --strobe on every other clck cycle
							mstrb <= '0';
						ELSE
							mstrb <= '1';
							Vbit(to_integer(unsigned(index))) <= '0';
							sdram_wr <= '0';
							sram_wen <= "1"; --enable sram for receiveing data

							--for each address in the block of main mem load the sram with sdram data and update offset to read next memory addr.
							sdram_addr(4 DOWNTO 0) <= STD_LOGIC_VECTOR(to_unsigned(sdram_offset, offset'length)); 

							sram_addr(7 DOWNTO 5) <= index;
							sram_addr(4 DOWNTO 0) <= STD_LOGIC_VECTOR(to_unsigned(sdram_offset, offset'length));
							sram_Din <= sdram_Dout; --write main mem data to sram
							
							sdram_offset <= sdram_offset + 1;
							
						END IF;
						count <= count + 1;
					END IF; 
 
			WHEN "011" => --data modified -> write back to SDRAM 
					IF (count = 64) THEN
						count <= 0;
						Dbit(to_integer(unsigned(index))) <= '0';
						sdram_offset <= 0; --reset offset
						current_state <= "100"; --load sram
					ELSE
						IF (count MOD 2 = 1) THEN --strobe on every other clck cycle
							mstrb <= '0';
						ELSE
							mstrb <= '1';
							sdram_wr <= '1'; --enable writing to main mem
							sram_wen <= "0"; --disable writing to cache
						   
							--for each address in the block read in sram data and update offset to read next address.
							sram_addr(7 DOWNTO 5) <= index;
							sram_addr(4 DOWNTO 0) <= STD_LOGIC_VECTOR(to_unsigned(sdram_offset, offset'length));
							
							sdram_addr(4 DOWNTO 0) <= STD_LOGIC_VECTOR(to_unsigned(sdram_offset, offset'length));
							sdram_Din <= sram_Dout; --write from cache to main mem

							sdram_offset <= sdram_offset + 1;
						END IF;
						count <= count + 1;
					END IF;
			WHEN OTHERS => 
			END CASE;
		END IF;
END PROCESS;
 
		sram_address <= sram_addr;
		sram_data_in <= sram_Din;
		sram_data_out <= sram_Dout;
		sdram_address <= sdram_addr;
		sdram_data_in <= sdram_Din;
		sdram_data_out <= sdram_Dout;
		memstrb <= mstrb;
		addr <= cpu_addr;
		wr_rd <= cpu_wr;
		data_out <= cpu_Din;
		rdy <= cpu_rdy;
		cs <= cpu_cs;
		cpu_out <= cpu_Dout;
		state <= current_state;
 

END Behavioral;