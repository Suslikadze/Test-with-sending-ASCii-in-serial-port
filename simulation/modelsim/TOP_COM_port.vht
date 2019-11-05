-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "10/29/2019 10:28:14"
                                                            
-- Vhdl Test Bench template for design  :  TOP_COM_port
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY TOP_COM_port_vhd_tst IS
END TOP_COM_port_vhd_tst;
ARCHITECTURE TOP_COM_port_arch OF TOP_COM_port_vhd_tst IS
-- constants 
constant clock_period : time := 10 ns;                                                
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL Key : STD_LOGIC;
SIGNAL LED : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL out_pin : STD_LOGIC;
COMPONENT TOP_COM_port
	PORT (
	clk : IN STD_LOGIC;
	Key : IN STD_LOGIC;
	LED : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	out_pin : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : TOP_COM_port
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	Key => Key,
	LED => LED,
	out_pin => out_pin
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init; 


 clock_process :process
   begin
  clk <= '0';
  wait for clock_period/2;
  clk <= '1';
  wait for clock_period/2;
   end process;

key <= '0';
	
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END TOP_COM_port_arch;
