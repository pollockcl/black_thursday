require 'csv'
require_relative './data_analyst'
require_relative './merchant'
# This is the MerchRepo class
class MerchRepo
  attr_reader :merchants, :parent
  def initialize(csv, parent)
    @merchants = []
    @parent    = parent
    DataAnalyst.find_merchants(csv).each do |attribute|
      @merchants << Merchant.new(id:     attribute[0],
                                 name:   attribute[1],
                                 parent: self)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    result = @merchants.select { |merch| merch.id == id.to_s }
    result[0]
  end

  def find_by_name(name)
    result = @merchants.select { |merch| name.casecmp(merch.name).zero? }
    result[0]
  end

  def find_all_by_name(name)
    @merchants.select { |merch| merch.name.downcase.include?(name.downcase) }
  end

  def size
    all.size
  end
end
