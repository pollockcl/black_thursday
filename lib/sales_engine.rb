require_relative './merch_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './transaction_repository'
require_relative './customer_repository'
# The SalesEngine class
class SalesEngine
  attr_reader :merchants, :items, :invoices, :invoice_items,
              :transactions, :customers
  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def initialize(hash)
    @merchants     = MerchRepository.new(hash[:merchants], self)
    @items         = ItemRepository.new(hash[:items], self)
    @invoices      = InvoiceRepository.new(hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
    @transactions  = TransactionRepository.new(hash[:transactions], self)
    @customers     = CustomerRepository.new(hash[:customers], self)
  end
end
