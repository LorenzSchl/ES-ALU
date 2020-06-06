--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:29:48 06/05/2020
-- Design Name:   
-- Module Name:   /home/ise/ES-ALU/ALUV1S_TB.vhd
-- Project Name:  test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALUV1S
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALUV1S_TB IS
END ALUV1S_TB;
 
ARCHITECTURE behavior OF ALUV1S_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALUV1S
    PORT(
         CLK : IN  std_logic;
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         Cmd : IN  std_logic_vector(3 downto 0);
         FLow : OUT  std_logic_vector(7 downto 0);
         FHigh : OUT  std_logic_vector(7 downto 0);
         Cout : OUT  std_logic;
         Equal : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal Cmd : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal LowOut : std_logic_vector(7 downto 0);
   signal HighOut : std_logic_vector(7 downto 0);
   signal COut : std_logic;
   signal EqualOut : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
	
	--Functions
FUNCTION char2std_logic (ch: IN CHARACTER) RETURN STD_LOGIC IS
BEGIN
  CASE ch IS
    WHEN 'U' | 'u' => RETURN 'U';
    WHEN 'X' | 'x' => RETURN 'X';
    WHEN '0' => RETURN '0';
    WHEN '1'=> RETURN '1';
    WHEN 'Z' | 'z' => RETURN 'Z';
    WHEN 'W' | 'w' => RETURN 'W';
    WHEN 'L' | 'l' => RETURN 'L';
    WHEN 'H' | 'h' => RETURN 'H';
    WHEN '-' => RETURN '-';
    WHEN OTHERS =>
  ASSERT FALSE
    REPORT "Illegal Character found" & ch
    SEVERITY ERROR;
  RETURN 'U';
  END CASE;
END;

FUNCTION string2std_logic (s: STRING) RETURN STD_LOGIC_VECTOR IS
VARIABLE vector: STD_LOGIC_VECTOR(s'LEFT - 1 DOWNTO 0);
BEGIN
  FOR i IN s'RANGE LOOP
    vector(i-1) := char2std_logic(s(i));
  END LOOP;
  RETURN vector;
END;

-- converts std_logic into a character
FUNCTION std_logic2char(sl: std_logic) return character is
    variable c: character;
    begin
      case sl is
         when 'U' => c:= 'U';
         when 'X' => c:= 'X';
         when '0' => c:= '0';
         when '1' => c:= '1';
         when 'Z' => c:= 'Z';
         when 'W' => c:= 'W';
         when 'L' => c:= 'L';
         when 'H' => c:= 'H';
         when '-' => c:= '-';
      end case;
    return c;
   end std_logic2char;
	
FUNCTION std_logic2string(slv: std_logic_vector) return string is
  variable result : string (1 to slv'length);
  variable r : integer;
begin
  r := 1;
  for i in slv'range loop
    result(r) := std_logic2char(slv(i));
    r := r + 1;
  end loop;
  return result;
end std_logic2string;

shared variable expected : STRING(18 DOWNTO 1);

-- Testbench
BEGIN
	-- Taktgenerator
	clk <= NOT clk AFTER 50 ns;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALUV1S PORT MAP (
          CLK => CLK,
          A => A,
          B => B,
          Cmd => Cmd,
          FLow => LowOut,
          FHigh => HighOut,
          Cout => COut,
          Equal => EqualOut
        );

STIMULI: PROCESS(clk)
  FILE testpattern: TEXT OPEN READ_MODE IS "stimuli.txt";
  VARIABLE zeile: LINE;
  VARIABLE leerzeichen: CHARACTER;
  VARIABLE var1: STRING(8 DOWNTO 1);
  VARIABLE var2: STRING(8 DOWNTO 1);
BEGIN
  IF(clk'EVENT AND clk = '1') THEN
    IF(NOT endfile(testpattern)) THEN
      readline(testpattern, zeile);
      read(zeile, var1);
      in1 <= string2std_logic(var1);
-- Überspringen des Leerzeichens
      read(zeile, leerzeichen);
      read(zeile, var2);
      in2 <= string2std_logic(var2);
    ELSE
      in1 <= (OTHERS => '0');
      in2 <= (OTHERS => '0');
    END IF;
  END IF;
END PROCESS STIMULI;
 
RESPONSE: PROCESS(clk)
  FILE vergleichspattern: TEXT OPEN READ_MODE IS "expected.txt";
  VARIABLE zeile: LINE;
  VARIABLE var: STRING(18 DOWNTO 1);
BEGIN
  IF(clk'EVENT AND clk = '1') THEN
    IF(NOW > 100 ns) THEN
      IF(NOT endfile(vergleichspattern)) THEN
        readline(vergleichspattern, zeile);
        read(zeile, var);
		  expected := var;
        ASSERT string2std_logic(var) = out1
          REPORT "Vergleich fehlerhaft!" & "  Erwartungswert: " & var & "  Ergebnis: " & std_logic2string(out1)
          SEVERITY WARNING;
		ELSE expected := (others => 'X');
      END IF;
    END IF;
  END IF;
  --out2 <= in1 * in2;
END PROCESS RESPONSE;

MONITOR: PROCESS(clk)
  FILE protokoll: TEXT OPEN WRITE_MODE IS "monitor.txt";
  VARIABLE zeile: LINE;
  VARIABLE leerzeichen: CHARACTER := ' ';
  VARIABLE var1: STRING(8 DOWNTO 1);
  VARIABLE var2: STRING(8 DOWNTO 1);
  VARIABLE var3: STRING(18 DOWNTO 1);
  VARIABLE simulationszeit: TIME;
BEGIN
  IF(NOW > 100 ns) THEN
    IF(clk'EVENT AND clk = '1') THEN
      var1 := std_logic2string(in1);
		var2 := std_logic2string(in2);
		var3 := std_logic2string(out1);
      simulationszeit := NOW;
      write(zeile, "in1: " & var1);
      write(zeile, leerzeichen);
		write(zeile, "in2: " & var2);
      write(zeile, leerzeichen);
		write(zeile, "Expected: " & expected);
      write(zeile, leerzeichen);
		write(zeile, "out1: " & var3);
      write(zeile, leerzeichen);
      write(zeile, "Time: ");
		write(zeile, simulationszeit);
      writeline(protokoll, zeile);
    END IF;
  END IF;	 
END PROCESS MONITOR;

END;
