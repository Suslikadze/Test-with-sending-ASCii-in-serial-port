library ieee;

use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

Entity Serial is
Port(
    clk                             : IN std_logic;
    enable                          : IN std_logic;
    Data_in                         : IN std_logic_vector(7 downto 0);
    Data_out                        : OUT std_logic
);
End Serial;

Architecture arch of Serial is
signal counter                      : integer range 1 to 8 := 1;
signal start_signal, stop_signal    : std_logic;
type state is (idle, start_bit, data_session, end_bit);
Begin
    if rising_edge(clk) then
      --  if enable = '1' then
            case state is
                When idle =>
                    Data_out <= '1';
                    if enable = '1' then
                        state <= start_bit;
                    end if;
                When start_bit =>
                    Data_out <= '0';
                    state <= data_session;
                When data_session =>
                    if counter <= 8 then
                        Data_out <= Data_in(8 - counter);
                         
    end if;
end arch;