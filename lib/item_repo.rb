# This is the ItemRepo class
require_relative 'item'
require_relative 'data_analyst'
class ItemRepo
  attr_reader :items
  def initialize(csv)
    @items = []
    DataAnalyst.find_items(csv).each do |item|
      @items << Item.new(item[0], item[1], item[2], item[3], item[4])
    end
  end
end