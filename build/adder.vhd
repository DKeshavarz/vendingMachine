library ieee;
use ieee.std_logic_1164.all;

entity adder is


    port
    (
        x:    in std_logic_vector(5 downto 0);
        y:    in std_logic_vector(5 downto 0);
        cin:  in std_logic;
        sum:  out std_logic_vector(5 downto 0);
        cout: out std_logic
        
    );

end entity;

architecture behavioral of adder is
    component simple_adder is
        port
        (
            a, b, cin : in std_logic;
            cout, sum : out std_logic 
        );
    end component;

    signal si_carry: std_logic_vector(6 downto 0);
    signal si_sum: std_logic_vector(5 downto 0);
    signal c: std_logic_vector(5 downto 0); 

begin 
	
	xor_for_inputs: for i in 0 to 5 generate
		c(i) <= x(i) xor cin;
	end generate;
		
    fulladder_for: for i in 0 to 5 generate
        fulladder_portmap: simple_adder port map
        (
            a => c(i),
            b => y(i),
            cin => si_carry(i),
            sum => si_sum(i),
            cout => si_carry(i + 1)
        );
    end generate;
    si_carry(0) <= cin;
	sum        <= si_sum;
	cout       <= si_carry(6);
end architecture;
