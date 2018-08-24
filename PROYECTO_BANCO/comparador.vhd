library ieee;
use ieee.std_logic_1164.all;

Entity comparador is
	generic (n:INTEGER:=10); 
	Port(	w1: in std_logic_vector(n downto 0);
			w2: in std_logic_vector(n downto 0);
			menor,igual, mayor: out std_logic);
end comparador;

Architecture sol of comparador is
Begin
	mayor<='1' when w1>w2 else '0';
	menor<='1' when w1<w2 else '0';
	igual<='1' when w1=w2 else '0';
end sol;