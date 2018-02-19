require_relative './merch_repository'
require_relative './item_repository'
# The SalesEngine class
class SalesEngine
  attr_reader :merchants, :items
  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def initialize(hash)
    @merchants = MerchRepository.new(hash[:merchants], self)
    @items     = ItemRepository.new(hash[:items], self)
  end
end
