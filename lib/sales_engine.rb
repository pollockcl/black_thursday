require_relative './merch_repository'
require_relative './item_repository'
require_relative './invoice_repository'
# The SalesEngine class
class SalesEngine
  attr_reader :merchants, :items
  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def initialize(hash)
    @merchants = MerchRepository.new(hash[:merchants], self)
    @items     = ItemRepository.new(hash[:items], self)
    @invoices  = InvoiceReposition.new(hash[:invoices], self)
  end
end
