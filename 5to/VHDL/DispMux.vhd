library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MDE is
    Port ( F : out  STD_LOGIC_VECTOR (6 downto 0);
           C : out  STD_LOGIC_VECTOR (3 downto 0);
           CLK : in  STD_LOGIC);
end MDE;

architecture Behavioral of MDE is 
type estado is (H,O,L,A);
signal state, next_state:  estado;
signal ref : INTEGER range 0 to 100000;
signal X : std_logic := '0';
signal disp : std_logic_vector(3 downto 0) := (others => '0');
signal salida : std_logic_vector(6 downto 0) := (others => '0');
begin

process(CLK)
	begin
	if (CLK'event and CLK='1')then
		if ref < 100000 then
			ref <= ref + 1;
		else 
			X <= not X;
			ref <= 0;
		end if;
	end if;
end process;

process(X)
begin
	if (X'event and X ='1')then
		state <= next_state;
		F <= salida;
		C <= disp;
	end if;
end process;

process(state) -- L�gica combinacional
	begin
		if state = H then
			salida <= "1001000";
			disp <= "1101";
		elsif state = O then
			salida <= "0000001";
			disp <= "1011";
		elsif state = L then
			salida <= "1110001";
			disp <= "0111";
		elsif state = A then
			salida <= "0001000";
			disp <= "1011";
		end if;
	end process;
	
	process(state)
	begin		   
		next_state <= state;
		case(state) is
			when H => next_state <= O;
			when O => next_state <= L;
			when L => next_state <= A;
			when A => next_state <= H;
			when others => next_state <= H;
		end case;
	end process;

end Behavioral;