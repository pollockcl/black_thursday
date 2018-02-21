require_relative 'customer'
require_relative 'data_analyst'
# This is the CustomerRepository class
class CustomerRepository
  attr_reader :customers, :parent
  def initialize(csv, parent)
    @customers = []
    @parent = parent
    DataAnalyst.find_customers(csv).each do |attribute|
      @customers << Customer.new(id:      attribute[0].to_i,
                                 first:   attribute[1],
                                 last:    attribute[2],
                                 created: Time.parse(attribute[3]),
                                 updated: Time.parse(attribute[4]),
                                 parent:  self)
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    @customers
  end

  def find_by_id(id)
    all.detect { |customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    name = name.downcase
    all.select { |customer| customer.first_name.downcase.include?(name) }
  end

  def find_all_by_last_name(name)
    name = name.downcase
    all.select { |customer| customer.last_name.downcase.include?(name) }
  end
end
