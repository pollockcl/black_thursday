require_relative './merch_repo'
require_relative './item_repo'
# The SalesEngine class
class SalesEngine
  attr_reader :merchants, :items
  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def initialize(hash)
    @merchants = MerchRepo.new(hash[:merchants], self)
    @items     = ItemRepo.new(hash[:items], self)
  end
end
