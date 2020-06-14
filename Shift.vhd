----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:43:45 06/14/2020 
-- Design Name: 
-- Module Name:    Shift - Behavioral 
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

entity Shift is
    Port ( A : in  std_logic_vector(7 downto 0);
			  right : in std_logic; --Shifts to the left if 1, otherwise it shifts right.
           D : out  std_logic_vector(7 downto 0));
end Shift;

architecture Behavioral of Shift is

begin

process(A) 
	variable temp:  std_logic_vector(7 downto 0):= x"00";
begin

IF(right = '1')THEN
			temp(7 downto 1) := A(6 downto 0);
			temp(0) := '0';
		ELSE
			temp(6 downto 0) := A(7 downto 1);
			temp(7) := '0';
		END IF;
		D <= temp;
end process;


end Behavioral;

