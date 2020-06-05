----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:37:59 06/05/2020 
-- Design Name: 
-- Module Name:    ALUV1S - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALUV1S is
  port (
    CLK : in std_logic;
    A, B : in std_logic_vector(7 downto 0);
    Cmd : in std_logic_vector(3 downto 0);
    FLow : out std_logic_vector(7 downto 0);
    FHigh : out std_logic_vector(7 downto 0);
    Cout : out std_logic;
    Equal : out std_logic);
end ALUV1S;

architecture Behavioral of ALUV1S is
begin
	process(A, B, Cmd, CLK)	begin	
		if rising_edge(CLK) then
			case(Cmd) is
				when "0000" => -- A+B
					FLow <= ;
					FHigh <= ;
				when "0001" => -- A-B
					FLow <= ;
					FHigh <= ;
				when "0010" => -- B-A
					FLow <= ;
					FHigh <= ;
				when "0011" => -- A
					FLow <= ;
					FHigh <= ;
				when "0100" => -- B
					FLow <= ;
					FHigh <= ;
				when "0101" => -- -A
					FLow <= ;
					FHigh <= ;
				when "0110" => -- -B
					FLow <= ;
					FHigh <= ;
				when "0111" => -- sll(A)
					FLow <= ;
					FHigh <= ;
				when "1000" => -- slr(A)
					FLow <= ;
					FHigh <= ;
				when "1001" => -- rll(A)
					FLow <= ;
					FHigh <= ;
				when "1010" => -- rlr(A)
					FLow <= ;
					FHigh <= ;
				when "1011" => -- A*B
					FLow <= ;
					FHigh <= ;
				when "1100" => -- NAND(A,B)
					FLow <= ;
					FHigh <= ;
				when "1101" => -- XOR(A,B)
					FLow <= ;
					FHigh <= ;
				when "1110" => -- CRC_MEM
					FLow <= ;
					FHigh <= ;
				when "1111" => -- RESERVED
					FLow <= ;
					FHigh <= ;
		end if
	end process;
end Behavioral;

