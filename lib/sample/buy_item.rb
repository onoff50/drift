include Drift

class AddItemToCart < BaseActivity
  def self.do_execute(context)
    context['quantity'] = context['quantity']
    context['total_amount'] = context['selling_price'] * context['quantity']
  end
end

class Checkout < BaseActivity
  def self.do_execute(context)
    context['checkout'] = true
  end
end

class ApplyOffer < BaseActivity
  def self.do_execute(context)
    discount = context['discount_percentage'] * context['total_amount']
    context['discount'] = discount
    context['payable_amount'] = context['total_amount'] - discount
  end
end

class GetPaymentMethod < BaseActivity
  def self.do_execute(context)
    payment_methods = ['GIFTVOUCHER', 'NETBANKING', 'CREDITCARD', 'OTHER']
    context['payment_method'] = payment_methods[Random.rand(10) % 4]
  end
end


class CreditCardOffer < BaseActivity
  def self.do_execute(context)
    context['discount_percentage'] = 0.2
  end
end

class GiftVoucherOffer < BaseActivity
  def self.do_execute(context)
    context['discount_percentage'] = 0.05
  end
end

class NetBankingOffer < BaseActivity
  def self.do_execute(context)
    context['discount_percentage'] = 0.1
  end
end

class NoOffer < BaseActivity
  def self.do_execute(context)
    context['discount_percentage'] = 0
  end
end

class DefaultOffer < BaseActivity
  def self.do_execute(context)
    context['default_offer'] = true
  end
end

class CheckPaymentMethod < BaseCondition
  def self.eval_condition(context)
    context['payment_method']
  end
end


class BuyItem < BaseAct
  add_to_cart = single_actor(AddItemToCart)
  checkout = single_actor(Checkout)
  get_offer = switch_actor(CheckPaymentMethod)
  gift_voucher = single_actor(GiftVoucherOffer)
  net_banking = single_actor(NetBankingOffer)
  credit_card = single_actor(CreditCardOffer)
  no_offer = single_actor(NoOffer)
  default_offer = single_actor(DefaultOffer)
  apply_offer = single_actor(ApplyOffer)

  self.start = add_to_cart
  self.register_actors(add_to_cart, checkout, get_offer, gift_voucher, net_banking, credit_card, no_offer, default_offer, apply_offer)

  add_to_cart.register_next(checkout)
  checkout.register_next(get_offer)

  get_offer.register_next(gift_voucher, 'GIFTVOUCHER')
  get_offer.register_next(net_banking, 'NETBANKING')
  get_offer.register_next(credit_card, 'CREDIT_CARD')
  get_offer.register_next(no_offer, 'OTHER')
  get_offer.register_next(default_offer)

  gift_voucher.register_next(apply_offer)
  net_banking.register_next(apply_offer)
  credit_card.register_next(apply_offer)
  no_offer.register_next(apply_offer)

end

# context = BaseContext.new({'selling_price' => 100, 'quantity' => 1})
# BuyItem.execute context