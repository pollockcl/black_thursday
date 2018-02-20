require_relative 'data_analyst'
require_relative 'transaction'
# This is the TransactionRepository class
class TransactionRepository
  def initialize
    @transactions = []
  end

  def from_csv(csv)
    DataAnalyst.find_transactions(csv).each do |attributes|
      @transactions << Transaction.new(id: attributes[0].to_i,
                                       iid: attributes[1].to_i,
                                       ccn:        attributes[2].to_i,
                                       ccne:       attributes[3].to_i,
                                       result:     attributes[4],
                                       created:    Time.parse(attributes[5]),
                                       updated:    Time.parse(attributes[6]))
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    all.detect { |transaction| transaction.id == id }
  end

end
