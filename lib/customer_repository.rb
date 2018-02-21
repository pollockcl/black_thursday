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
                                 created: attribute[3],
                                 updated: attribute[4],
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
    all.select { |customer| customer.first_name.include?(name) }
  end

  def find_all_by_last_name(name)
    all.select { |customer| customer.last_name.include?(name) }
  end
end
