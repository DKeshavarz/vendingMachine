library ieee;
use ieee.std_logic_1164.all;

entity simple_adder is
	port
	(
		a, b, cin:  in std_logic;
		sum, cout: out std_logic
	);
end entity;

architecture behavioral of simple_adder is

	
begin
	sum <= a xor b xor cin;
	cout <= (a and b) or (a and cin) or (b and cin);
	
end architecture;
