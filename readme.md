# Projektaufgabe 3 : Applikationsspezifische ALU

Ihre Aufgabe ist es, eine applikationsspezifische arithmetisch-logische Einheit (ALU) zu realisieren und zu spezifizieren, die als Berechnungseinheit in einer kleinen Motorsteuerung eingesetzt werden soll. 
Die Wortbreite der ALU beträgt 8 bit; damit sind die Eingangsoperatoren (A, B) festgelegt. 
Am Ausgang ist eine 16-bit Wortbreite notwendig, da die ALU auch einen Multiplikationsbefehl besitzt. 
Zusätzlich besitzt die Alu noch ein Carry-Flag (Überlauf der unteren 8-bit des Ergebnisses) und ein Equal-Flag (A=B: Equal-Flag = 1). 

Folgender vhd-Dateirumpf ist zusätzlich gegeben:

```vhdl

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ASALU is
  port (
    CLK : in std_logic;
    A, B : in std_logic_vector(7 downto 0);
    Cmd : in std_logic_vector(3 downto 0);
    FLow : out std_logic_vector(7 downto 0);
    FHigh : out std_logic_vector(7 downto 0);
    Cout : out std_logic;
    Equal : out std_logic);
  end;
  
```

Im Einzelnen sind folgende Befehle festgelegt:

Tabellen 1: Befehlstabelle
| Operation     | Command |
|---------------|---------|
| F = A + B     | 0000    |
| F = A - B     | 0001    |
| F = B - A     | 0010    |
| F = A         | 0011    |
| F = B         | 0100    |
| F = -A        | 0101    |
| F = -B        | 0110    |
| F = sll(A)    | 0111    |
| F = slr(A)    | 1000    |
| F = rll(A)    | 1001    |
| F = rlr(A)    | 1010    |
| F = A * B     | 1011    |
| F = NAND(A,B) | 1100    |
| F = XOR(A,B)  | 1101    |
| F = CRC_MEM   | 1110    |
| RESERVED      | 1111    |


Die in den folgenden Punkten aufgeführten Einzelaspekte sind im Rahmen unterschiedlicher Architekturentwürfe im Rahmen von VHDL zu dokumentieren. 
Denken Sie an die Verifikation und die entsprechenden Testbenches (Benutzen Sie -wenn möglich- für alle Architekturendie gleichen selbstverifizierenden Testbenches)!
Alle Aufgaben sind vor dem Hintergrund der jeweiligen Schwerpunkte für die einzelnen Gruppen umzusetzen (siehe Tabelle 2)

* Entwerfen Sie die ALU zuerst rein funktional mit Hilfe einer Verhaltensbeschreibung(architecture 1, nur TopLevel-Blockschaltbild).

* Strukturieren Sie Ihren Entwurf und realisieren Sie nun eine strukturierte ALU (architecture 2, hierarchischer Systemaufbau).

* Geben Sie zu jeder Entwurfsvariante kommentiert die wichtigen Parameter an, die Sie vom Werkzeug ISE erhalten.

Abgabe spätestens:14.06.2020, Diskussion (Terminfestlegung erfolgt noch):16.06.

Tabelle 2: Gruppenschwerpunkte

|Gruppennummer |Device |Entwurfsziel|
|--------------|-------|------------|
|Friesen, Macke, Schlüter| Virtex4| „Maximale“ Geschwindigkeit|
|Beckmann, Ehlers, Köhler| Virtex4| „Maximale“ Geschwindigkeit|
|Ochsner, Salvage, Stuke| Virtex4| „Minimaler“ Ressourceneinsatz|
|Ertingshausen, Lee, Schottelius| Virtex4| „Minimaler“ Ressourceneinsatz|

## TODOs: 
* Mehr Testvektoren (generieren)
* Fehlende Funktionen implementieren	
* CRC_MEM
* Constanten aus den Shifts/Rotates entfernen?
* Verschiedene Berechnungen in eigene Komponenten auslagern
* Gibt es ein schnelleren Addierer?
* Gibt es einen schnelleren Multiplizierer?
* Negation überdenken?
* Wie gehen wir mit Negativen Zahlen um?
* Als Eingaben verboten - Wird nur im zweier Komplement ausgegeben
* Als Eingaben erlaubt - Wie werden die unterschieden und anders verarbeitet?
	
	
* Welche Parameter sollen wir in Aufgabe 3 angeben?