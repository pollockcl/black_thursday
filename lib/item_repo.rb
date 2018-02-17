require_relative 'item'
require_relative 'data_analyst'
# This is the ItemRepo class
class ItemRepo
  attr_reader :items
  def initialize(csv)
    @items = []
    DataAnalyst.find_items(csv).each do |item|
      @items << Item.new(item[0], item[1], item[2], item[3], item[4], item[5], item[6])
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    id = id.to_s unless id.is_a?(String)
    result = @items.select { |item| item.id == id }
    result[0]
  end

  def find_by_name(name)
    result = @items.select { |item| item.name == name }
    result[0]
  end

  def find_all_with_description(description)
    @items.select { |item| item.description.include?(description) }
  end

  def find_all_by_price(price)
    @items.select { |item| item.unit_price.to_i == price }
  end

  def find_all_by_price_in_range(start, final)
    @items.select{ |item| item.unit_price.to_i.between?(start, final) }
  end

  def find_all_by_merchant_id(merch_id)
    merch_id = merch_id.to_s unless merch_id.is_a?(String)
    @items.select{ |item| item.merchant_id == merch_id }
  end
end
