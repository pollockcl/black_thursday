require_relative 'customer'
require_relative 'factory'
# This is the CustomerRepository class
class CustomerRepository
  attr_reader :customers, :parent
  def initialize(customers, parent)
    @customers = customers
    @parent    = parent
  end

  def self.from_csv(csv, parent)
    customers = Factory.create_customers(csv, self)
    CustomerRepository.new(customers, parent)
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
