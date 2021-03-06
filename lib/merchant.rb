# This is the Merchant class
class Merchant
  attr_reader :id, :name, :created_at
  def initialize(attributes)
    @id         = attributes[:id].to_i
    @name       = attributes[:name]
    @parent     = attributes[:parent]
    @created_at = attributes[:created]
  end

  def items
    @parent.parent.items.find_all_by_merchant_id(id)
  end

  def invoices
    @parent.parent.invoices.find_all_by_merchant_id(id)
  end

  def customers
    invoices.map do |invoice|
      @parent.parent.customers.find_by_id(invoice.customer_id)
    end.uniq
  end

  def invoice_items
    @invoice_items ||= calc_inv_items
  end

  def calc_inv_items
    invoices.map do |invoice|
      @parent.parent.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def items_sold
    @items_sold ||= calc_items_sold
  end

  def calc_items_sold
    invoice_items.map { |ii| @parent.parent.items.find_by_id(ii.item_id) }
  end

  def invoice_pending?(invoice_id)
    !@parent.parent.invoices.find_by_id(invoice_id).is_paid_in_full?
  end

  def sales_quantities
    @sales_quantities ||= calc_sales_quantities
  end

  def calc_sales_quantities
    totals = Hash.new(0)
    invoice_items.each do |ii|
      next if invoice_pending?(ii.invoice_id)
      totals[ii.item_id] += ii.quantity
    end
    totals
  end

  def all_items_by_quantity
    items_sold.sort_by { |item| sales_quantities[item.id] }
  end
end
