require 'bigdecimal'
# This is the Arithmatic module
module Arithmetic
  def average(numerator, denominator)
    (BigDecimal(numerator) / BigDecimal(denominator)).round(2)
  end

  def standard_deviation(range, average)
    Math.sqrt(range.map do |item|
      (item - average)**2
    end.sum / range.size).round(2)
  end

  def z_score(average, standard_deviation, data)
    (data - average) / standard_deviation
  end
end
