require_relative 'item'
require_relative 'data_analyst'
# This is the ItemRepo class
class ItemRepo
  attr_reader :items, :parent
  def initialize(csv, parent)
    @items  = []
    @parent = parent
    DataAnalyst.find_items(csv).each do |attribute|
      @items << Item.new(id: attribute[0],
                         name: attribute[1],
                         description: attribute[2],
                         unit_price: attribute[3],
                         merchant_id: attribute[4],
                         created_at: attribute[5],
                         updated_at: attribute[6],
                         parent: self)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.select { |item| item.id == id.to_s }.first
  end

  def find_by_name(name)
    @items.select { |item| item.name == name }.first
  end

  def find_all_with_description(description)
    @items.select { |item| item.description.include?(description) }
  end

  def find_all_by_price(price)
    @items.select { |item| item.unit_price.to_i == price }
  end

  def find_all_by_price_in_range(start, final)
    @items.select { |item| item.unit_price.to_i.between?(start, final) }
  end

  def find_all_by_merchant_id(merch_id)
    @items.select { |item| item.merchant_id == merch_id.to_s }
  end

  def size
    all.size
  end
end
