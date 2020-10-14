class PromotionalRule < ApplicationRecord
  DISCOUNT_TYPES = {
    percentage: 'percentage',
    fixed_new_price: 'fixed_price'
  }.freeze

  belongs_to :product, optional: true

  attr_reader :promotional_rules, :items

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
  end

  def apply_rules(product, item)
    promotional_rules.where(product: product).each do |rule|
      item[:total] = price_after_rule(rule, item).round(2)
    end

    item[:total]
  end

  private

  def price_after_rule(rule, item)
    return item[:total] unless apply_rule?(rule, item)

    price = item[:total]

    case rule.discount_type
    when DISCOUNT_TYPES[:percentage]
      return price * rule.discount_amount
    when DISCOUNT_TYPES[:fixed_price]
      return price - (item[:count] * rule.discount_amount)
    else
      return price
    end
  end

  def apply_rule?(rule, item)
    if rule.product_amount.present?
      return true if item[:count] >= rule.product_amount
    end

    if rule.price_amount.present?
      return true if item[:total] >= rule.price_amount
    end
  end
end
