--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:16:57 10/30/2020
-- Design Name:   
-- Module Name:   C:/Users/Yasamin/Documents/Classes/COE758/CacheController-master/cache_test.vhd
-- Project Name:  CACHE2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CacheController
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cache_test IS
END cache_test;
 
ARCHITECTURE behavior OF cache_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CacheController
    PORT(
         clk : IN  std_logic;
         addr : OUT  std_logic_vector(15 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
			cpu_out : OUT  std_logic_vector(7 downto 0);
         sram_address : OUT  std_logic_vector(7 downto 0);
         sram_data_in : OUT  std_logic_vector(7 downto 0);
         sram_data_out : OUT  std_logic_vector(7 downto 0);
         sdram_address : OUT  std_logic_vector(15 downto 0);
         sdram_data_in : OUT  std_logic_vector(7 downto 0);
         sdram_data_out : OUT  std_logic_vector(7 downto 0);
         state : OUT  std_logic_vector(2 downto 0);
         wr_rd : OUT  std_logic;
         memstrb : OUT  std_logic;
         rdy : OUT  std_logic;
         cs : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal addr : std_logic_vector(15 downto 0);
   signal data_out : std_logic_vector(7 downto 0);
   signal sram_address : std_logic_vector(7 downto 0);
   signal cpu_out : std_logic_vector(7 downto 0);
   signal sram_data_in : std_logic_vector(7 downto 0);
   signal sram_data_out : std_logic_vector(7 downto 0);
   signal sdram_address : std_logic_vector(15 downto 0);
   signal sdram_data_in : std_logic_vector(7 downto 0);
   signal sdram_data_out : std_logic_vector(7 downto 0);
   signal state : std_logic_vector(2 downto 0);
   signal wr_rd : std_logic;
   signal memstrb : std_logic;
   signal rdy : std_logic;
   signal cs : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CacheController PORT MAP (
          clk => clk,
          addr => addr,
          data_out => data_out,
			 cpu_out => cpu_out,
          sram_address => sram_address,
          sram_data_in => sram_data_in,
          sram_data_out => sram_data_out,
          sdram_address => sdram_address,
          sdram_data_in => sdram_data_in,
          sdram_data_out => sdram_data_out,
          state => state,
          wr_rd => wr_rd,
          memstrb => memstrb,
          rdy => rdy,
          cs => cs
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*300;

      -- insert stimulus here 

      wait;
   end process;

END;
