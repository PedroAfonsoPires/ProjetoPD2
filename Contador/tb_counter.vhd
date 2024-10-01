library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_counter is
end entity;

architecture behavior of tb_counter is

	-- Sinais para a simulação
	signal clock   : std_logic := '0';
	signal reset   : std_logic := '0';
	signal enable  : std_logic := '0';
	signal out_mem : std_logic_vector(3 downto 0);

	-- Instanciação do DUT (Device Under Test)
	component counter
		port(
			clock   : in std_logic;
			reset   : in std_logic;
			enable  : in std_logic;
			out_mem : out std_logic_vector(3 downto 0)
		);
	end component;

begin
	-- Instanciando o DUT (Device Under Test)
	uut: counter
		port map(
			clock   => clock,
			reset   => reset,
			enable  => enable,
			out_mem => out_mem
		);

	-- Geração do clock (simula um clock de 10ns)
	clock_process : process
	begin
		while true loop
			clock <= '0';
			wait for 5 ns;
			clock <= '1';
			wait for 5 ns;
		end loop;
	end process;

	-- Processo de teste
	stimulus_process : process
	begin
		-- Inicialização do reset
		reset <= '1';
		wait for 10 ns;
		reset <= '0';  -- Libera o reset
		
		-- Testa com enable desativado
		enable <= '0';
		wait for 50 ns;
		
		-- Testa com enable ativado
		enable <= '1';
		wait for 100 ns;
		
		-- Força um reset no meio da contagem
		reset <= '1';
		wait for 10 ns;
		reset <= '0';  -- Libera o reset
		
		-- Continua contando
		wait for 100 ns;
		
		-- Desativa o enable
		enable <= '0';
		wait for 50 ns;
		
		wait;
	end process;

end architecture;