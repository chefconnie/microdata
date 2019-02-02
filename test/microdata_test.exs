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
          },
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/logo"]),
                value: "https://static.seriouseats.com/1/braestar/live/img/logo-color-240x190.png"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://www.facebook.com/seriouseats"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://twitter.com/seriouseats"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://plus.google.com/+seriouseats/posts"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://pinterest.com/seriouseats"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://instagram.com/seriouseats/"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://www.youtube.com/user/SeriousEats"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/url"]),
                value: "https://www.seriouseats.com"
              }
            ],
            types: MapSet.new(["http://schema.org/Organization"])
          },
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
                      value: "https://www.seriouseats.com/recipes/"
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
                      value: "https://www.seriouseats.com/recipes/topics/ingredient"
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
                      value:
                        "https://www.seriouseats.com/recipes/topics/ingredient/meats-and-poultry"
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
                      value:
                        "https://www.seriouseats.com/recipes/topics/ingredient/meats-and-poultry/other-meats"
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
                names: MapSet.new(["http://schema.org/itemListElement"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/item"]),
                      value: "https://www.seriouseats.com/recipes/"
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
                      value: "https://www.seriouseats.com/recipes/topics/meal"
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
                      value: "https://www.seriouseats.com/recipes/topics/meal/mains"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/position"]),
                      value: 3
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
                names: MapSet.new(["http://schema.org/itemListElement"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/item"]),
                      value: "https://www.seriouseats.com/recipes/"
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
                      value: "https://www.seriouseats.com/recipes/topics/method"
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
                      value: "https://www.seriouseats.com/recipes/topics/method/sous-vide"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/position"]),
                      value: 3
                    }
                  ],
                  types: MapSet.new(["http://schema.org/ListItem"])
                }
              }
            ],
            types: MapSet.new(["http://schema.org/BreadcrumbList"])
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

  @tag runnable: true
  describe "mixed & nested annotations" do
    @recipe_url "https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/"
    @recipe_file "./test/_cache/html-recipe-with-ld-and-nesting.html"

    setup do
      doc = %Microdata.Document{
        items: [
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/about/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "About"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/welcome-to-fooduzzi/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Start Here"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/food/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Recipes"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/food-index/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Recipe Index"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/breakfast/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Breakfast"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/oats/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Oats"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/smoothies/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Smoothies"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/appetizers/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Appetizers"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/entree/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Entree"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/salad/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Salad"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/sandwiches/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Sandwiches"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/soup/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Soup"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/sauces/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Sauces"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/snack/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Snack"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/dessert/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Dessert"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: ""
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Dietary Restriction"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/vegan/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Vegan"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/glutenfree/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Gluten Free"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/vegetarian/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Vegetarian"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/how-tos/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Kitchen How-Tos"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/favorites/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Favorites"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/favorites/alexa-favorites/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Alexa Favorites"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/favorites/reader-favorites/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Reader Favorites"
              }
            ],
            types: MapSet.new(["https://schema.org/SiteNavigationElement"])
          },
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/life/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Life"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/category/life/travel/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Vegan Travel"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: "https://www.fooduzzi.com/work-with-me/"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Work with Me"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/url"]),
                value: ""
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/name"]),
                value: "Contact"
              }
            ],
            types: MapSet.new(["https://schema.org/SiteNavigationElement"])
          },
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/name"]),
                value: "Hemp Heart Tabouli"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/author"]),
                value: "Fooduzzi"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/url"]),
                value: "https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/image"]),
                value:
                  "https://www.fooduzzi.com/wp-content/uploads/2018/08/hemp-heart-tabouli-7.jpg"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/prepTime"]),
                value: "10m"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeYield"]),
                value: "serves 4-6"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/totalTime"]),
                value: "0h 10m"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/description"]),
                value:
                  "A simple, no-cook vegan tabouli made with hemp hearts! A protein- and nutrient-packed snack, lunch, or side!"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "2 cups packed parsley, minced"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "5 large mint leaves, minced"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1/2 cup hemp hearts"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "juice of 1-2 small lemons"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 roma tomato, chopped"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 large green onion, minced"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1/4 large english cucumber, chopped"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1/4 tsp. allspice, optional for toasty flavor"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "1 Tbsp. olive oil"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeIngredient"]),
                value: "salt + pepper"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/recipeInstructions"]),
                value:
                  "Mix all of your ingredients in a medium bowl. Season with salt and pepper to taste and enjoy!"
              }
            ],
            types: MapSet.new(["http://schema.org/Recipe"])
          },
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/headline"]),
                value: "Fooduzzi"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/description"]),
                value: "the plant-based food blog"
              }
            ],
            types: MapSet.new(["https://schema.org/WPHeader"])
          },
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/headline"]),
                value: "Hemp Heart Tabouli"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/datePublished"]),
                value: "August 20, 2018"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/author"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["https://schema.org/url"]),
                      value: "https://www.fooduzzi.com/author/peduzziagmail-com/"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["https://schema.org/name"]),
                      value: "Alexa [fooduzzi.com]"
                    }
                  ],
                  types: MapSet.new(["https://schema.org/Person"])
                }
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/text"]),
                value:
                  "If you have a garden that is totally overgrown with parsley, mint, and tomatoes, this recipe is for you! This recipe is  also for you if you’re a fan of delicious flavor. (name that show) I. Love. Tabouli. Or tabbouleh. However you spell it, I love it. There’s a fabulous Mediterranean restaurant chain here in Pittsburgh (Aladdin’s), and they have the best tabouli ever. They add it to this salad that I  swear I’m not going to get again every time I go. But alas, I end up ordering it again and it never ever ever disappoints. Tabouli is typically made with bulgur wheat, buuuut I wanted to lay off the wheat a bit. I’ve been eating a ton of wheat in the form of bread, pizza, and pasta recently. Not like it’s a bad thing in moderation. But I am desperately missing some moderation in my life. And because I’ve been working out more recently, I’ve been looking for ways to increase my protein intake. And one of my favorite plant-based protein sources is…the hemp heart! So, uh, what are hemp hearts? Fab question, my dear. They are the creamy, nutty, delicious little seeds from the hemp plant! Yes , that hemp plant.  No , they won’t get you high. You can actually buy them in pretty much any grocery store. Typically over by the oats / cereals or over by the nuts and seeds. But they’re awesome. 3 Tbsp. of hemp hearts have 10g protein. Plus omega-3s and omega-6s for healthy hearts and brains, iron, manganese, thiamine, and lots of other goodness. They’re a cute little nutritional powerhouse, and they’re delicious in this tabouli. But honestly, how could they  not be delicious in this tabouli when there are ingredients like copious amounts of parsley, a bit of mint, some lemon juice, a bit of veggies, and a wee bit of seasoning? This is the kind of dish that just  shines in its simplicity. It’s stupidly simple, but ridiculously flavorful and addictive. Wahoo! I highly suggest enjoying this tabouli in salads , on cheese plates , with crackers , in pitas, or on its own with a fork or spoon. I love it. You’ll love it. I know it. Hemp Heart Tabouli From Fooduzzi at https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/ https://www.fooduzzi.com/wp-content/uploads/2018/08/hemp-heart-tabouli-7.jpg Prep: 10m Yield: serves 4-6 Total: 0h 10m A simple, no-cook vegan tabouli made with hemp hearts! A protein- and nutrient-packed snack, lunch, or side! You'll Need... 2 cups packed parsley, minced 5 large mint leaves, minced 1/2 cup hemp hearts juice of 1-2 small lemons 1 roma tomato, chopped 1 large green onion, minced 1/4 large english cucumber, chopped 1/4 tsp. allspice, optional for toasty flavor 1 Tbsp. olive oil salt + pepper Directions Mix all of your ingredients in a medium bowl. Season with salt and pepper to taste and enjoy! Generated with ♥︎ by Matcha Print Join the Fooduzzi Fam! I'll send you healthy takes on classic recipes, delectable recipe roundups, and more updates on my growing blog. You'll also receive a free eCookbook featuring my best recipes! Send me healthy recipes! Check your email to confirm and to download your free eCookbook!"
              }
            ],
            types: MapSet.new(["https://schema.org/CreativeWork"])
          },
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/potentialAction"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["https://schema.org/query-input"]),
                      value: ""
                    },
                    %Microdata.Property{
                      names: MapSet.new(["https://schema.org/target"]),
                      value: "https://www.fooduzzi.com/?s={s}"
                    }
                  ],
                  types: MapSet.new(["https://schema.org/SearchAction"])
                }
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/image"]),
                value:
                  "https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/popcorn-2-150x150.jpg"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/headline"]),
                value: "Lately"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/image"]),
                value:
                  "https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/vegan-buffalo-tofu-tacos-3-150x150.jpg"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/headline"]),
                value: "Vegan Buffalo Tofu Tacos"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/image"]),
                value:
                  "https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/homemade-whole-wheat-flour-tortillas-7-150x150.jpg"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/headline"]),
                value: "Homemade Whole Wheat Tortillas"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/image"]),
                value:
                  "https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/easy-baked-buffalo-tofu-2-150x150.jpg"
              },
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/headline"]),
                value: "Easy Baked Buffalo Tofu"
              }
            ],
            types: MapSet.new(["https://schema.org/WPSideBar"])
          },
          %Microdata.Item{
            id: nil,
            properties: [
              %Microdata.Property{
                names: MapSet.new(["https://schema.org/comment"]),
                value: %Microdata.Item{
                  id: nil,
                  properties: [
                    %Microdata.Property{
                      names: MapSet.new(["https://schema.org/author"]),
                      value: %Microdata.Item{
                        id: nil,
                        properties: [
                          %Microdata.Property{
                            names: MapSet.new(["https://schema.org/name"]),
                            value: "Ben Myhre"
                          },
                          %Microdata.Property{
                            names: MapSet.new(["https://schema.org/url"]),
                            value: "https://ramshacklepantry.com/"
                          }
                        ],
                        types: MapSet.new(["https://schema.org/Person"])
                      }
                    },
                    %Microdata.Property{
                      names: MapSet.new(["https://schema.org/datePublished"]),
                      value: "August 20, 2018 at 3:51 PM"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["https://schema.org/url"]),
                      value: "https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/#comment-19606"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["https://schema.org/text"]),
                      value:
                        "This looks really good and interesting. I have never tried hemp hearts, but not I am going to have to give it a whirl. Remember to enjoy everything with moderation… even moderation. ;) Thanks for sharing with us!"
                    }
                  ],
                  types: MapSet.new(["https://schema.org/Comment"])
                }
              }
            ],
            types: MapSet.new(["https://schema.org/WebPage"])
          },
          %Microdata.Item{
            id: "#person",
            properties: [
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/name"]),
                value: "Alexa [fooduzzi.com]"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://www.facebook.com/pages/Fooduzzi/761543773962006"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://instagram.com/fooduzzi/"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://www.pinterest.com/fooduzzi/"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/sameAs"]),
                value: "https://twitter.com/fooduzzi"
              },
              %Microdata.Property{
                names: MapSet.new(["http://schema.org/url"]),
                value: "https://www.fooduzzi.com/"
              }
            ],
            types: MapSet.new(["http://schema.org/Person"])
          },
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
                      value: "https://www.fooduzzi.com/"
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
                      value: "https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/"
                    },
                    %Microdata.Property{
                      names: MapSet.new(["http://schema.org/position"]),
                      value: 2
                    }
                  ],
                  types: MapSet.new(["http://schema.org/ListItem"])
                }
              }
            ],
            types: MapSet.new(["http://schema.org/BreadcrumbList"])
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
end
