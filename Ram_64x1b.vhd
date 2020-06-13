library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.vcomponents.all;

entity RAM_64x1 is

  port(
    WCLK   : in std_logic;                    -- clock input
    D    : in  std_logic;                     -- 8-bit data input
    O    : out std_logic;                     -- 8-bit data output
    ADDR  : in std_logic_vector(5 downto 0);  -- 9-bit address input
    EN    : in std_logic;                     -- RAM enable input
    RST   : in std_logic;                     -- Synchronous reset input
    WE    : in std_logic                      -- RAM write enable input	 
  );
end RAM_64x1;

architecture Behavioral of RAM_64x1 is

begin
    RRAM64X1S_inst : RAM64X1S
	 --Virtex-4/5,Spartan-3/3E/3A--
    generic map(
	 --INIT=>X"11050070F0A08000")
	 INIT=>X"FFFFFFFFFFFFFFFF")
    port map(
	 O => O,        -- 1-bitdataoutput
    A0 => ADDR(0), -- Address[0] input bit
    A1 => ADDR(1), -- Address[1] input bit
    A2 => ADDR(2), -- Address[2] input bit
    A3 => ADDR(3), -- Address[3] input bit
    A4 => ADDR(4), -- Address[4] input bit
    A5 => ADDR(5), -- Address[5] input bit
    D => D,        -- 1-bitdatainput
    WCLK => WCLK,  -- Write clock input
    WE => WE       -- Write enable input
    );

end Behavioral;