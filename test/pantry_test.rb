require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_stock_starts_empty
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
  end

  def test_items_not_in_stock_equal_zero
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_items_can_be_restocked
    pantry = Pantry.new
    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_it_will_add_to_current_amount
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    pantry.restock("Cheese", 20)

    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_it_starts_with_empty_shopping_list
    pantry = Pantry.new

    assert_equal ({}), pantry.shopping_list
  end

  def test_it_can_add_dish_to_shopping_list
    pantry = Pantry.new
    recipe = Recipe.new("Cheese Pizza")
    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(recipe)

    expected = {"Cheese" => 20, "Flour" => 20}

    assert_equal expected, pantry.shopping_list
  end

  def test_it_can_add_multiple_recipes
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)

    recipe_2 = Recipe.new("Spaghetti")
    recipe_2.add_ingredient("Spaghetti Noodles", 10)
    recipe_2.add_ingredient("Marinara Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(recipe_1)
    pantry.add_to_shopping_list(recipe_2)

    expected = {
      "Cheese" => 25,
      "Flour" => 20,
      "Spaghetti Noodles" => 10,
      "Marinara Sauce" => 10
    }
    assert_equal expected, pantry.shopping_list
  end

  def test_it_returns_shopping_list_properly
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)

    recipe_2 = Recipe.new("Spaghetti")
    recipe_2.add_ingredient("Spaghetti Noodles", 10)
    recipe_2.add_ingredient("Marinara Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(recipe_1)
    pantry.add_to_shopping_list(recipe_2)
    
    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    assert_equal expected, pantry.print_shopping_list
  end
end
