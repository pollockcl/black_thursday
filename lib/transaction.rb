# This is the Transaction class
class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_number_expiration_date,
              :result,
              :created_at,
              :updated_at
  def initialize(hash)
    @id                          = hash[:id]
    @invoice_id                  = hash[:invoice]
    @credit_card_number          = hash[:ccn]
    @credit_card_expiration_date = hash[:ccne]
    @result                      = hash[:result]
    @created_at                  = hash[:created]
    @updated_at                  = hash[:updated]
    @parent                      = hash[:parent]
  end
end
