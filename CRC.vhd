----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:39:42 06/14/2020 
-- Design Name: 
-- Module Name:    CRC - Behavioral 
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

entity CRC is
    Port ( EN : in  STD_LOGIC;
			  CLK : in std_logic;
           DATA : out  std_logic_vector(14 downto 0));
end CRC;

architecture Behavioral of CRC is
	signal ramData : STD_LOGIC_VECTOR(63 downto 0) := X"11050070F0A08000";
begin
process(CLK) 
begin
       DATA(0) <= ramData(63) xor ramData(62) xor ramData(61) xor ramData(58) xor ramData(57) xor ramData(52) xor ramData(51) xor ramData(49) xor ramData(48) xor ramData(45) xor ramData(43) xor ramData(38) xor ramData(37) xor ramData(33) xor ramData(29) xor ramData(27) xor ramData(21) xor ramData(20) xor ramData(19) xor ramData(17) xor ramData(14) xor ramData(12) xor ramData(11) xor ramData(10) xor ramData(9) xor ramData(7) xor ramData(6) xor ramData(4) xor ramData(3) xor ramData(2) xor ramData(1) xor ramData(0);
       DATA(1) <= ramData(63) xor ramData(62) xor ramData(59) xor ramData(58) xor ramData(53) xor ramData(52) xor ramData(50) xor ramData(49) xor ramData(46) xor ramData(44) xor ramData(39) xor ramData(38) xor ramData(34) xor ramData(30) xor ramData(28) xor ramData(22) xor ramData(21) xor ramData(20) xor ramData(18) xor ramData(15) xor ramData(13) xor ramData(12) xor ramData(11) xor ramData(10) xor ramData(8) xor ramData(7) xor ramData(5) xor ramData(4) xor ramData(3) xor ramData(2) xor ramData(1);
       DATA(2) <= ramData(63) xor ramData(60) xor ramData(59) xor ramData(54) xor ramData(53) xor ramData(51) xor ramData(50) xor ramData(47) xor ramData(45) xor ramData(40) xor ramData(39) xor ramData(35) xor ramData(31) xor ramData(29) xor ramData(23) xor ramData(22) xor ramData(21) xor ramData(19) xor ramData(16) xor ramData(14) xor ramData(13) xor ramData(12) xor ramData(11) xor ramData(9) xor ramData(8) xor ramData(6) xor ramData(5) xor ramData(4) xor ramData(3) xor ramData(2);
       DATA(3) <= ramData(63) xor ramData(62) xor ramData(60) xor ramData(58) xor ramData(57) xor ramData(55) xor ramData(54) xor ramData(49) xor ramData(46) xor ramData(45) xor ramData(43) xor ramData(41) xor ramData(40) xor ramData(38) xor ramData(37) xor ramData(36) xor ramData(33) xor ramData(32) xor ramData(30) xor ramData(29) xor ramData(27) xor ramData(24) xor ramData(23) xor ramData(22) xor ramData(21) xor ramData(19) xor ramData(15) xor ramData(13) xor ramData(11) xor ramData(5) xor ramData(2) xor ramData(1) xor ramData(0);
       DATA(4) <= ramData(62) xor ramData(59) xor ramData(57) xor ramData(56) xor ramData(55) xor ramData(52) xor ramData(51) xor ramData(50) xor ramData(49) xor ramData(48) xor ramData(47) xor ramData(46) xor ramData(45) xor ramData(44) xor ramData(43) xor ramData(42) xor ramData(41) xor ramData(39) xor ramData(34) xor ramData(31) xor ramData(30) xor ramData(29) xor ramData(28) xor ramData(27) xor ramData(25) xor ramData(24) xor ramData(23) xor ramData(22) xor ramData(21) xor ramData(19) xor ramData(17) xor ramData(16) xor ramData(11) xor ramData(10) xor ramData(9) xor ramData(7) xor ramData(4) xor ramData(0);
       DATA(5) <= ramData(63) xor ramData(60) xor ramData(58) xor ramData(57) xor ramData(56) xor ramData(53) xor ramData(52) xor ramData(51) xor ramData(50) xor ramData(49) xor ramData(48) xor ramData(47) xor ramData(46) xor ramData(45) xor ramData(44) xor ramData(43) xor ramData(42) xor ramData(40) xor ramData(35) xor ramData(32) xor ramData(31) xor ramData(30) xor ramData(29) xor ramData(28) xor ramData(26) xor ramData(25) xor ramData(24) xor ramData(23) xor ramData(22) xor ramData(20) xor ramData(18) xor ramData(17) xor ramData(12) xor ramData(11) xor ramData(10) xor ramData(8) xor ramData(5) xor ramData(1);
       DATA(6) <= ramData(61) xor ramData(59) xor ramData(58) xor ramData(57) xor ramData(54) xor ramData(53) xor ramData(52) xor ramData(51) xor ramData(50) xor ramData(49) xor ramData(48) xor ramData(47) xor ramData(46) xor ramData(45) xor ramData(44) xor ramData(43) xor ramData(41) xor ramData(36) xor ramData(33) xor ramData(32) xor ramData(31) xor ramData(30) xor ramData(29) xor ramData(27) xor ramData(26) xor ramData(25) xor ramData(24) xor ramData(23) xor ramData(21) xor ramData(19) xor ramData(18) xor ramData(13) xor ramData(12) xor ramData(11) xor ramData(9) xor ramData(6) xor ramData(2);
       DATA(7) <= ramData(63) xor ramData(61) xor ramData(60) xor ramData(59) xor ramData(57) xor ramData(55) xor ramData(54) xor ramData(53) xor ramData(50) xor ramData(47) xor ramData(46) xor ramData(44) xor ramData(43) xor ramData(42) xor ramData(38) xor ramData(34) xor ramData(32) xor ramData(31) xor ramData(30) xor ramData(29) xor ramData(28) xor ramData(26) xor ramData(25) xor ramData(24) xor ramData(22) xor ramData(21) xor ramData(17) xor ramData(13) xor ramData(11) xor ramData(9) xor ramData(6) xor ramData(4) xor ramData(2) xor ramData(1) xor ramData(0);
       DATA(8) <= ramData(63) xor ramData(60) xor ramData(57) xor ramData(56) xor ramData(55) xor ramData(54) xor ramData(52) xor ramData(49) xor ramData(47) xor ramData(44) xor ramData(39) xor ramData(38) xor ramData(37) xor ramData(35) xor ramData(32) xor ramData(31) xor ramData(30) xor ramData(26) xor ramData(25) xor ramData(23) xor ramData(22) xor ramData(21) xor ramData(20) xor ramData(19) xor ramData(18) xor ramData(17) xor ramData(11) xor ramData(9) xor ramData(6) xor ramData(5) xor ramData(4) xor ramData(0);
       DATA(9) <= ramData(61) xor ramData(58) xor ramData(57) xor ramData(56) xor ramData(55) xor ramData(53) xor ramData(50) xor ramData(48) xor ramData(45) xor ramData(40) xor ramData(39) xor ramData(38) xor ramData(36) xor ramData(33) xor ramData(32) xor ramData(31) xor ramData(27) xor ramData(26) xor ramData(24) xor ramData(23) xor ramData(22) xor ramData(21) xor ramData(20) xor ramData(19) xor ramData(18) xor ramData(12) xor ramData(10) xor ramData(7) xor ramData(6) xor ramData(5) xor ramData(1);
       DATA(10) <= ramData(63) xor ramData(61) xor ramData(59) xor ramData(56) xor ramData(54) xor ramData(52) xor ramData(48) xor ramData(46) xor ramData(45) xor ramData(43) xor ramData(41) xor ramData(40) xor ramData(39) xor ramData(38) xor ramData(34) xor ramData(32) xor ramData(29) xor ramData(28) xor ramData(25) xor ramData(24) xor ramData(23) xor ramData(22) xor ramData(17) xor ramData(14) xor ramData(13) xor ramData(12) xor ramData(10) xor ramData(9) xor ramData(8) xor ramData(4) xor ramData(3) xor ramData(1) xor ramData(0);
       DATA(11) <= ramData(62) xor ramData(60) xor ramData(57) xor ramData(55) xor ramData(53) xor ramData(49) xor ramData(47) xor ramData(46) xor ramData(44) xor ramData(42) xor ramData(41) xor ramData(40) xor ramData(39) xor ramData(35) xor ramData(33) xor ramData(30) xor ramData(29) xor ramData(26) xor ramData(25) xor ramData(24) xor ramData(23) xor ramData(18) xor ramData(15) xor ramData(14) xor ramData(13) xor ramData(11) xor ramData(10) xor ramData(9) xor ramData(5) xor ramData(4) xor ramData(2) xor ramData(1);
       DATA(12) <= ramData(63) xor ramData(61) xor ramData(58) xor ramData(56) xor ramData(54) xor ramData(50) xor ramData(48) xor ramData(47) xor ramData(45) xor ramData(43) xor ramData(42) xor ramData(41) xor ramData(40) xor ramData(36) xor ramData(34) xor ramData(31) xor ramData(30) xor ramData(27) xor ramData(26) xor ramData(25) xor ramData(24) xor ramData(19) xor ramData(16) xor ramData(15) xor ramData(14) xor ramData(12) xor ramData(11) xor ramData(10) xor ramData(6) xor ramData(5) xor ramData(3) xor ramData(2);
       DATA(13) <= ramData(62) xor ramData(59) xor ramData(57) xor ramData(55) xor ramData(51) xor ramData(49) xor ramData(48) xor ramData(46) xor ramData(44) xor ramData(43) xor ramData(42) xor ramData(41) xor ramData(37) xor ramData(35) xor ramData(32) xor ramData(31) xor ramData(28) xor ramData(27) xor ramData(26) xor ramData(25) xor ramData(20) xor ramData(17) xor ramData(16) xor ramData(15) xor ramData(13) xor ramData(12) xor ramData(11) xor ramData(7) xor ramData(6) xor ramData(4) xor ramData(3);
       DATA(14) <= ramData(62) xor ramData(61) xor ramData(60) xor ramData(57) xor ramData(56) xor ramData(51) xor ramData(50) xor ramData(48) xor ramData(47) xor ramData(44) xor ramData(42) xor ramData(37) xor ramData(36) xor ramData(32) xor ramData(28) xor ramData(26) xor ramData(20) xor ramData(19) xor ramData(18) xor ramData(16) xor ramData(13) xor ramData(11) xor ramData(10) xor ramData(9) xor ramData(8) xor ramData(6) xor ramData(5) xor ramData(3) xor ramData(2) xor ramData(1) xor ramData(0);
end process;

end Behavioral;

