# This is the InvoiceAnalyst module
module InvoiceAnalyst
  def net_invoices(merchant_id)
    @sales_engine.invoices.find_all_by_merchant_id(merchant_id).size
  end

  def average_invoices_per_merchant_standard_deviation
    data = merchants.map { |merchant| net_invoices(merchant.id) }
    standard_deviation(data, average_invoices_per_merchant).round(2)
  end

  def top_merchants_by_invoice_count
    std_deviation = average_invoices_per_merchant_standard_deviation
    avg           = average_invoices_per_merchant
    merchants.select do |merchant|
      data = net_invoices(merchant.id)
      z_score(data, avg, std_deviation) > 2
    end
  end

  def bottom_merchants_by_invoice_count
    std_deviation = average_invoices_per_merchant_standard_deviation
    merchants.select do |merchant|
      data = net_invoices(merchant.id)
      z_score(data, average_invoices_per_merchant, std_deviation) < -2
    end
  end

  def average_daily_invoices
    average(invoices.size, 7)
  end

  def find_days
    data = invoices.group_by(&:weekday_created)
    data.each_key { |day| data[day] = data[day].size }
  end

  def std_deviation_daily_invoices
    standard_deviation(find_days.invert, average_daily_invoices)
  end

  def top_days_by_invoice_count
    find_days.select do |_k, invoice|
      z_score(invoice, average_daily_invoices, std_deviation_daily_invoices) > 1
    end.keys
  end

  def invoice_status(status)
    data = invoices.select { |invoice| invoice.status == status }.size
    ((data.to_f / invoices.size) * 100).round(2)
  end
end
