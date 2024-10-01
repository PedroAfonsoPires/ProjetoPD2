library ieee;                   
use ieee.std_logic_1164.all;    
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity counter is
	port(
		clock   : in std_logic;
		reset   : in std_logic;
		enable  : in std_logic;
		out_mem : out std_logic_vector(3 downto 0)
		);
end entity;		
architecture behavior of counter is 
signal counter : std_logic_vector(3 downto 0);

type lut is array (integer range 0 to 15) of std_logic_vector(3 downto 0);
signal mult_result : lut := ( --memoria
		0  => "0000", 
		1  => "0001",
		2  => "0010",
		3  => "0011",
		4  => "0100",
		5  => "0101",
		6  => "0110",
		7  => "0111",
		8  => "1000",
		9  => "1001",
		10 => "1010",
		11 => "1011",
		12 => "1100",
		13 => "1101",
		14 => "1110",
		15 => "1111"
	);
begin	
process (clock, reset)
begin
	if reset = '1' then
		counter <= (others => '0');
	elsif clock = '1' and clock'event then
		if enable = '1' then
			counter <= counter + 1;
		end if;
	end if;
	
end process;

out_mem <= mult_result(conv_integer(counter));

end behavior;