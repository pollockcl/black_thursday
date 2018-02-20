# This is the Customer class
class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
  def initialize(attributes)
    @id         = attributes[:id]
    @first_name = attributes[:first]
    @last_name  = attributes[:last]
    @created_at = attributes[:created]
    @updated_at = attributes[:updated]
    @parent     = attributes[:parent]
  end
end
