require 'bigdecimal'
require 'time'
require_relative 'invoice_item'
require_relative 'data_analyst'
# This is the InvoiceItemRepository class
class InvoiceItemRepository
  attr_reader :invoice_items, :parent
  def initialize(csv, parent)
    @invoice_items = []
    @parent        = parent
    DataAnalyst.find_invoice_items(csv).each do |attribute|
      @invoice_items << InvoiceItem.new(id:          attribute[0].to_i,
                                        item_id:     attribute[1].to_i,
                                        invoice_id:  attribute[2].to_i,
                                        quantity:    attribute[3].to_i,
                                        unit_price:  BigDecimal(attribute[4].to_i) / 100,
                                        created_at:  Time.parse(attribute[5]),
                                        updated_at:  Time.parse(attribute[6]),
                                        parent:      self)
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.select { |invoice_item| invoice_item.id == id }.first
  end

  def find_all_by_item_id(item_id)
    @invoice_items.select { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.select { |invoice_item| invoice_item.invoice_id == invoice_id }
  end
end
