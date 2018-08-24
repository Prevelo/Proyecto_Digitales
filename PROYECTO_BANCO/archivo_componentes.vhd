library ieee;
use ieee.std_logic_1164.all;

package archivo_componentes is

component encoder_Dec_BCD is
	Port ( Ent: in STD_LOGIC_VECTOR(4 downto 0);
		Salida : OUT STD_LOGIC_VECTOR(9 downto 0));
end component;

component controlador IS
	PORT(clock,reset_n,start_n,finDeSemana_n,entreSemana_n,inEstudiante_n,inTerceraEdad_n,
		inUsuario_n,OR_teclado,nEstudiantesVal,nTerceraEdadVal,nUsuariosVal,
		Vin_MI_Vpg,pagar_n,error3s,ingreso5s: IN STD_LOGIC;
		 enE,enT,enU,enTemp,ledError,ledIngreso,ledConteo,ingresoMoneda,resetP,resetT : OUT STD_LOGIC);
end component;

component CLOCK_DIV IS
	PORT(  CLOCK_10MHz     :IN   STD_LOGIC;
	CLOCK_1MHz     :OUT  STD_LOGIC;
	CLOCK_100KHz   :OUT  STD_LOGIC;
	CLOCK_10KHz    :OUT  STD_LOGIC;
	CLOCK_1KHz     :OUT  STD_LOGIC;
	CLOCK_100Hz    :OUT  STD_LOGIC;
	CLOCK_10Hz     :OUT  STD_LOGIC;
	CLOCK_1Hz :OUT  STD_LOGIC);
end component;

component comparador is
	generic (n:INTEGER:=10); 
	Port(	w1: in std_logic_vector(n downto 0);
			w2: in std_logic_vector(n downto 0);
			menor,igual, mayor: out std_logic);
end component;

component mux2a1 is

PORT(	A: IN std_logic;
		B: IN std_logic;
		S: IN std_logic;
		Q: OUT std_logic);
end component;

component sumador IS 
	PORT (a : IN std_logic_vector(9 DOWNTO 0); 
         b : IN std_logic_vector(9 DOWNTO 0);
			c : IN std_logic_vector(9 DOWNTO 0);  
         salida : OUT std_logic_vector(9 DOWNTO 0));
end component;

component multiplicador IS
	PORT (a : IN std_logic_vector(4 DOWNTO 0); 
			b : IN std_logic_vector(4 DOWNTO 0); 
         salida : OUT std_logic_vector(9 DOWNTO 0));
end component;
	
component decoder_bcd_a_7segmentos is
   port( BCD: in std_logic_vector(3 downto 0);
			SEG7: out std_logic_vector(6 downto 0));
end component;

component contador_bin is
   port( Enable: in std_logic;
			Clock: in std_logic;
			Reset: in std_logic;
			Output: out std_logic_vector(3 downto 0));
end component;

component ANTIREBOTE IS
	PORT(PB_N, CLOCK_100Hz 	: IN	STD_LOGIC;
		 PB_SIN_REBOTE		: OUT	STD_LOGIC);
end component;

component RELOJ IS
	PORT(PB_SIN_REBOTE, CLOCK: IN STD_LOGIC;
			UN_PULSO: OUT STD_LOGIC);
end component;

component acumulador IS
	PORT(reset, suma : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(9 downto 0);
		 clock : IN STD_LOGIC;
		 Q : BUFFER STD_LOGIC_VECTOR (9 downto 0));
end component;
	
end archivo_componentes;