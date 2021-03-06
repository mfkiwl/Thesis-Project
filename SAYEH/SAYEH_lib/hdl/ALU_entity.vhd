--
-- VHDL Entity SAYEH_lib.ALU.arch_name
--
-- Created:
--          by - Christopher.UNKNOWN (CJ)
--          at - 00:23:34 02/16/2012
--
-- using Mentor Graphics HDL Designer(TM) 2010.2a (Build 7)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
USE ieee.std_logic_arith.all;

ENTITY ALU IS
  PORT (op0, op1 : IN std_logic_vector(15 DOWNTO 0);
        selector : IN std_logic_vector(3 DOWNTO 0);
        carry_in : IN std_logic;
        result : OUT std_logic_vector(15 DOWNTO 0);
        carry_out : OUT std_logic;
        zero_out : OUT std_logic);
END ENTITY ALU;

ARCHITECTURE Behavior OF ALU IS
  BEGIN
    PROCESS (op0, op1, selector, carry_in)
      VARIABLE result_local : std_logic_vector(15 DOWNTO 0);
      VARIABLE signed_op0, signed_op1, signed_result, signed_carry : signed(15 DOWNTO 0);
      VARIABLE most_sigs : unsigned(2 DOWNTO 0);
      BEGIN
        signed_op0 := signed(op0);
        signed_op1 := signed(op1);
        signed_carry(15 DOWNTO 1) := "000000000000000";
        signed_carry(0) := carry_in;
        CASE selector IS
        WHEN "0000" => -- LOGICAL AND
          result_local := op0 AND op1;
        WHEN "0001" => -- LOGICAL OR
          result_local := op0 OR op1;
        WHEN "0010" => -- LOGICAL NOT
          result_local := NOT op1;
        WHEN "0011" => -- SHIFT RIGHT ARITHMETIC
          result_local(14 DOWNTO 0) := op1(15 DOWNTO 1);
          result_local(15) := op1(15);
        WHEN "0100" => -- SHIFT LEFT ARITHMETIC
          result_local(15 DOWNTO 1) := op1(14 DOWNTO 0);
          result_local(0) := '1';
        WHEN "0101" => -- ADDITION
          result_local := op0 + op1 + carry_in;
        WHEN "0110" => -- SUBTRACTION
          result_local := op0 - op1 - carry_in;
        WHEN "0111" => -- MULTIPLICATION
          result_local := op0(7 DOWNTO 0) * op1(7 DOWNTO 0);
        WHEN "1000" => -- COMPARISON
          result_local := op0;
          IF op0 = op1 THEN
            zero_out <= '1';
          ELSE
            zero_out <= '0';
            IF op0 < op1 THEN
              carry_out <= '1';
            ELSE
              carry_out <= '0';
            END IF;
          END IF;
        WHEN OTHERS =>
          result_local := op0;
        END CASE;
        IF selector(3) = '0' THEN
          IF result_local = "0000000000000000" THEN
            zero_out <= '1';
          ELSE
            zero_out <= '0';
          END IF;
        END IF;
        result <= result_local;
        
        most_sigs(2) := result_local(15);
        most_sigs(1) := op0(15);
        most_sigs(0) := op1(15);
        CASE most_sigs IS
        WHEN "001" => carry_out <= '1';
        WHEN "010" => carry_out <= '1';
        WHEN "011" => carry_out <= '1';
        WHEN "111" => carry_out <= '1';
        WHEN OTHERS => carry_out <= '0';
        END CASE;
      END PROCESS;
  END ARCHITECTURE Behavior;