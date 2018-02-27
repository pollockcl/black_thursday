require 'csv'
require_relative './data_analyst'
require_relative './merchant'
# This is the MerchRepo class
class MerchRepository
  attr_reader :merchants, :parent
  def initialize(csv, parent)
    @merchants = []
    @parent    = parent
    DataAnalyst.find_merchants(csv).each do |attribute|
      @merchants << Merchant.new(id:      attribute[0],
                                 name:    attribute[1],
                                 created: Time.parse(attribute[2]),
                                 parent: self)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.select { |merch| merch.id == id }.first
  end

  def find_by_name(name)
    @merchants.select { |merch| name.casecmp(merch.name).zero? }.first
  end

  def find_all_by_name(name)
    @merchants.select { |merch| merch.name.downcase.include?(name.downcase) }
  end
end
