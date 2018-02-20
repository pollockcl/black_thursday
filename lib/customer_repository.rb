require_relative 'customer'
require_relative 'data_analyst'
# This is the CustomerRepository class
class CustomerRepository
  def initialize
    @customers = []
  end

  def from_csv(csv)
    DataAnalyst.find_customers(csv).each do |attribute|
      @customers << Customer.new(id:      attribute[0].to_i,
                                 first:   attribute[1],
                                 last:    attribute[2],
                                 created: attribute[3],
                                 updated: attribute[4])
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.detect{ |customer| customer.id == id }
  end
end
