# The SalesEngine class
require_relative './merch_repo'
require_relative './item_repo'
class SalesEngine
  attr_reader :merchant_repo, :item_repo
  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def initialize(hash)
    @merchant_repo = MerchRepo.new(hash[:merchants])
    @item_repo     = ItemRepo.new(hash[:items])
  end
end
