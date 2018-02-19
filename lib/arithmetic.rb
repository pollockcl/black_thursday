require 'bigdecimal'
# This is the Arithmatic module
module Arithmetic
  def average(numerator, denominator)
    (BigDecimal(numerator) / BigDecimal(denominator)).round(2)
  end
end
