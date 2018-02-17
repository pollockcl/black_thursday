# DataAnalyst class. Handles csv processing
require 'csv'
class DataAnalyst
  def self.find_merchants(file)
    csv   = CSV.read(file, :headers => true)
    ids   = csv['id']
    names = csv['name']
    ids.zip(names)
  end
end