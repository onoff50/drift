
require File.expand_path(File.dirname(__FILE__) + '/../base_drift_test')


class BuyItemTest < BaseDriftTest

  setup do
    @context = BaseContext.new({'selling_price' => 100, 'quantity' => 1, 'payment_method' => 'CREDIT_CARD'})
  end

  def xtest_all_actors_called
    AddItemToCart.expects(:perform)
    Checkout.expects(:perform)
    ApplyOffer.expects(:perform)
    BuyItem.execute(@context)
  end

  def test_credit_card_offer
    BuyItem.execute(@context)
    assert_equal 0.2, @context['discount_percentage']
    assert_true @context['checkout']
    assert_equal 80, @context['payable_amount']
  end

  def test_netbanking_offer
    @context['payment_method'] = 'NETBANKING'
    BuyItem.execute(@context)
    assert_equal 0.1, @context['discount_percentage']
    assert_true @context['checkout']
    assert_equal 90, @context['payable_amount']
  end

  def test_giftvoucher_offer
    @context['payment_method'] = 'GIFTVOUCHER'
    BuyItem.execute(@context)
    assert_equal 0.05, @context['discount_percentage']
    assert_true @context['checkout']
    assert_equal 95, @context['payable_amount']
  end

  def test_other_offer
    @context['payment_method'] = 'OTHER'
    BuyItem.execute(@context)
    assert_equal 0, @context['discount_percentage']
    assert_true @context['checkout']
    assert_equal 100, @context['payable_amount']
  end

end