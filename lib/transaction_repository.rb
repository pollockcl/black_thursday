require_relative 'data_analyst'
require_relative 'transaction'
# This is the TransactionRepository class
class TransactionRepository
  attr_reader :transactions, :parent
  def initialize(csv, parent)
    @transactions = []
    @parent = parent
    DataAnalyst.find_transactions(csv).each do |attributes|
      @transactions << Transaction.new(id: attributes[0].to_i,
                                       iid: attributes[1].to_i,
                                       ccn:        attributes[2].to_i,
                                       ccne:       attributes[3],
                                       result:     attributes[4],
                                       created:    Time.parse(attributes[5]),
                                       updated:    Time.parse(attributes[6]),
                                       parent:     self)
    end
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    @transactions
  end

  def find_by_id(id)
    all.detect { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(id)
    all.select { |transaction| transaction.invoice_id == id }
  end

  def find_all_by_credit_card_number(number)
    all.select { |transaction| transaction.credit_card_number == number }
  end

  def find_all_by_result(result)
    all.select { |transaction| transaction.result == result }
  end
end
