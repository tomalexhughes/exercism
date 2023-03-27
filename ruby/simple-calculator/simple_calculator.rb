class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  def self.calculate(first_operand, second_operand, operation)
    raise(ArgumentError, 'numbers only please') if !first_operand.is_a?(Integer) || !second_operand.is_a?(Integer)
    raise UnsupportedOperation unless ["+", "*", "/"].include?(operation)

    result = first_operand.public_send(operation, second_operand)
    "#{first_operand} #{operation} #{second_operand} = #{result}"
  rescue ZeroDivisionError
    "Division by zero is not allowed."
  end

  class UnsupportedOperation < StandardError
  end
end
