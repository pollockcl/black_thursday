# This is the MerchantAnalyst module
module MerchantAnalyst
  def average_items_per_merchant
    average(items.size, merchants.size).to_f.round(2)
  end

  def average_items_per_merchant_standard_deviation
    data = merchants.map { |merchant| merchant.items.size }
    standard_deviation(data, average_items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    std_deviation = average_items_per_merchant_standard_deviation
    avg           = average_items_per_merchant
    merchants.select do |merchant|
      data = merchant.items.size
      z_score(data, avg, std_deviation) > 1
    end
  end

  def average_item_price_for_merchant(merchant_id)
    inventory = @sales_engine.merchants.find_by_id(merchant_id).items
    prices    = inventory.map(&:unit_price)
    average(prices.reduce(:+), inventory.size)
  end

  def average_average_price_per_merchant
    numerator = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    average(numerator, merchants.size)
  end

  def average_invoices_per_merchant
    average(invoices.size, merchants.size).to_f
  end

  def most_sold_item_for_merchant(merch_id)
    merchant     = @sales_engine.merchants.find_by_id(merch_id)
    items        = merchant.all_items_by_quantity
    max_quantity = merchant.sales_quantities[items.last.id]
    items.select { |item| merchant.sales_quantities[item.id] == max_quantity }
  end

  def merchants_with_only_one_item
    merchants.select { |merchant| merchant.items.size == 1 }
  end

  def merchants_with_only_one_item_registered_in_month(month)
    candidates = merchants.select do |merchant|
      merchant.created_at.strftime('%B') == month
    end
    candidates.select { |merchant| merchant.items.size == 1 }
  end

  def revenue_by_merchant(id)
    merchant = @sales_engine.merchants.find_by_id(id)
    merchant.invoices.map(&:total).reduce(:+)
  end

  def best_item_for_merchant(id)
    merchant      = @sales_engine.merchants.find_by_id(id)
    invoice_items = merchant.invoice_items

    top = invoice_items.max_by do |ii|
      ii.unit_price * merchant.sales_quantities[ii.item_id]
    end

    @sales_engine.items.find_by_id(top.item_id)
  end

  def merchants_ranked_by_revenue
    merchants.sort_by do |merchant|
      merchant.invoices.map(&:total).reduce(:+)
    end.reverse
  end

  def merchants_with_pending_invoices
    merchants.select do |merchant|
      merchant.invoices.map(&:is_paid_in_full?).include?(false)
    end
  end

  def top_revenue_earners(size = 20)
    merchants_ranked_by_revenue[0...size]
  end
end
