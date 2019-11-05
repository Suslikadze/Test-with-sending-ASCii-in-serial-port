library ieee;

use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

Entity TOP_COM_port is
Port(
    clk         : IN std_logic;
    Key         : IN std_logic;
    LED         : OUT std_logic_vector(7 downto 0);
    out_pin     : OUT std_logic
);
end TOP_COM_port;

Architecture arch of TOP_COM_port is
signal counter_big  : integer range 0 to 5 := 0;
signal counter      : integer := 0;
signal word         : string (1 to 5) := "hello";
signal word_slv     : std_logic_vector(39 downto 0);
signal flag         : std_logic;
signal serial_clk   : std_logic := '1';
signal Data         : std_logic_vector(7 downto 0);
signal Tx_busy      : std_logic;
----------------------------------------------------------------------------
component count_n_modul
generic (n		: integer);
port (
	clk		: in std_logic;
	reset	: in std_logic;
	en		: in std_logic;
    modul	: in std_logic_vector (n-1 downto 0);
    cout	: out std_logic);
end component;
----------------------------------------------------------------------------
component Serial
Port(
    clk                             : IN std_logic;
    enable                          : IN std_logic;
    Data_in                         : IN std_logic_vector(7 downto 0);
    Tx_busy                         : OUT std_logic;
    Data_out                        : OUT std_logic
);
end component;
----------------------------------------------------------------------------
----------------------------------------------------------------------------
function to_slv(str : string) return std_logic_vector is
  alias str_norm : string(str'length downto 1) is str;
  variable res_v : std_logic_vector(8 * str'length - 1 downto 0);
begin
  for idx in str_norm'range loop
    res_v(8 * idx - 1 downto 8 * idx - 8) := 
      std_logic_vector(to_unsigned(character'pos(str_norm(idx)), 8));
  end loop;
return res_v;
end function;
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
Begin
----------------------------------------------------------------------------
TXD : Serial
    Port map(
        clk             => serial_clk,
        enable          => Key,
        Data_in         => Data,
        Data_out        => out_pin,
        Tx_busy         => Tx_busy
    );
----------------------------------------------------------------------------
counter_serial : count_n_modul
    generic map(12)
    Port map(
        clk         => clk,
        reset       => '0',
        en          => '1',
        modul       => "101000101100",
        cout        => flag        
    );
----------------------------------------------------------------------------
----------------------------------------------------------------------------
Process(flag)
Begin
    if rising_edge(flag) then
        serial_clk <= not serial_clk;
    end if;
end process;
----------------------------------------------------------------------------
process(clk)
Begin
    If rising_edge(clk) then
        if key = '0' and Tx_busy = '0' then
            counter_big <= counter_big + 1;
        elsif counter_big = 5 then
            counter_big <= 0;
        end if;
    end if;
end process;
----------------------------------------------------------------------------
-- Process(clk)
-- Begin
--     If rising_edge(clk) then
--         if counter = 26041 then
--             counter <= 0;
--             counter_big <= counter_big + 1;
--         else
--             counter <= counter + 1;
--         end if;
--         If counter_big = 5 then
--             counter_big <= 0;
--         end if;
--     end if;
-- end process;
----------------------------------------------------------------------------
Process(clk)
Begin
    if rising_edge(clk) then
        if key = '0' then
            word_slv <= to_slv(word);
            case counter_big is
                when 0 =>
                    Data <= "00101010";
                when 1 =>
                    Data <= word_slv(39 downto 32);
                    LED <= "00000001";
                when 2 =>
                    Data <= word_slv(31 downto 24);
                    LED <= "00000010";
                when 3 =>
                    Data <= word_slv(23 downto 16);
                    LED <= "00000011";
                when 4 =>
                    Data <= word_slv(15 downto 8);
                    LED <= "00000100";
                when 5 =>
                    Data <= word_slv(7 downto 0);
                    LED <= "00000101";
            end case;
        else
            LED <= "11111111";
        end if;
    end if; 
end process;
end arch;