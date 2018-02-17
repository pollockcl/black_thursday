require 'csv'
# DataAnalyst class. Handles csv processing
class DataAnalyst
  def self.find_merchants(file)
    csv   = CSV.read(file, headers: true)
    ids   = csv['id']
    names = csv['name']
    ids.zip(names)
  end

  def self.find_items(file)
    csv = CSV.read(file, headers: true)
    id          = csv['id']
    name        = csv['name']
    description = csv['description']
    unit_price  = csv['unit_price']
    merchant_id = csv['merchant_id']
    created_at  = csv['created_at']
    updated_at  = csv['updated_at']
    [id, name, description, unit_price, merchant_id, created_at, updated_at].transpose
  end
end
