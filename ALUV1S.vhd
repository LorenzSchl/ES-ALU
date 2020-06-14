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
	
	--Signals for RAM
	signal ramDataIn : std_logic := '0';
	signal ramDataOut : std_logic := '0';
	signal ramEnable : std_logic := '0';
	signal ramWrEnable : std_logic := '0';
	signal ramReset : std_logic := '0';
	signal ramAddr : std_logic_vector(5 downto 0) := (others => '0');
	
	--Signal for Subtracter Results
	signal subABResult : std_logic_vector(7 downto 0) := (others => '0');
	signal subABCarry : std_logic := '0';
	signal subBAResult : std_logic_vector(7 downto 0) := (others => '0');
	signal subBACarry : std_logic := '0';
	
	--Signal for Subtracter Results
	signal A_rll : std_logic_vector(7 downto 0) := (others => '0');
	signal A_rlr : std_logic_vector(7 downto 0) := (others => '0');
begin

	--Instatntiation of Carry Look Ahead Adder
		ADDER: entity work.CLAdder port map(
		        x_in => A,
              y_in => B,
              carry_in => '0',
              sum => adderSumResult,
              carry_out => adderCarry);
	 --Instantiation of Subtracter (A - B)
	 SUBAB: entity work.subtracter port map(
					A => A,
					B => B,
					Data => subABResult,
					carry => subABCarry);
	--Instantiation of Subtracter (B - A)
	 SUBBA: entity work.subtracter port map(
					A => B,
					B => A,
					Data => subBAResult,
					carry => subBACarry);
	 --Instantiation of Left Rotate
	 RLL: entity work.rotater port map(
					X_In => A,
					rotate_left => '1',
					X_Out => A_rll);
	 --Instantiation of Left Rotate
	 RLR: entity work.rotater port map(
					X_In => A,
					rotate_left => '0',					
					X_Out => A_rlr);
				  
		ram: entity work.ram_64x1 port map(
		WCLK => CLK,
		D => ramDataIn,
		O => ramDataOut,
		ADDR => ramAddr,
		EN => ramEnable,
		RST => ramReset,
		WE => ramWrEnable
		);
		 				  
	process(A, B, Cmd, CLK)
		variable tmpCarry : std_logic := '0';
		variable tmp8Bit : std_logic_vector(7 downto 0) := x"00";
		variable tmp16Bit : std_logic_vector(15 downto 0) := x"0000";
		
		
	begin		
		if rising_edge(CLK) then
			Cout <= '0';
			if A = B then
				Equal <= '1';
			else
				Equal <= '0';
			end if;
			
			case(Cmd) is
				when "0000" => -- A+B
					FLow <= adderSumResult;
					Cout <= adderCarry;
					FHigh <= x"00";
					
				when "0001" => -- A-B
					FLow <= subABResult;
					FHigh <= x"00";
					Cout <= subABCarry;
					
				when "0010" => -- B-A
					FLow <= subBAResult;
					FHigh <= x"00";
					Cout <= subBACarry;
					
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
				ramEnable <= '1';
				ramAddr <= A(5 downto 0);
				
				when "1111" => -- RESERVED
				
				when others => 
			end case;
		end if;
	end process;
end Behavioral;

