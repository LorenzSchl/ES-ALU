----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:00:32 06/14/2020 
-- Design Name: 
-- Module Name:    RAMReader - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAMReader is
    Port ( EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           DATA : out  STD_LOGIC_VECTOR(63 downto 0);
			  FI : inout STD_LOGIC);
end RAMReader;

architecture Behavioral of RAMReader is
	
	signal  currentRamOutput : std_logic;
	signal  currentRamInput : std_logic;
	signal address : std_logic_vector(5 downto 0) := (others => '0');
	signal ramEN : std_logic := '1';
	signal ramRST : std_logic := '0';
	signal ramWE : std_logic := '0';


begin

ram: entity work.ram_64x1 port map(
		WCLK => CLK,
		D => currentRamInput,
		O => currentRamOutput,
		ADDR => address,
		EN => ramEN,
		RST => ramRST,
		WE => ramWE
		
	);

process(EN) begin
if EN = '1' THEN
    FI <= '0';
    address <= "000000";
END IF;
end process;

process(currentRamOutput) begin
 FI <= '0';
 if not FI = '1' then
 DATA(to_integer(unsigned(address))) <= currentRamOutput;
 address <= std_logic_vector(to_unsigned(to_integer(unsigned(address)) + 1, 6));
 if address= "111111" then
	FI <= '1';
 end if;
end if;
end process;


end Behavioral;

