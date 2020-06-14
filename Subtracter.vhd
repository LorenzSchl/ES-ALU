----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:12:39 06/14/2020 
-- Design Name: 
-- Module Name:    Subtracter - Behavioral 
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

entity Subtracter is
    Port ( A : in  std_logic_vector(7 downto 0);
           B : in  std_logic_vector(7 downto 0);
           Data : out  std_logic_vector(7 downto 0);
           carry : out  STD_LOGIC);
end Subtracter;

architecture Behavioral of Subtracter is

begin

process(A,B) 
	variable tmpCarry : std_logic := '0';
	variable tmpResult : std_logic_vector(7 downto 0) := x"00";
begin	
	IF to_integer(unsigned(B)) > to_integer(unsigned(A))THEN
	tmpCarry := '1';
	tmpResult := x"00";
	ELSE
	tmpCarry := '0';
	tmpResult := std_logic_vector(unsigned(A) - unsigned(B));
	END IF;
	Data <= tmpResult;
	carry <= tmpCarry;
end process;

end Behavioral;

