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

  first_actor = single_actor(AddWater)
  a2 = single_actor(AddNoodles)
  a3 = single_actor(AddSpices)
  a4 = single_actor(CookForFiveMins)

  first_actor.register_next(a2)
  a2.register_next(a3 )
  a3.register_next(a4 )

end