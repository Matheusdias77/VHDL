LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decod IS 
PORT (
	numero : IN integer RANGE 0 TO 9;
	seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);
END decod;

ARCHITECTURE cov OF decod IS
BEGIN 
	PROCESS(numero)
	BEGIN 
		CASE numero IS
			WHEN 0 => seg <= "0000001"; 
			WHEN 1 => seg <= "1001111"; 
			WHEN 2 => seg <= "0010010"; 
			WHEN 3 => seg <= "0000110"; 
			WHEN 4 => seg <= "1001100";
			WHEN 5 => seg <= "0100100"; 
			WHEN 6 => seg <= "0100000"; 
			WHEN 7 => seg <= "0001111"; 
			WHEN 8 => seg <= "0000000";
			WHEN 9 => seg <= "0000100"; 
			WHEN OTHERS => seg <= "1111111"; 
		END CASE;
	END PROCESS;
END cov;
