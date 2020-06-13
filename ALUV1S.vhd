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
	
	--Signal for Adder Results
	signal adderSumResult : std_logic_vector(7 downto 0) := (others => '0');
	signal adderCarry : std_logic := '0';
	
	--Signals for CRC
	signal crcDataInA : std_logic_vector(7 downto 0);
	signal crcDataInB : std_logic_vector(7 downto 0);
	signal crcDataOutA : std_logic_vector(7 downto 0);
	signal crcDataOutB : std_logic_vector(7 downto 0);
	signal crcAddA : std_logic_vector(8 downto 0);
	signal crcAddB : std_logic_vector(8 downto 0);
	signal crcResA : std_logic := '1';
	signal crcResB : std_logic := '1';
	signal crcEnA : std_logic := '0';
	signal crcEnB : std_logic := '0';
	signal crcWrEnA : std_logic := '0';
	signal crcWrEnB : std_logic := '0';
begin

	--Instatntiation of Carry Look Ahead Adder
		ADDER: entity work.CLAdder port map(
		        x_in => A,
              y_in => B,
              carry_in => '0',
              sum => adderSumResult,
              carry_out => adderCarry);
				  
		XYZRam : entity work.xyzram port map(
		CLKA => CLK,
		CLKB => CLK,
		DIA => crcDataInA,
		DIB => crcDataInB,
		DOA => crcDataOutA,
		DOB => crcDataOutB,
		ADDRA => crcAddA,
		ADDRB => crcAddB,
		ENA => crcEnA,
		ENB => crcEnB,
		RSTA => crcResA,
		RSTB => crcResB,
		WEA => crcWrEnA,
		WEB => crcWrEnB
		);
		 				  
	process(A, B, Cmd, CLK)
		variable tmpCarry : std_logic := '0';
		variable tmp8Bit : std_logic_vector(7 downto 0) := x"00";
		variable tmp16Bit : std_logic_vector(15 downto 0) := x"0000";
		
		
	begin		
		if rising_edge(CLK) then
			if A = B then
				Equal <= '1';
			end if;
			
			case(Cmd) is
				when "0000" => -- A+B
					FLow <= adderSumResult;
					Cout <= adderCarry;
					FHigh <= x"00";
					
				when "0001" => -- A-B
					if A > B then
						FLow <= A - B;
					elsif A = B then
						FLow <= x"00";
					else
						FLow <= x"00";
						Cout <= '1';
					end if;	
					
				when "0010" => -- B-A
					if A < B then
						FLow <= B - A;
					elsif A = B then
						FLow <= x"00";
					else
						FLow <= x"00";
						Cout <= '1';
					end if;
					
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
					tmp16Bit := std_logic_vector(to_unsigned((to_integer(unsigned(A)) * to_integer(unsigned(B))), 16));
					FLow <= tmp16Bit(7 downto 0);
					FHigh <= tmp16Bit(15 downto 8);
					
				when "1100" => -- NAND(A,B)
					FLow <= A nand B;							
				when "1101" => -- XOR(A,B)
					FLow <= A xor B;
					
				when "1110" => -- CRC_MEM
				crcEnA <= '1';
		      crcEnB <= '1';
				crcResA <= '0';
	         crcResB <= '0';
				crcAddA <= x"00";
				crcAddB <= x"00";
				
				when "1111" => -- RESERVED
				
				when others => 
			end case;
		end if;
	end process;
end Behavioral;

