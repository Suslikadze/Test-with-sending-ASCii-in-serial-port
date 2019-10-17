library ieee;

use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

Entity TOP_COM_port is
Port(
    clk         : IN std_logic;
    out_pin     : OUT std_logic_vector(7 downto 0)
);
end TOP_COM_port;

Architecture arch of TOP_COM_port is
signal counter      : integer range 0 to 5 := 0;
signal word         : string (1 to 5) := "hello";
signal word_slv     : std_logic_vector(39 downto 0);
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
Begin
Process(clk)
Begin
    if rising_edge(clk) then
        word_slv <= to_slv(word);
        case counter is
            when 0 =>
                counter <= counter + 1;
                out_pin <= "00101010";
            when 1 =>
                out_pin <= word_slv(39 downto 32);
                counter <= counter + 1;
            when 2 =>
                out_pin <= word_slv(31 downto 24);
                counter <= counter + 1;
            when 3 =>
                out_pin <= word_slv(23 downto 16);
                counter <= counter + 1;
            when 4 =>
                out_pin <= word_slv(15 downto 8);
                counter <= counter + 1;
            when 5 =>
                out_pin <= word_slv(7 downto 0);
                counter <= 0;
        end case;
    end if; 
end process;
end arch;