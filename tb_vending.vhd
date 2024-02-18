library ieee;
use ieee.std_logic_1164.all;

entity tb_vending is
end entity;

architecture logic of tb_vending is
    component vending is
        port
        (   ten , five , clk           : in  std_logic;
            tick_5 , tick_15 , tick_40 : in  std_logic;
            done , reset               : in  std_logic;
            get_tick                   : out std_logic;
            z                          : out std_logic_vector(5 downto 0)) ;         
    end component;

    
    signal ten , five , clk           :std_logic := '0';
    signal z                          :std_logic_vector(5 downto 0) := (others => '0');
    signal tick_5 , tick_15 , tick_40 :std_logic := '0';
    signal done  , get_tick  , reset  :std_logic := '0';

    begin 
        uut:vending port map (ten , five , clk ,tick_5 , tick_15 , tick_40 , done  , reset , get_tick , z );

    clk <= not clk after 10 ns;
    
    process
    begin

      

        wait for 5 ns ;
        ten <= '1' ;
        wait for 20 ns;
        ten <= '0' ;

        wait for 10 ns ;
        ten <= '1' ;
        wait for 20 ns;
        ten <= '0' ;

        wait for 30 ns;
        tick_15 <= '1';
        wait for 20 ns;
        tick_15 <= '0';


        wait for 10 ns ;
        done <= '1';
        wait for 30 ns;
        done <= '0';

        ten <= '1' ;
        wait for 35 ns;
        ten <= '0' ;

        five <= '1';
        wait for 30 ns;
        five <= '0';

        tick_40 <= '1';
        wait for 30 ns;
        tick_40 <= '0';

        tick_5 <= '1';
        wait for 30 ns;
        tick_5 <= '0';

        wait for 15 ns ;
        done <= '1';
        wait for 30 ns;
        done <= '0';


        wait;
    
    end process ;
    end architecture;