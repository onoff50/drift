include Drift
class AddWater < Drift::BaseActivity

  def self.do_execute(context)
    context.add('water', 'Added 2 cups water to the recipe')
  end
end

class AddNoodles < Drift::BaseActivity
  def self.do_execute(context)
    context.add('noodles', 'Added maggie noodles')
  end
end

class AddSpices < Drift::BaseActivity
  def self.do_execute(context)
    context.add('spices', 'Add maggie ingredients')
  end
end

class CookForFiveMins < Drift::BaseActivity
  def self.do_execute(context)
    context.add('cook', 'Cook on gas for five minutes')
  end
end

class NoodlePreparation < BaseAct

  a1 = single_actor(AddWater, self.name, 0)
  a2 = single_actor(AddNoodles, self.name, 1)
  a3 = single_actor(AddSpices, self.name, 2)
  a4 = single_actor(CookForFiveMins, self.name, 3)

  @actors = {
      :start => a1,
      0 => {:next_actor_map => {:default => a2}},
      1 => {:next_actor_map => {:default => a3}},
      2 => {:next_actor_map => {:default => a4}}
  }

end