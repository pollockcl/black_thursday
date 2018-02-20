# This is the Customer class
class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
  def initialize(hash)
    @id         = hash[:id]
    @first_name = hash[:first]
    @last_name  = hash[:last]
    @created_at = hash[:created]
    @updated_at = hash[:updated]
    @parent     = hash[:parent]
  end
end
