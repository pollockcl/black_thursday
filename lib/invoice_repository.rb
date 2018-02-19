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

  def find_all_by_status(status)
    @invoices.select { |invoice| invoice.status.downcase == status.downcase }
  end
end
