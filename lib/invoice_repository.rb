require 'bigdecimal'
require 'time'
require_relative 'invoice'
require_relative 'data_analyst'
# This is the InvoiceRepository class
class InvoiceRepository
  attr_reader :invoices, :parent
  def initialize(csv, parent)
    @invoices = []
    @parent   = parent
    DataAnalyst.find_attributes(csv).each do |attribute|
      @invoices << Invoice.new(id:          attribute[0].to_i,
                               customer_id: attribute[1].to_i,
                               merchant_id: attribute[2].to_i,
                               status:      attribute[3].to_sym,
                               created_at:  Time.parse(attribute[4]),
                               updated_at:  Time.parse(attribute[5]),
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

  def find_all_by_status(status)
    @invoices.select { |invoice| invoice.status == status }
  end
end
