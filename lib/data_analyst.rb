require 'csv'
# DataAnalyst class. Handles csv processing
class DataAnalyst
  def self.find_attributes(file)
    CSV.readlines(file, headers: true, header_converters: :symbol)
  end
end
