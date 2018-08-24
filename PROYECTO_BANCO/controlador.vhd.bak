LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY controlador IS
	PORT(clock,reset,start,OR_10,menor_6,entre_6_y_7,Mayor_Igual_a_8: IN STD_LOGIC;
		 enable_Registro,enable_clasificador,Excelente,Bueno,Regular : OUT STD_LOGIC;
		 Estados:	OUT STD_LOGIC_VECTOR(2 downto 0));
END controlador;

ARCHITECTURE sol OF controlador IS
Type estado is (Ta,Tb,Tc,Td,Te,Tf,Tg,Th);
SIGNAL y:estado;
BEGIN
	PROCESS(clock,reset)
	BEGIN
		if reset='0' then y<=Ta;
  		elsif (clock'event and clock='1') then
			case y is
				when Ta=> 	if start='1' then y<=Tb;
								else y<=Ta;
								end if;
				when Tb=>	if start='1' then y<=Tb;
								else y<=Tc;
								end if;
				when Tc=>	if OR_10='1' then y<=Td;
								else y<=Tc;
								end if;
				when Td=>	if OR_10='1' then y<=Td;
								else y<=Te;
								end if;
				when Te=>	if menor_6='1' then y<=Tf;
								elsif Entre_6_y_7='1' then y<=Tg;
								elsif Mayor_Igual_a_8='1' then y<=Th;
								else y<=Te; end if;
				when Tf=>	y<=Tc;
				when Tg=>	y<=Tc;
				when Th=>	y<=Tc;
			end case;
		end if;
	END PROCESS;
	
PROCESS(y)
	BEGIN
		enable_Registro<='0';enable_Clasificador<='0';Excelente<='0';Bueno<='0';Regular<='0';
			case y is
				when Ta=>	Estados<="000";
				when Tb=>	Estados<="001";
				when Tc=>	Estados<="010";
				when Td=>	Estados<="011"; if OR_10='1' then enable_Registro<='1';end if;
				when Te=>	Estados<="100"; enable_Clasificador<='1'; 
				when Tf=>	Estados<="101"; Regular<='1';
				when Tg=>	Estados<="110"; Bueno<='1';
				when Th=>	Estados<="111"; Excelente<='1';
			end case;
	END PROCESS;
END sol;

