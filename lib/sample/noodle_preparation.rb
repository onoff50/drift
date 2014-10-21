include Drift
class AddWater < Drift::BaseActivity
  def self.do_execute(context)
    context['water']= 'Added 2 cups water to the recipe'
  end
end

class AddNoodles < Drift::BaseActivity
  def self.do_execute(context)
    context['noodles']= 'Added maggie noodles'
  end
end

class AddSpices < Drift::BaseActivity
  def self.do_execute(context)
    context['spices']= 'Add maggie ingredients'
  end
end

class CookForFiveMins < Drift::BaseActivity
  def self.do_execute(context)
    context['cook']= 'Cook on gas for five minutes'
  end
end

class NoodlePreparation < BaseAct

  #
  # actor definition
  a1 = single_actor AddWater
  a2 = single_actor AddNoodles
  a3 = single_actor AddSpices
  a4 = single_actor CookForFiveMins

  #
  # actor registration
  NoodlePreparation.start = a1
  NoodlePreparation.register_actors a1, a2, a3, a4

  #
  # next actor registration
  a1.register_next a2
  a2.register_next a3
  a3.register_next a4

end