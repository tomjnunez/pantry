class Pantry
  attr_reader :stock, :shopping_list
  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)

  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, quantity)
    @stock[item] += quantity
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |item, quantity|
      @shopping_list[item] += quantity
    end
  end

  def print_shopping_list
    list = []
    @shopping_list.each do |item, amount|
      #ugh i forget what I need to do here
    end
  end
end
