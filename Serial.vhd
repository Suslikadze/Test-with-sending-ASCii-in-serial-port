library ieee;

use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

Entity Serial is
Port(
    clk                             : IN std_logic;
    enable                          : IN std_logic;
    Data_in                         : IN std_logic_vector(7 downto 0);
    Tx_busy                         : OUT std_logic;
    Data_out                        : OUT std_logic
);
End Serial;
----------------------------------------------------------------------------
Architecture arch of Serial is
signal counter                      : integer range 0 to 8 := 0;
signal start_signal, stop_signal    : std_logic;
type state_of_mashine is (idle, start_bit, data_session, end_bit);
signal state, pr_stage              : state_of_mashine := idle;
----------------------------------------------------------------------------
Begin

-- Process(clk)
-- Begin
--     If rising_edge(clk) then
--         pr_stage <= state;
--     end if;
-- end Process;

Process(clk, enable)
Begin
    if rising_edge(clk) then
      --  if enable = '1' then
        -- if enable = '0' then
        --     state <= idle;
        -- end if;
            case state is
                When idle =>
                    Data_out <= '1';
                    Tx_busy <= '0';
                    if enable = '0' then
                        state <= start_bit;
                        Tx_busy <= '1';
                    end if;
                When start_bit =>
                    Data_out <= '0';
                    state <= data_session;
                When data_session =>
                    if counter < 8 then
                        Data_out <= Data_in(7 - counter);
                        counter <= counter + 1;
                    else
                        counter <= 0;
                        state <= end_bit;
                    end if;
                When end_bit =>
                    Data_out <= '1';
                    Tx_busy <= '0';
                    state <= idle;
                -- when others =>
                --     state <= idle;
            end case;    
    end if;
end Process;
end arch;