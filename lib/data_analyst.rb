require 'csv'
# DataAnalyst class. Handles csv processing
class DataAnalyst
  def self.find_attributes(csv)
    CSV.readlines(csv, headers: true, header_converters: :symbol)
  end
end
