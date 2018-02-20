# This is the Transaction class
class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_number_expiration_date,
              :result,
              :created_at,
              :updated_at
  def initialize(attributes)
    @id                          = attributes[:id]
    @invoice_id                  = attributes[:iid]
    @credit_card_number          = attributes[:ccn]
    @credit_card_expiration_date = attributes[:ccne]
    @result                      = attributes[:result]
    @created_at                  = attributes[:created]
    @updated_at                  = attributes[:updated]
    @parent                      = attributes[:parent]
  end
end
