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
USE STD.TEXTIO.ALL;
USE ieee.numeric_std.ALL;
use IEEE.std_logic_unsigned.all;
 
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

shared variable expectedFlow : STRING(8 DOWNTO 1);
shared variable expectedFHigh : STRING(8 DOWNTO 1);
shared variable expectedCOut : STRING(1 DOWNTO 1);
shared variable expectedEqual : STRING(1 DOWNTO 1);

-- Testbench
BEGIN
	-- Taktgenerator
	CLK <= NOT CLK AFTER 50 ns;
 
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

STIMULI: PROCESS(CLK)
  FILE testpattern: TEXT OPEN READ_MODE IS "stimuli.txt";
  VARIABLE zeile: LINE;
  VARIABLE leerzeichen: CHARACTER;
  VARIABLE var1: STRING(8 DOWNTO 1);
  VARIABLE var2: STRING(8 DOWNTO 1);
  VARIABLE cmdVar: STRING(4 DOWNTO 1);
BEGIN
  IF(CLK'EVENT AND CLK = '1') THEN
    IF(NOT endfile(testpattern)) THEN
      readline(testpattern, zeile);
      read(zeile, var1);
      A <= string2std_logic(var1);
		
		-- Überspringen des Leerzeichens
      read(zeile, leerzeichen);
      read(zeile, var2);
      B <= string2std_logic(var2);
		
		-- Überspringen des Leerzeichens
		read(zeile, leerzeichen);
		read(zeile, cmdVar);
		Cmd <= string2std_logic(cmdVar);
    ELSE
      A <= (OTHERS => '0');
      B <= (OTHERS => '0');
		Cmd <= (OTHERS => '0');
    END IF;
  END IF;
END PROCESS STIMULI;
 
RESPONSE: PROCESS(CLK)
  FILE vergleichspattern: TEXT OPEN READ_MODE IS "expected.txt";
  VARIABLE zeile: LINE;
  VARIABLE leerzeichen: CHARACTER;
  VARIABLE lowVar: STRING(8 DOWNTO 1);
  VARIABLE highVar: STRING(8 DOWNTO 1);
  VARIABLE COutVar: STRING(1 DOWNTO 1);
  VARIABLE EqualsVar: STRING(1 DOWNTO 1);
BEGIN
  IF(CLK'EVENT AND CLK = '1') THEN
    IF(NOW > 100 ns) THEN
      IF(NOT endfile(vergleichspattern)) THEN
        readline(vergleichspattern, zeile);
        -- Assert for FLow
		  read(zeile, lowVar);
		  expectedFlow := lowVar;
        ASSERT string2std_logic(lowVar) = LowOut
          REPORT "Vergleich fehlerhaft!" & "  Erwartungswert: " & lowVar & "  Ergebnis: " & std_logic2string(LowOut)
          SEVERITY WARNING;
		  
		  -- Assert for FHigh
		  read(zeile, leerzeichen); --Deleting the LEERZEICHEN!
		  read(zeile, highVar);
		  expectedFHigh := highVar;
        ASSERT string2std_logic(highVar) = HighOut
          REPORT "Vergleich fehlerhaft!" & "  Erwartungswert: " & highVar & "  Ergebnis: " & std_logic2string(HighOut)
          SEVERITY WARNING;
		  -- Assert for COut
		  read(zeile, leerzeichen); --Deleting the LEERZEICHEN!
		  read(zeile, COutVar);
		  expectedCOut := COutVar;
        ASSERT char2std_logic(COutVar(1)) = COut
          REPORT "Vergleich fehlerhaft!" & "  Erwartungswert: " & COutVar & "  Ergebnis: " & std_logic2char(COut)
          SEVERITY WARNING;
		  -- Assert for Equal
		  read(zeile, leerzeichen); --Deleting the LEERZEICHEN!
		  read(zeile, EqualsVar);
		  expectedEqual := EqualsVar;
        ASSERT char2std_logic(EqualsVar(1)) = EqualOut
          REPORT "Vergleich fehlerhaft!" & "  Erwartungswert: " & EqualsVar & "  Ergebnis: " & std_logic2char(EqualOut)
          SEVERITY WARNING;
		ELSE 
			expectedFlow := (others => 'X');
			expectedFHigh := (others => 'X');
			expectedCOut := (others => 'X');
			expectedEqual := (others => 'X');
      END IF;
    END IF;
  END IF;
  --out2 <= in1 * in2;
END PROCESS RESPONSE;

MONITOR: PROCESS(CLK)
  FILE protokoll: TEXT OPEN WRITE_MODE IS "monitor.txt";
  VARIABLE zeile: LINE;
  VARIABLE leerzeichen: CHARACTER := ' ';
  VARIABLE AVar: STRING(8 DOWNTO 1);
  VARIABLE BVar: STRING(8 DOWNTO 1);
  VARIABLE CmdVar: STRING(4 DOWNTO 1);
  VARIABLE FLowVar: STRING(8 DOWNTO 1);
  VARIABLE FHighVar: STRING(8 DOWNTO 1);
  VARIABLE COutVar: STRING(1 DOWNTO 1);
  VARIABLE EqualsVar: STRING(1 DOWNTO 1);

  VARIABLE simulationszeit: TIME;
BEGIN
  IF(NOW > 100 ns) THEN
    IF(CLK'EVENT AND CLK = '1') THEN
      AVar := std_logic2string(A);
		BVar := std_logic2string(B);
		CmdVar := std_logic2string(Cmd);
      simulationszeit := NOW;
		
		--Inputs
      write(zeile, "A: " & AVar);
      write(zeile, leerzeichen);
		write(zeile, "B: " & BVar);
      write(zeile, leerzeichen);
		write(zeile, "Cmd: " & CmdVar);
      write(zeile, leerzeichen);
		
		--Expected Values
		write(zeile, "Exp-FLow: " & expectedFlow);
      write(zeile, leerzeichen);
		write(zeile, "Exp-FHigh: " & expectedFHigh);
      write(zeile, leerzeichen);
		write(zeile, "Exp-COut" & expectedCOut);
      write(zeile, leerzeichen);
		write(zeile, "Exp-Equal: " & expectedEqual);
      write(zeile, leerzeichen);
		
		--Actual Values
		write(zeile, "FLow: " & FLowVar);
      write(zeile, leerzeichen);
		write(zeile, "FHigh: " & FHighVar);
      write(zeile, leerzeichen);
		write(zeile, "COut: " & COutVar);
      write(zeile, leerzeichen);
		write(zeile, "Equals: " & EqualsVar);
      write(zeile, leerzeichen);

		
		
      write(zeile, "Time: ");
		write(zeile, simulationszeit);
      writeline(protokoll, zeile);
    END IF;
  END IF;	 
END PROCESS MONITOR;

END;
