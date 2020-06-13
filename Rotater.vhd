----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:38:31 06/13/2020 
-- Design Name: 
-- Module Name:    Rotater - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rotater is
    Port ( X_In : in  std_logic_vector(7 downto 0);
           rotate_left : in  std_logic;
           X_Out : out  std_logic_vector(7 downto 0));
end Rotater;

architecture Behavioral of Rotater is
begin
	process(X_In, rotate_left) 
		variable output : std_logic_vector(7 downto 0) := x"00";
	begin	
		IF(rotate_left = '1')THEN
			output(7 downto 1) := X_In(6 downto 0);
			output(0) := X_In(7);
		ELSE
			output(6 downto 0) := X_In(7 downto 1);
			output(7) := X_In(0);
		END IF;
		X_Out <= output;
	end process;
end Behavioral;

