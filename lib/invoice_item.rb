# This is the InvoiceItem class
class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at
  def initialize(attributes)
    @id          = attributes[:id]
    @item_id     = attributes[:item_id]
    @invoice_id  = attributes[:invoice_id]
    @quantity    = attributes[:quantity]
    @unit_price  = attributes[:unit_price]
    @created_at  = attributes[:created_at]
    @updated_at  = attributes[:updated_at]
    @parent      = attributes[:parent]
  end

  def unit_price_to_dollars
    @unit_price.round(2)
  end
end
