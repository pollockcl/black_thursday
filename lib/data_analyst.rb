require 'csv'
# DataAnalyst class. Handles csv processing
class DataAnalyst
  def self.find_merchants(file)
    csv = CSV.read(file, headers: true)
    [csv['id'],
     csv['name']].transpose
  end

  def self.find_items(file)
    csv = CSV.read(file, headers: true)
    [csv['id'],
     csv['name'],
     csv['description'],
     csv['unit_price'],
     csv['merchant_id'],
     csv['created_at'],
     csv['updated_at']].transpose
  end
end
