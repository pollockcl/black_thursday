# This is the Customer class
class Customer
  def initialize(hash)
    @id         = hash[:id]
    @first_name = hash[:first]
    @last_name  = hash[:last]
    @created_at = hash[:created]
    @updated_at = hash[:updated]
  end
end