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
use ieee.NUMERIC_STD.all;

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
signal temp:  STD_LOGIC_VECTOR(15 downto 0);
begin
	process(A, B, Cmd, CLK)	begin			
		if rising_edge(CLK) then
			case(Cmd) is
				when "0000" => -- A+B
					temp <= A+B;
					FLow <= temp(7 downto 0);
					Cout <= temp(8);
				when "0001" => -- A-B
					FLow <= A-B;
				when "0010" => -- B-A
					FLow <= B-A;
				when "0011" => -- A
					FLow <= A;
				when "0100" => -- B
					FLow <= B;
				when "0101" => -- -A
					FLow <= not A;
				when "0110" => -- -B
					FLow <= not B;
				when "0111" => -- sll(A)
					Cout <= A(7);
					FLow <= std_logic_vector(unsigned(A) sll 1); -- Funktioniert nur im Simulator
				when "1000" => -- slr(A)
					Cout <= A(0);
					FLow <= std_logic_vector(unsigned(A) srl 1); -- Funktioniert nur im Simulator
				when "1001" => -- rll(A)
					FLow <= std_logic_vector(unsigned(A) rol 1); -- Funktioniert nur im Simulator
				when "1010" => -- rlr(A)
					FLow <= std_logic_vector(unsigned(A) ror 1); -- Funktioniert nur im Simulator
				when "1011" => -- A*B
					temp <= std_logic_vector(to_unsigned((to_integer(unsigned(A)) * to_integer(unsigned(B))), 16));
					FLow <= temp(7 downto 0);
					FHigh <= temp(15 downto 8);
				when "1100" => -- NAND(A,B)
					FLow <= A nand B;
				when "1101" => -- XOR(A,B)
					FLow <= A xor B;
				when "1110" => -- CRC_MEM
				when "1111" => -- RESERVED
				when others => 
			end case;
		end if;
	end process;
end Behavioral;

