#encoding: utf-8
module ProductsHelper
	def show_product_cate(active_cate, product_cate)
		if product_cate == active_cate
			"<li class ='active'>#{ product_cate.name }</li>".html_safe
		else
			"<li>#{ link_to( product_cate.name, product_cate_path(product_cate.id) ) }</li>".html_safe
		end
	end

	def no_products_msg(count)
		if(count == 0)
			"<p>分類底下無商品</p>".html_safe
		end
	end

	def show_price_for_sale(price_for_sale)
		if(price_for_sale > 0)
			"折扣價：#{ price_for_sale } <br>".html_safe
		end
	end

	def get_change_status_name(product)
		case product.status
		when "disable"
			"重新上架"
		when "enable"
			"物品下架"
		end	
	end
end
