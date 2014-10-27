Spree::OrderContents.class_eval do

  durably_decorate :grab_line_item_by_variant, mode: 'soft', sha: '5606323a3e50e650b2ad1a51c43ba54ebc469b72' do |variant, *args|
    raise_error = args[0]             || false
    ad_hoc_option_value_ids = args[1] || []
    product_customizations = args[2]  || []

    if variant.product.is_gift_card?
      line_item = nil
    else
      line_item = order.find_line_item_by_variant(variant, ad_hoc_option_value_ids, product_customizations)
    end

    if !line_item.present? && raise_error
      raise ActiveRecord::RecordNotFound, "Line item not found for variant #{variant.sku}"
    end

    line_item
  end

end
