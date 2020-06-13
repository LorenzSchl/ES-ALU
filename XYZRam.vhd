library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.vcomponents.all;

entity xyzram is
  generic(
    ADDRESSWIDTH : positive := 9;
    DATAWIDTH    : positive := 8
  );
  
  
 --	= x-
  --	-       x-
--		-	          x-
  
  port(
    -- Port B clock input
    CLKA, CLKB : in std_logic;
    -- Port B 8-bit data input
    DIA, DIB : in  std_logic_vector(DATAWIDTH-1 downto 0);
    -- Port A/B 8-bit data output
    DOA, DOB : out std_logic_vector(DATAWIDTH-1 downto 0);
    -- Port B 9-bit address input
    ADDRA, ADDRB : in  std_logic_vector(ADDRESSWIDTH-1 downto 0);
    ENA, ENB : in std_logic;  -- Port B RAM enable input
    RSTA, RSTB : in std_logic;  -- Port B Synchronous reset input
    WEA, WEB : in std_logic     -- Port B RAM write enable input
  );
end xyzram;

architecture Behavioral of xyzram is

begin
   RAMB4_S8_S8_inst : RAMB4_S8_S8
   generic map (                                                                                             
      INIT_FF => X"FFFFFFFFF3456FFFFFFFFFFFFFFFFFFFFFFFF_F4F5_F3FF_F1FF_FFFF_FBFB_F1F2_F5F2",              
      INIT_F1 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_F2 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_F3 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_F4 => X"FFFFFFFFFFFFF25678FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_F5 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_F6 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_F7 => X"FFFFFFFFFFFFFFFFFFFFF467AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
                                                                                                          
      INIT_F8 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_F9 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_FA => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_FB => X"FFFFFFFFFFFFFFFFFFFFFFFFF99999FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_FC => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_FD => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_FE => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11111FFFFFFFFFFFFFFFFFFFFFFF",                     
      INIT_FF => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000") --1000_0000_0000_0000 

   port map (
      DOA => DOA,     -- Port A 8-bit data output
      DOB => DOB,     -- Port B 8-bit data output
      ADDRA => ADDRA, -- Port A 9-bit address input
      ADDRB => ADDRB, -- Port B 9-bit address input
      CLKA => CLKA,   -- Port A clock input
      CLKB => CLKB,   -- Port B clock input
      DIA => DIA,     -- Port A 8-bit data input
      DIB => DIB,     -- Port B 8-bit data input
      ENA => ENA,     -- Port A RAM enable input
      ENB => ENB,     -- Port B RAM enable input
      RSTA => RSTA,   -- Port A Synchronous reset input
      RSTB => RSTB,   -- Port B Synchronous reset input
      WEA => WEA,     -- Port A RAM write enable input
      WEB => WEB      -- Port B RAM write enable input
   );

end Behavioral;
