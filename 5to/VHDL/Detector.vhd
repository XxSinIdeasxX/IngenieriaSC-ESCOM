library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Detector is
	 port(
		 S : in STD_LOGIC;
		 CLK : in STD_LOGIC;
		 F : out STD_LOGIC
	     );
end Detector;

architecture Detector of Detector is	

type estado is (A,B,C,D,E);
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
	
	process(state, S) -- L�gica combinacional
	begin
		case state is
			when A =>
			 if S = '1' then 
				F <= '0';
				next_state <= B;
			 else
				F <= '0';
				next_state <= A;
			 end if;	
			when B =>
			 if S = '0' then 
				F <= '0';
				next_state <= C;
			 else
				F <= '0';
				next_state <= B;
			 end if;	
			when C =>
			 if S = '1' then 
				F <= '0';
				next_state <= D;
			 else
				F <= '0';
				next_state <= A;
			 end if;
			when D =>
			 if S = '1' then 
				F <= '0';
				next_state <= E;
			 else
				F <= '0';
				next_state <= C;
			 end if;	
			when E =>
			 if S = '1' then 
				F <= '0';
				next_state <= B;
			 else
				F <= '1';
				next_state <= C;
			 end if;
		end case;
	end process;
end Detector;
