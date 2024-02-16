module ProductsHelper
  def product_order_by_keys
    Product::ORDER_BY.keys.map {|order| [t(".#{order}"), order]}
  end
end