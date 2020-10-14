require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase
  attr_reader :promotional_rules, :co

  def setup
    @promotional_rules = PromotionalRule.all
  end

  def test_product_totals
    baskets = [
      %w[001 002 003],
      %w[001 003 001],
      %w[001 002 001 003]
    ]

    expected = [
      66.78,
      36.95,
      73.76
    ]

    baskets.each_with_index do |basket, idx|
      @co = Checkout.new(promotional_rules)
      assert_equal expected[idx], get_total(basket)
    end
  end

  private

  def get_total(basket)
    basket.each do |item|
      co.scan(item)
    end

    co.total
  end
end
