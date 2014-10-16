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

  a1 = single_actor(AddWater, self.name, 0)
  a2 = single_actor(AddNoodles, self.name, 1)
  a3 = single_actor(AddSpices, self.name, 2)
  a4 = single_actor(CookForFiveMins, self.name, 3)

  NoodlePreparation.start = a1
  NoodlePreparation.register_actors a1, a2, a3, a4

  a1.register_next_actor a2
  a2.register_next_actor a3
  a3.register_next_actor a4

end