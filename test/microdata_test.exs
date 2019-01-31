defmodule MicrodataTest do
  use ExUnit.Case, async: true
  doctest Microdata, except: [parse: 1]

  describe "tag annotations" do
    @recipe_url "https://www.seriouseats.com/recipes/2010/09/sous-vide-101-duck-breast-recipe.html"
    @recipe_file "./test/_cache/recipe.html"

    setup do
      doc = %Microdata.Document{
        items: [
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/headline"]),
                value: "Sous Vide 101: Duck Breast Recipe"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/name"]),
                value: "Sous Vide 101: Duck Breast Recipe"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/image"]),
                value: "https://www.seriouseats.com/recipes/images/20100910-duck-27.jpg"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/description"]),
                value:
                  "This recipe requires the use of a sous-vide cooker or the beer cooler hack . As a meat that is best served medium rare, duck breast makes an ideal candidate to cook sous-vide. By cooking it at 130°F for two hours, much of the fat under the skin begins to soften and render out while the proteins in it begin to set, making it easier to crisp without shrinking on the stovetop just before serving. The thickness of the skin means that you can also crisp it more gently post sous-viding, unlike a steak which requires blazing high heat to cut back on cooking time and prevent the interior from overcooking. The skin acts as an insulator, preventing the meat inside from taking on any more color. The result is supremely tender, evenly cooked meat with super crisp skin. For best results, I like to season the breasts and let them sit uncovered in the fridge at least overnight to allow some moisture to evaporate and concentrate its duckiness. Isn't that just ducky? Fruity sauces and some steamed greens round out the dish. Try the lingonberry jam from IKEA. It's splendid."
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeYield"]),
                value: "Serves 4"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/aggregateRating"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/reviewCount"]),
                      value: "6"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/ratingValue"]),
                      value: "5"
                    }
                  ],
                  types: MapSet.new(["http://schema.org/AggregateRating"])
                }
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "4 boneless duck breasts (about 5 to 6 ounces each; 150-175g)"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "Kosher salt and freshly cracked black pepper"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeInstructions"]),
                value:
                  "1. Season duck generously with salt and pepper. For best results, place on a plate and refrigerate uncovered overnight before proceeding. 2. Seal duck in vacuum bags. Place in 130°F (54°C) water bath for at least 45 minutes and up to 4 hours. Remove from bags and dry thoroughly with paper towels. 3. Place breasts skin side-down in heavy-bottomed 12-inch non-stick or cast iron skillet and set over high heat until sizzling, about 2 minutes. Reduce heat to medium and cook, moving and pressing breasts to ensure good contact between skin and pan until golden brown and crisp, about 5 minutes. Flip and cook second side until barely colored, about 30 seconds. Transfer to paper towel-lined plate and allow to rest for 5 minutes. 4. Slice breasts crosswise into 1/2-inch strips and serve."
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/author"]),
                value: "J. Kenji López-Alt"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/keywords"]),
                value: "duck entrees poultry sous vide sous vide 101 valentine's day entrees"
              }
            ],
            types: MapSet.new(["http://schema.org/Recipe"])
          }
        ]
      }

      {:ok, doc: doc}
    end

    test "converts from text", %{doc: doc} do
      assert @recipe_file |> File.read!() |> Microdata.parse() == {:ok, doc}
    end

    test "converts from file", %{doc: doc} do
      assert Microdata.parse(file: @recipe_file) == {:ok, doc}
    end

    @tag :remote
    test "converts from url", %{doc: doc} do
      assert Microdata.parse(url: @recipe_url) == {:ok, doc}
    end
  end

  describe "json-ld annotations" do
    @recipe_url "https://food52.com/recipes/22467-rao-s-meatballs"
    @recipe_file "./test/_cache/ld-recipe.html"

    setup do
      doc = %Microdata.Document{
        items: [
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/aggregateRating"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/ratingCount"]),
                      value: "4"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/ratingValue"]),
                      value: "5.0"
                    }
                  ],
                  types: MapSet.new()
                }
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/author"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/name"]),
                      value: "Genius Recipes"
                    }
                  ],
                  types: MapSet.new(["http://schema.org/Person"])
                }
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/commentCount"]),
                value: 125
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/cookTime"]),
                value: "PT0H30M"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/datePublished"]),
                value: "2013-06-11 11:34:23 -0400"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/description"]),
                value:
                  "Spaghetti and meatballs doesn&#39;t have to be a meal that you slave over and simmer all day, nor does it need to put you into hibernation once you&#39;ve eaten it. You can mix, shape, and fry these meatballs in exactly the time it takes for Marcella Hazan&#39;s tomato, butter, and onion sauce to cook (or even this 20-minute marinara, if you&#39;re really fast). The caveats: 1. Make your own fresh breadcrumbs (i.e. grind up some stale bread) or, if your crumbs are purchased and quite fine, cut back by half, and don&#39;t use quite as much water. I can&#39;t be responsible for your stiff, mealy dumpling-balls if you don&#39;t heed this. 2. Use local, pastured, not very lean meats if at all possible. Good flavor and fat go a long way here. Adapted slightly from Rao&#39;s Cookbook by Frank Pellegrino (Random House, 1998)"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/image"]),
                value:
                  "https://images.food52.com/iqN_Jo1Q92Xb_3eWb9-fEQYqPJQ=/1200x1200/cc489969-9927-48b9-87bd-7c360d6ac2bb--2013-0611_genius-meatballs-013.jpg"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/image"]),
                value:
                  "https://images.food52.com/K6W36E3fRvRUbAVqS6T9MYT5WpY=/1200x900/cc489969-9927-48b9-87bd-7c360d6ac2bb--2013-0611_genius-meatballs-013.jpg"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/image"]),
                value:
                  "https://images.food52.com/EOpCnydvgYDpMa2umb8Fp3ynuNg=/1200x675/cc489969-9927-48b9-87bd-7c360d6ac2bb--2013-0611_genius-meatballs-013.jpg"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/keywords"]),
                value:
                  "Beef, Pasta, Make Ahead, Serves a Crowd, Spring, Summer, Fall, Winter, Christmas, Father&#39;s Day, Valentine&#39;s Day, Meatball, Parsley, Pork, Fry"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/mainEntityOfPage"]),
                value: "https://food52.com/recipes/22467-rao-s-meatballs"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/name"]),
                value: "Rao&#39;s Meatballs"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/prepTime"]),
                value: "PT0H15M"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeCategory"]),
                value: "Entree"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeCuisine"]),
                value: "Italian"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 pound lean ground beef"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1/2 pound ground veal"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1/2 pound ground pork"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "2 large eggs"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 cup freshly grated Pecorino Romano cheese"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 1/2 tablespoons chopped Italian parsley"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1/2 small clove garlic, peeled and minced"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 pinch Kosher or sea salt, to taste"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 pinch Freshly ground pepper, to taste"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "2 cups fresh bread crumbs"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "2 cups lukewarm water"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 cup good quality olive oil, for cooking"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value:
                  " Your favorite marinara sauce (we like Marcella Hazan\\'s Tomato Sauce with Onion and Butter, also on Food52)"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeInstructions"]),
                value:
                  "Combine beef, veal, and pork in a large bowl. Add the eggs, cheese, parsley, garlic, and salt and pepper to taste. Using your hands, blend ingredients together. Blend bread crumbs into meat mixture. Slowly add water, 1 cup at a time, until the mixture is quite moist. Shape into 2 1/2 to 3-inch balls.\nHeat oil in a large sauté pan. When oil is very hot but not smoking, fry meatballs in batches. When the bottom half of the meatball is very brown and slightly crisp, turn and cook top half. Remove from heat and drain on paper towels.\nLower cooked meatballs into simmering marinara sauce and cook for 15 minutes. Serve alone or with pasta.\n"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeYield"]),
                value: "Makes 28 meatballs"
              }
            ],
            types: MapSet.new(["http://schema.org/Recipe"])
          }
        ]
      }

      {:ok, doc: doc}
    end

    test "converts from text", %{doc: doc} do
      assert @recipe_file |> File.read!() |> Microdata.parse() == {:ok, doc}
    end

    test "converts from file", %{doc: doc} do
      assert Microdata.parse(file: @recipe_file) == {:ok, doc}
    end

    @tag :remote
    test "converts from url", %{doc: doc} do
      assert Microdata.parse(url: @recipe_url) == {:ok, doc}
    end
  end

  describe "json-ld annotations with top-level arrays" do
    @recipe_url "https://www.foodandwine.com/recipes/mango-fool"
    @recipe_file "./test/_cache/ld-array-recipe.html"

    setup do
      doc = %Microdata.Document{
        items: [
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/itemListElement"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/item"]),
                      value: "https://www.foodandwine.com"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/position"]),
                      value: 1
                    }
                  ],
                  types: MapSet.new(["http://schema.org/ListItem"])
                }
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/itemListElement"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/item"]),
                      value: "https://www.foodandwine.com/fruits"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/position"]),
                      value: 2
                    }
                  ],
                  types: MapSet.new(["http://schema.org/ListItem"])
                }
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/itemListElement"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/item"]),
                      value: "https://www.foodandwine.com/fruits/tropical-fruit"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/position"]),
                      value: 3
                    }
                  ],
                  types: MapSet.new(["http://schema.org/ListItem"])
                }
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/itemListElement"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/item"]),
                      value: "https://www.foodandwine.com/fruits/tropical-fruit/mango"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/position"]),
                      value: 4
                    }
                  ],
                  types: MapSet.new(["http://schema.org/ListItem"])
                }
              }
            ],
            types: MapSet.new(["http://schema.org/BreadcrumbList"])
          },
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/aggregateRating"]),
                value: nil
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/author"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/name"]),
                      value: "Ian Knauer"
                    }
                  ],
                  types: MapSet.new(["http://schema.org/Person"])
                }
              },
              %Microdata.Property{names: MapSet.new(["http://schema.org/cookTime"]), value: nil},
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/datePublished"]),
                value: "2016-06-02T20:35:36.000Z"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/description"]),
                value:
                  "With only five ingredients—puréed mango, yogurt, cream, sugar and salt—this refreshing dessert is a breeze to whip up. Make a batch ahead of time and pull it out of the fridge right before serving.\r\n\r\nSlideshow: More Mango Recipes"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/image"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/caption"]),
                      value: ""
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/height"]),
                      value: 412
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/url"]),
                      value:
                        "https://cdn-image.foodandwine.com/sites/default/files/styles/4_3_horizontal_-_1200x900/public/2014-r-xl-mango-fool.jpg?itok=yYy2aqi5"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/width"]),
                      value: 550
                    }
                  ],
                  types: MapSet.new(["http://schema.org/ImageObject"])
                }
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/mainEntityOfPage"]),
                value: "https://www.foodandwine.com/recipes/mango-fool"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/name"]),
                value: "Mango Fool"
              },
              %Microdata.Property{names: MapSet.new(["http://schema.org/nutrition"]), value: nil},
              %Microdata.Property{names: MapSet.new(["http://schema.org/prepTime"]), value: nil},
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeCategory"]),
                value: ""
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeCuisine"]),
                value: ""
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 cup pureed mango\r\n"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1/2 cup whole milk yogurt\r\n"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "3/4 cup heavy cream\r\n"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "2 tablespoons sugar\r\n"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "Kosher salt\r\n"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeInstructions"]),
                value:
                  "In a medium bowl, whisk together 3/4 cup of the pureed mango and yogurt. In a separate bowl, whisk the cream with the sugar and salt until it just hold stiff peaks. Fold the cream into the mango mixture. Divide the fool between 4 (4-to 5-ounce) glasses and chill until stiff, 1 hour. Divide the reserved 4 tablespoons mango puree between the glasses and serve."
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeYield"]),
                value: "Serves : 4\r\n"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/totalTime"]),
                value: "PT60M"
              },
              %Microdata.Property{names: MapSet.new(["http://schema.org/video"]), value: nil}
            ],
            types: MapSet.new(["http://schema.org/Recipe"])
          }
        ]
      }

      {:ok, doc: doc}
    end

    test "converts from text", %{doc: doc} do
      assert @recipe_file |> File.read!() |> Microdata.parse() == {:ok, doc}
    end

    test "converts from file", %{doc: doc} do
      assert Microdata.parse(file: @recipe_file) == {:ok, doc}
    end

    @tag :remote
    test "converts from url", %{doc: doc} do
      assert Microdata.parse(url: @recipe_url) == {:ok, doc}
    end
  end

  describe "no annotations" do
    @empty_file "./test/_cache/empty.html"

    test "returns an error tuple for documents with no items" do
      assert Microdata.parse(file: @empty_file) ==
               {:error,
                %Microdata.Error{
                  type: :document,
                  reason: :no_items,
                  metadata: %{input: File.read!(@empty_file)}
                }}
    end
  end
end
