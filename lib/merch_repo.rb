require 'csv'
require_relative './data_analyst'
require_relative './merchant'
# This is the MerchRepo class
class MerchRepo
  attr_reader :merchants
  def initialize(csv)
    @merchants = []
    DataAnalyst.find_merchants(csv).each do |item|
      @merchants << Merchant.new(item[0], item[1])
    end
  end
end
