require 'bigdecimal'
require 'time'
require_relative 'invoice'
require_relative 'data_analyst'
# This is the InvoiceRepository class
class InvoiceRepository
  attr_reader :invoices, :parent
  def initialize(csv, parent)
    @items  = []
    @parent = parent
    DataAnalyst .find_items(csv).each do |attribute|
      @invoices << Invoice.new(id:          attribute[0],
                               customer_id: attribute[1],
                               merchant_id: attribute[2],
                               status:      BigDecimal(attribute[3].to_i) / 100,
                               merchant_id: attribute[4],
                               created_at:  Time.parse(attribute[5]),
                               updated_at:  Time.parse(attribute[6]),
                               parent:      self)
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @invoices
  end
  #
  # def find_by_id(id)
  #   @items.select { |item| item.id == id }.first
  # end
  #
  # def find_by_name(name)
  #   @items.select { |item| item.name == name }.first
  # end
  #
  # def find_all_with_description(description)
  #   @items.select do |item|
  #     item_description = item.description.downcase
  #     item_description.include?(description.downcase)
  #   end
  # end
  #
  # def find_all_by_price(price)
  #   @items.select { |item| item.unit_price == price }
  # end
  #
  # def find_all_by_price_in_range(range)
  #   @items.select { |item| range.include?(item.unit_price) }
  # end
  #
  # def find_all_by_merchant_id(merch_id)
  #   @items.select { |item| item.merchant_id == merch_id }
  # end
end
