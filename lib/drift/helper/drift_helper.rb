module DriftHelper

  def single_actor(activity, async = false)
    SingleActor.new(activity, generate_id, async)
  end

  def switch_actor(condition, async = false)
    SwitchActor.new(condition, generate_id, async)
  end

  private
  def generate_id
    t = Time.now.utc
    time = t.strftime('%Y%m%d-%H%M%S')

    x = "#{rand}!#{time}"
    Digest::MD5.hexdigest(x)
  end

end