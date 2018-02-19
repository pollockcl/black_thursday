require 'bigdecimal'
require 'time'
require_relative 'invoice'
require_relative 'data_analyst'
# This is the InvoiceRepository class
class InvoiceRepository
  attr_reader :invoices, :parent
  def initialize(csv, parent)
    @invoices  = []
    @parent = parent
    DataAnalyst.find_invoices(csv).each do |attribute|
      @invoices << Invoice.new(id:          attribute[0],
                               customer_id: attribute[1],
                               merchant_id: attribute[2],
                               status:      attribute[3],
                               created_at:  attribute[4],
                               updated_at:  attribute[5],
                               parent:      self)
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.select { |invoice| invoice.id == id }.first
  end

  def find_all_by_customer_id(customer_id)
    @invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.select { |invoice| invoice.merchant_id == merchant_id }
  end

  # def find_all_with_description(description)
  #   @invoices.select do |invoice|
  #     invoice_description = invoice.description.downcase
  #     invoice_description.include?(description.downcase)
  #   end
  # end
  #
  # def find_all_by_price(price)
  #   @invoices.select { |invoice| invoice.unit_price == price }
  # end
  #
  # def find_all_by_price_in_range(range)
  #   @invoices.select { |invoice| range.include?(invoice.unit_price) }
  # end
  #
  # def find_all_by_merchant_id(merch_id)
  #   @invoices.select { |invoice| invoice.merchant_id == merch_id }
  # end
end
