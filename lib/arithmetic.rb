require 'bigdecimal'
# This is the Arithmatic module
module Arithmetic
  def average(numerator, denominator)
    (BigDecimal(numerator) / BigDecimal(denominator)).round(2)
  end

  def standard_deviation(data, average)
    Math.sqrt(data.map do |item, _nil|
      (item - average)**2
    end.reduce(:+) / (data.size - 1))
  end

  def z_score(data, average, standard_deviation)
    (data - average) / standard_deviation
  end
end
