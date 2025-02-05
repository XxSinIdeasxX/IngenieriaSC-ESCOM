library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Puerta is
	 port(
		 CLK : in STD_LOGIC;
		 S1 : in STD_LOGIC;
		 S2 : in STD_LOGIC;
		 Cont : out STD_LOGIC_VECTOR(1 downto 0)
	     );
end Puerta;

architecture Puerta of Puerta is 
type estado is (A,B,C,D,E,F,G);
signal state, next_state : estado;

signal conta : INTEGER range 0 to 100 := 0;
signal X : std_logic := '0';
begin	   
	
	process(CLK) -- Divisor de frecuencia
	begin
		if (CLK'event and CLK='1') then
			if conta < 100 then
				conta <= conta + 1;
			else 
				X <= not X;
				conta <= 0;
			end if;
		end if;
	end process;
	
	process(X) -- L�gica secuencial
	begin
		if (X'event and X = '1')then
			state <= next_state;
		end if;
	end process;
	
	process(state, S1, S2) -- L�gica combinacional
	begin
		next_state <= state;
		Cont <= "00";
		case state is
			when A =>
			 if S1 = '1' and S2 = '0' then 
				next_state <= B;
			 elsif S1 = '0' and S2 = '1' then 
				next_state <= E; 	
			 end if;
			 
			when B =>
			 if S1 = '1' and S2 = '1' then 
				next_state <= C;
			 elsif S1 = '0' and S2 = '0' then 
				next_state <= A;
			 end if;
			 
			when C =>
			 if S1 = '0' and S2 = '1' then 
				next_state <= D;
			 elsif S1 = '1' and S2 = '0' then 
				next_state <= B;
			 end if;
			 
			when D =>
			 if S1 = '1' and S2 = '1' then 
				next_state <= C;
			 elsif S1 = '0' and S2 = '0' then 
				next_state <= A;
				Cont <= "01";
			 end if;
			 
			when E =>
			 if S1 = '0' and S2 = '0' then 
				next_state <= A;
			 elsif S1 = '1' and S2 = '1' then 
				next_state <= F;
			 end if;
			 
			when F =>
			 if S1 = '0' and S2 = '1' then 
				next_state <= E;
			 elsif S1 = '1' and S2 = '0' then 
				next_state <= G;
			 end if;
			 
			when G =>
			 if S1 = '0' and S2 = '0' then 
				next_state <= A;
				Cont <= "11";
			 elsif S1 = '1' and S2 = '1' then 
				next_state <= F;
			 end if; 
		end case;
	end process;
end Puerta;
