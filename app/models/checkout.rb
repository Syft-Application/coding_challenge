class Checkout
  attr_reader :promotional_rule, :promotional_rules, :items, :total_price

  def initialize(promotional_rules)
    @promotional_rule = PromotionalRule.new(promotional_rules)
    @promotional_rules = promotional_rules
    @items = {}
  end

  def scan(item)
    add_item(item)

    calculate_price(item)
  end

  def total
    count = 0
    total_amount = 0

    items.map { |_, v| total_amount += v[:total]; count += v[:count] }

    total = {
      count: count,
      total: total_amount
    }

    total = promotional_rule.apply_rules(nil, total)
    
    total.round(2)
  end

  private

  def calculate_price(product_code)
    product = Product.find_by!(product_code: product_code)

    items[product_code][:total] = items[product_code][:count] * product.price

    items[product_code][:total] = promotional_rule
      .apply_rules(
        product, items[product_code]
      )
  end

  def add_item(product_code)
    items[product_code] ||= { count: 0 }

    item_amount = items[product_code][:count] + 1

    items[product_code][:count] = item_amount
  end
end