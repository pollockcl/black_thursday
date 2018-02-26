# This is the ItemAnalyst module
module ItemAnalyst
  def average_item_price
    numerator = items.map { |item| item.unit_price.to_i }.reduce(:+)
    average(numerator, items.size)
  end

  def average_item_price_standard_deviation
    data = items.map { |item| item.unit_price.to_i }
    standard_deviation(data, average_item_price)
  end

  def golden_items
    std_deviation = average_item_price_standard_deviation
    items.select do |item|
      data = item.unit_price.to_i
      z_score(data, average_item_price, std_deviation) > 2
    end
  end
end
