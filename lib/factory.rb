require 'csv'
# Factory class. Handles csv parsing and mass object creation
class Factory
  def self.find_attributes(file)
    CSV.readlines(file, headers: true, header_converters: :symbol)
  end

  def self.create_customers(csv, parent)
    customers = []
    Factory.find_attributes(csv).each do |attribute, _nil|
      customers << Customer.new(id:      attribute[0].to_i,
                                first:   attribute[1],
                                last:    attribute[2],
                                created: Time.parse(attribute[3]),
                                updated: Time.parse(attribute[4]),
                                parent:  parent)
    end
    customers
  end
end
