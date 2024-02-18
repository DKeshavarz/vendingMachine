library ieee;
use ieee.std_logic_1164.all;

entity vending is
    port
    (   ten , five , clk           : in  std_logic;
        tick_5 , tick_15 , tick_40 : in  std_logic;
        done , reset               : in  std_logic;
        get_tick                   : out std_logic;
        z                          : out std_logic_vector(5 downto 0)) ;                          
end entity;

architecture behavioral of vending is
    component adder is
        port
        (
            x:    in std_logic_vector(5 downto 0);
            y:    in std_logic_vector(5 downto 0);
            cin:  in std_logic;
            sum:  out std_logic_vector(5 downto 0);
            cout: out std_logic
            
        );
    end component;

    signal temp : std_logic_vector(5 downto 0) := (others => '0');
    signal result5 , result10 : std_logic_vector(5 downto 0) := (others => '0');
    signal sub5 ,sub15 , sub40: std_logic_vector(5 downto 0) := (others => '0');
    signal garbage :std_logic;
    signal res     :std_logic := '0';

    
    
    begin

        adder5  :adder port map(temp,"000101" , '0' , result5  , garbage);
        adder10 :adder port map(temp,"001010" , '0' , result10 , garbage);
        subber5 :adder port map("000101",temp , '1' , sub5     , garbage);
        subber15:adder port map("001111",temp , '1' , sub15    , garbage);
        subber40:adder port map("101000",temp , '1' , sub40    , garbage);

        process(clk)
        begin
            if(clk'event and clk = '1') then
                get_tick <= '0';
                z <= "000000";
                if   res = '1' then
                    
                    temp <= "000000";
                    if done = '0' then
                        res <= '0';
                    end if;
                elsif done = '1' then
                    z <= temp;
                    res <= '1';
                elsif    tick_5  = '1'  and temp > "000101" then
                    temp <= sub5;
                    get_tick <= '1';
                elsif tick_15  = '1' and temp > "001111" then
                    temp <= sub15;
                    get_tick <= '1';
                elsif tick_40  = '1' and temp > "101000" then
                    temp <= sub40;
                    get_tick <= '1';
                elsif five = '1' then
                    temp <= result5;
                elsif ten  = '1' then
                    temp <= result10;
                end if;
                --z <= temp;
            end if;
        end process;
    end architecture;