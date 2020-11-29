
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity cachecontroller is
 Port (
		--CPU INPUT SIGNALS
   	     clk 							: in  STD_LOGIC;
		 addra     					: in std_logic_vector(15 downto 0);

		--OUTPUTS TO SRAM
		 DOUT 							: out STD_LOGIC_VECTOR(7 downto 0);
	
		--OUTPUT TO CPU
		 RDY 							: out STD_LOGIC; 
		--OUTPUTS TO SDRAM 
         cs          					: out std_logic;
         WR_RD							: out STD_LOGIC; 
		 MSTRB							: out STD_LOGIC
		   
			  );	
end cachecontroller;

architecture Behavioral of cachecontroller is


--CacheSignals
 
	signal addr_Out_signal 		 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	signal tag_in		 		   :STD_LOGIC_VECTOR(7 downto 0);--
	signal index_signal			   :STD_LOGIC_VECTOR(2 downto 0);--
	signal offset_signal		   :STD_LOGIC_VECTOR(4 downto 0);--
--Components

component CPU_gen	--good
		PORT(
			clk 						: in STD_LOGIC;
			rst 						: in STD_LOGIC;
			trig 						: in STD_LOGIC;
			Address 					: out STD_LOGIC_VECTOR(15 DOWNTO 0);
			WR_RD					   : out STD_LOGIC;
			cs 						: out STD_LOGIC;
			DOut					   : out STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component;	
-- CPU SIGNALS 
	signal CPU_addr_signal 	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal CPU_WR_RD_signal : STD_LOGIC;
	signal cs_signal		: STD_LOGIC;
	signal ready			: STD_LOGIC;
	signal CPU_ready_signal : STD_LOGIC;
	signal CPU_DOut_signal	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal CPU_DIn_signal 	: STD_LOGIC_VECTOR(7 DOWNTO 0); 
	
------
	
	
	COMPONENT SDRAMController -- rename them
  PORT (
    clka 		: IN STD_LOGIC;
    ena 		: IN STD_LOGIC;--mstrb
    wea 		: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra 		: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dina 		: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta 		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

	signal SDRAM_Dout_signal     : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal SDRAM_Din_signal      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal SDRAM_addr		     : std_logic_vector(15 downto 0);
	signal WR_RD_Out_signal 	 : STD_LOGIC;	
	signal MSTRB_signal			 : STD_LOGIC;
	signal counter				 : integer := 0;
	signal offset				 : integer := 0;
	
			
------
	

	COMPONENT sram--bram blocks
		PORT (
			clka  : IN STD_LOGIC;
			wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			dina  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	
	--going to need 2 bit register files on for valid one for dirty
	
	signal validin_signal 		: STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	signal dirtyin_signal 		: STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	signal d_out_select_signal  : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal d_in_select_signal   : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal cache_address_signal : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal weasig				: STD_LOGIC_VECTOR (0 downto 0);
	signal tag_Wen				: STD_LOGIC ;--:= '0';
	
	type rtype is array (7 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
	signal tagcheck: rtype := ((others=> (others=>'0')));
	
	--Debugging Signals
	signal control0 : STD_LOGIC_VECTOR(35 downto 0);
	signal ila_data : std_logic_vector(35 downto 0);
	signal trig0 	 : std_logic_vector(0 TO 0);--check this one out
	-----------------------------------------------------------------------------
	--State Signals
	
	TYPE state_value IS (stt0, stt1, stt2, stt3,stt4);
	signal ps				   : state_value:=stt0;
	signal stts					: STD_LOGIC_VECTOR(3 downto 0);
--------------------------------------------------------------------------------

begin

	CPU : CPU_gen
	port map (
	
			clk,
			'0',
			CPU_ready_signal,
			CPU_addr_signal,
			CPU_WR_RD_signal,
			cs_signal,
		    CPU_DOut_signal
			);
	
	mainMem : SDRAMController 
	port map(
		clk,
		SDRAM_addr,
	    WR_RD_Out_signal , 
		MSTRB_signal,
		SDRAM_Din_signal,
	    SDRAM_Dout_signal
	
	);
	
	cacheMemory : sram 
	port map(
	    clk,
		weasig,
	    cache_address_signal,
		d_in_select_signal, 
	    d_out_select_signal   
	);
	
	
	MSTRB   <= MSTRB_signal;
	cs 		<= cs_signal;
	addra 	<= CPU_addr_signal;
	WR_RD 	<= CPU_WR_RD_signal;
	DOut	<= CPU_DIn_signal;
	RDY		<= CPU_ready_signal;
	
	
	process(clk, cs_signal)
		begin
				if(clk'event and clk='1') then
					state_value <= state0; --conxn setup
					
					case state_value is
					
					when state0 =>
													
							tag_in <= CPU_addr_signal(15 downto 8); -- tag register
							index_signal  <= CPU_addr_signal(7 downto 5);
							offset_signal <= CPU_addr_signal(4 downto 0);
							cache_address_signal(7 downto 0) <= CPU_addr_signal(7 downto 0); 
							SDRAM_addr(15 downto 0) <= CPU_addr_signal(15 downto 0);-- check this address
						    CPU_ready_signal <='0';---check this 
							--cs_signal <=cs_signal +1;
							
						--HIT or MISS
				if (tagcheck(to_integer(unsigned(index_signal))) = tag_in and validin_signal(to_integer(unsigned(index_signal)))= '1') then -- hit
						tag_Wen <= '1';
						--CPU_WR_RD_signal <= '1';
						state_value <= state1; -- write function
						stt <= "0001";
					else	-- miss function
						tag_Wen <= '0';
											
				  if(validin_signal(to_integer(unsigned(index_signal)))= '1' and dirtyin_signal(to_integer(unsigned(index_signal)))= '1' )then
						state_value <= state2; -- write to sdram
						state <= "0010";
					else
						state_value<= state3; -- no writeback 
						state<="0011";
				  end if;
				end if;
					
				
			when state1 => -- hit write/read
				
				if(CPU_WR_RD_signal = '1') then --write request s1
					
					dirtyin_signal(to_integer(unsigned(index_signal)))<= '1';
					validin_signal(to_integer(unsigned(index_signal)))<= '1';
					d_in_select_signal <= CPU_DOut_signal;
					CPU_DIn_signal <="00000000";
					weasig <= "1";
					
				else
					CPU_DIn_signal <= d_out_select_signal;
					
				end if; 
				
				  state_value<= state4; --idle
				
			when state2 => -- case write to sdram read from sram
				 if(counter=64) then
				 counter <= 0;
				 dirtyin_signal(to_integer(unsigned(index_signal)))<= '0';
				 offset <= 0;
				 state_value <= state3;
				else
					validin_signal(to_integer(unsigned(index_signal)))<= '0';
					if(counter mod 2 =1) then
						MSTRB_signal <= '0';
					else 
					SDRAM_addr(4 downto 0) <= STD_LOGIC_VECTOR(to_unsigned(offset, offset_signal'length));
					WR_RD_Out_signal <= '1';
				
				SDRAM_addr(7 downto 5) <= index_signal; 
				SDRAM_addr(4 downto 0) <= STD_LOGIC_VECTOR(to_unsigned(offset, offset_signal'length));--<= "00000"; 
				weasig <= "0";
				SDRAM_Din_signal <= d_out_select_signal;
				MSTRB_signal <= '1';
				offset <= offset + 1;
					end if;
					counter <= counter + 1;
				end if;
				
			
			when state3 => --case read from sdram and write it to sram
				if(counter = 64) then
				counter <=0;
				validin_signal(to_integer(unsigned(indexFROMCPU))) <= '1';
				tagcheck(to_integer(unsigned(index_signal))) <= tag_in;
				offset <= 0;
				state_value <= state1;
				else
					if (counter mod 2 = 1) then	--Alternates the mstrb
						MSTRB_signal <= '0';
					else
					SDRAM_addr(4 downto 0) <= STD_LOGIC_VECTOR(to_unsigned(offset, offset_signal'length));
					WR_RD_Out_signal <= '0';
				
				SDRAM_addr(7 downto 5) <= index_signal; 
				SDRAM_addr(4 downto 0) <= STD_LOGIC_VECTOR(to_unsigned(offset, offset_signal'length));--<= "00000"; 
				weasig <= "1";
				d_in_select_signal<= SDRAM_Dout_signal;
				MSTRB_signal <= '1';
				offset <= offset + 1;
					end if;
					counter <= counter + 1;
				end if;
		
		
				
			when state4 =>
			CPU_ready_signal<= '1';
				if (cs_signal = '1') then
					state_value <= state0;	--Sends to state0 when CPU receives CS
					
				end if;
				
				
				end case;
				end if;
		end process;
		




end Behavioral;