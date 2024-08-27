LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY relogio IS 
	GENERIC (clockfreq : INTEGER := 50e6);
	    PORT (
        Sclock : IN std_logic;     
        nRst : IN std_logic;     
        segund_u  : OUT std_logic_vector(6 DOWNTO 0); 
        segund_d  : OUT std_logic_vector(6 DOWNTO 0); 
        min_u  : OUT std_logic_vector(6 DOWNTO 0); 
        min_d  : OUT std_logic_vector(6 DOWNTO 0);
        hora_u : OUT std_logic_vector(6 DOWNTO 0);
        hora_d : OUT std_logic_vector(6 DOWNTO 0) 
    );
END relogio;

ARCHITECTURE comport OF relogio IS

    SIGNAL s, m, h : integer RANGE 0 TO 59;   
    SIGNAL ticks   : integer RANGE 0 TO  clockFreq;  

    SIGNAL num_seg_u : integer RANGE 0 TO  9; 
    SIGNAL num_seg_d : integer RANGE 0 TO  5; 
    SIGNAL num_min_u : integer RANGE 0 TO  9; 
    SIGNAL num_min_d : integer RANGE 0 TO  5; 
    SIGNAL num_hora_u : integer RANGE 0 TO  9; 
    SIGNAL num_hora_d : integer RANGE 0 TO  2; 

BEGIN
    PROCESS(Sclock, nRst)
    BEGIN
        IF nRst = '0' THEN
            ticks <= 0;
            s <= 0;
            m <= 0;
            h <= 0;
        ELSIF Sclock'event AND Sclock = '1' THEN
            IF ticks = clockFreq - 1 THEN  
                ticks <= 0;
                IF s = 59 THEN             
                    s <= 0;
                    IF m = 59 THEN       
                        m <= 0;
                        IF h = 23 THEN      
                            h <= 0;
                        ELSE
                            h <= h + 1;
                        END IF;
                    ELSE
                        m <= m + 1;
                    END IF;
                ELSE
                    s <= s + 1;
                END IF;
            ELSE 
                ticks <= ticks + 1;
            END IF;
        END IF;
    END PROCESS;

    num_seg_u <= s mod 10;  
    num_seg_d <= s / 10;    
    num_min_u <= m mod 10;  
    num_min_d <= m / 10;    
    num_hora_u <= h mod 10; 
    num_hora_d <= h / 10;   

    DecodificadorSegundosU: ENTITY work.decod
        PORT MAP (
            numero => num_seg_u,
            seg => segund_u
        );

    DecodificadorSegundosD: ENTITY work.decod
        PORT MAP  (
            numero => num_seg_d,
            seg => segund_d
        );

    DecodificadorMinutosU: ENTITY work.decod
        PORT MAP  (
            numero => num_min_u,
            seg => min_u
        );

    DecodificadorMinutosD: ENTITY work.decod
        PORT MAP  (
            numero => num_min_d,
            seg => min_d
        );

    DecodificadorHorasU: ENTITY work.decod
        PORT MAP  (
            numero => num_hora_u,
            seg => hora_u
        );

    DecodificadorHorasD: ENTITY work.decod
        PORT MAP  (
            numero => num_hora_d,
            seg => hora_d
        );

END comport;