defmodule MicrodataTest do
  use ExUnit.Case, async: true
  doctest Microdata, except: [parse: 1]

  describe "tag annotations" do
    @recipe_url "https://www.seriouseats.com/recipes/2010/09/sous-vide-101-duck-breast-recipe.html"
    @recipe_file "./test/_cache/recipe.html"

    setup do
      {:ok,
       doc: %Microdata.Document{
         items: [
           %Microdata.Item{
             id: nil,
             properties: [
               %Microdata.Property{
                 html:
                   "<meta itemprop=\"headline\" content=\"Sous Vide 101: Duck Breast Recipe\" />",
                 names: MapSet.new(["http://schema.org/headline"]),
                 value: "Sous Vide 101: Duck Breast Recipe"
               },
               %Microdata.Property{
                 html:
                   "<h1 class=\"title recipe-title fn\" itemprop=\"name\">Sous Vide 101: Duck Breast Recipe</h1>",
                 names: MapSet.new(["http://schema.org/name"]),
                 value: "Sous Vide 101: Duck Breast Recipe"
               },
               %Microdata.Property{
                 html:
                   "<img src=\"https://www.seriouseats.com/recipes/images/20100910-duck-27.jpg\" class=\"photo\" srcset=\"https://www.seriouseats.com/recipes/images/20100910-duck-27.jpg 610w, https://www.seriouseats.com/recipes/images/20100910-duck-27-300x225.jpg 300w, https://www.seriouseats.com/recipes/images/20100910-duck-27-200x150.jpg 200w\" itemprop=\"image\" alt=\"Sous Vide 101: Duck Breast Recipe\" data-pin-no-hover=\"true\" />",
                 names: MapSet.new(["http://schema.org/image"]),
                 value: "https://www.seriouseats.com/recipes/images/20100910-duck-27.jpg"
               },
               %Microdata.Property{
                 html:
                   "<div class=\"recipe-introduction-body\" itemprop=\"description\">\n              <p><small>This recipe requires the use of a sous-vide cooker or the <a href=\"https://www.seriouseats.com/2010/06/how-to-sous-vide-carrots-vegetables.html\">beer cooler hack</a>.</small></p>\n<p>As a meat that is best served medium rare, duck breast makes an ideal candidate to cook sous-vide. By cooking it at 130°F for two hours, much of the fat under the skin begins to soften and render out while the proteins in it begin to set, making it easier to crisp without shrinking on the stovetop just before serving.</p>\n<p>The thickness of the skin means that you can also crisp it more gently post sous-viding, unlike a steak which requires blazing high heat to cut back on cooking time and prevent the interior from overcooking. The skin acts as an insulator, preventing the meat inside from taking on any more color. <strong>The result is supremely tender, evenly cooked meat with super crisp skin.</strong></p>\n<p>For best results, I like to season the breasts and let them sit uncovered in the fridge at least overnight to allow some moisture to evaporate and concentrate its duckiness. Isn't that just ducky?</p>\n<p>Fruity sauces and some steamed greens round out the dish. Try the lingonberry jam from IKEA. It's splendid.</p>\n\n            </div>",
                 names: MapSet.new(["http://schema.org/description"]),
                 value:
                   "This recipe requires the use of a sous-vide cooker or the beer cooler hack . As a meat that is best served medium rare, duck breast makes an ideal candidate to cook sous-vide. By cooking it at 130°F for two hours, much of the fat under the skin begins to soften and render out while the proteins in it begin to set, making it easier to crisp without shrinking on the stovetop just before serving. The thickness of the skin means that you can also crisp it more gently post sous-viding, unlike a steak which requires blazing high heat to cut back on cooking time and prevent the interior from overcooking. The skin acts as an insulator, preventing the meat inside from taking on any more color. The result is supremely tender, evenly cooked meat with super crisp skin. For best results, I like to season the breasts and let them sit uncovered in the fridge at least overnight to allow some moisture to evaporate and concentrate its duckiness. Isn't that just ducky? Fruity sauces and some steamed greens round out the dish. Try the lingonberry jam from IKEA. It's splendid."
               },
               %Microdata.Property{
                 html: "<span class=\"info yield\" itemprop=\"recipeYield\">Serves 4</span>",
                 names: MapSet.new(["http://schema.org/recipeYield"]),
                 value: "Serves 4"
               },
               %Microdata.Property{
                 html:
                   "<span itemprop=\"aggregateRating\" class=\"info rating-value\" itemscope=\"\" itemtype=\"http://schema.org/AggregateRating\">5\n                      <meta itemprop=\"reviewCount\" content=\"6\" />\n                      <meta itemprop=\"ratingValue\" content=\"5\" />\n                    </span>",
                 names: MapSet.new(["http://schema.org/aggregateRating"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: "<meta itemprop=\"reviewCount\" content=\"6\" />",
                       names: MapSet.new(["http://schema.org/reviewCount"]),
                       value: "6"
                     },
                     %Microdata.Property{
                       html: "<meta itemprop=\"ratingValue\" content=\"5\" />",
                       names: MapSet.new(["http://schema.org/ratingValue"]),
                       value: "5"
                     }
                   ],
                   types: MapSet.new(["http://schema.org/AggregateRating"])
                 }
               },
               %Microdata.Property{
                 html:
                   "<li class=\"ingredient\" itemprop=\"recipeIngredient\">4 boneless duck breasts (about 5 to 6 ounces each; 150-175g)</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "4 boneless duck breasts (about 5 to 6 ounces each; 150-175g)"
               },
               %Microdata.Property{
                 html:
                   "<li class=\"ingredient\" itemprop=\"recipeIngredient\">Kosher salt and freshly cracked black pepper</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "Kosher salt and freshly cracked black pepper"
               },
               %Microdata.Property{
                 html:
                   "<ol class=\"recipe-procedures-list instructions\" itemprop=\"recipeInstructions\">\n                    <li class=\"recipe-procedure\">\n                      <div class=\"recipe-procedure-number checked\">1.</div>\n                      <div class=\"recipe-procedure-text\">\n                        <p></p><p>Season duck generously with salt and pepper. For best results, place on a plate and refrigerate uncovered overnight before proceeding.</p><p></p>\n                      </div>\n                    </li>\n                    <li class=\"recipe-procedure\">\n                      <div class=\"recipe-procedure-number \">2.</div>\n                      <div class=\"recipe-procedure-text\">\n                        <p></p><p>Seal duck in vacuum bags. Place in 130°F (54°C) water bath for at least 45 minutes and up to 4 hours. Remove from bags and dry thoroughly with paper towels.</p><p></p>\n                      </div>\n                    </li>\n                    <li class=\"recipe-procedure\">\n                      <div class=\"recipe-procedure-number \">3.</div>\n                      <div class=\"recipe-procedure-text\">\n                        <p></p><p>Place breasts skin side-down in heavy-bottomed 12-inch non-stick or cast iron skillet and set over high heat until sizzling, about 2 minutes. Reduce heat to medium and cook, moving and pressing breasts to ensure good contact between skin and pan until golden brown and crisp, about 5 minutes. Flip and cook second side until barely colored, about 30 seconds. Transfer to paper towel-lined plate and allow to rest for 5 minutes.</p><p></p>\n                      </div>\n                    </li>\n                    <li class=\"recipe-procedure\">\n                      <div class=\"recipe-procedure-number \">4.</div>\n                      <div class=\"recipe-procedure-text\">\n                        <p></p><p>Slice breasts crosswise into 1/2-inch strips and serve.</p><p></p>\n                      </div>\n                    </li>\n                </ol>",
                 names: MapSet.new(["http://schema.org/recipeInstructions"]),
                 value:
                   "1. Season duck generously with salt and pepper. For best results, place on a plate and refrigerate uncovered overnight before proceeding. 2. Seal duck in vacuum bags. Place in 130°F (54°C) water bath for at least 45 minutes and up to 4 hours. Remove from bags and dry thoroughly with paper towels. 3. Place breasts skin side-down in heavy-bottomed 12-inch non-stick or cast iron skillet and set over high heat until sizzling, about 2 minutes. Reduce heat to medium and cook, moving and pressing breasts to ensure good contact between skin and pan until golden brown and crisp, about 5 minutes. Flip and cook second side until barely colored, about 30 seconds. Transfer to paper towel-lined plate and allow to rest for 5 minutes. 4. Slice breasts crosswise into 1/2-inch strips and serve."
               },
               %Microdata.Property{
                 html:
                   "<span class=\"author-name\" itemprop=\"author\">\n            <a href=\"https://www.seriouseats.com/user/profile/kenjilopezalt\" class=\"name\">J. Kenji López-Alt</a>\n        </span>",
                 names: MapSet.new(["http://schema.org/author"]),
                 value: "J. Kenji López-Alt"
               },
               %Microdata.Property{
                 html:
                   "<ul class=\"tags\" itemprop=\"keywords\">\n        <li><a href=\"https://www.seriouseats.com/tags/duck\" class=\"tag\">duck</a></li>\n        <li><a href=\"https://www.seriouseats.com/tags/entrees\" class=\"tag\">entrees</a></li>\n        <li><a href=\"https://www.seriouseats.com/tags/poultry\" class=\"tag\">poultry</a></li>\n        <li><a href=\"https://www.seriouseats.com/tags/sous vide\" class=\"tag\">sous vide</a></li>\n        <li><a href=\"https://www.seriouseats.com/tags/sous vide 101\" class=\"tag\">sous vide 101</a></li>\n        <li><a href=\"https://www.seriouseats.com/tags/valentine's day entrees\" class=\"tag\">valentine's day entrees</a></li>\n    </ul>",
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
                 html: nil,
                 names: MapSet.new(["http://schema.org/logo"]),
                 value:
                   "https://static.seriouseats.com/1/braestar/live/img/logo-color-240x190.png"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://www.facebook.com/seriouseats"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://twitter.com/seriouseats"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://plus.google.com/+seriouseats/posts"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://pinterest.com/seriouseats"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://instagram.com/seriouseats/"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://www.youtube.com/user/SeriousEats"
               },
               %Microdata.Property{
                 html: nil,
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
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.seriouseats.com/recipes/"
                     },
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/position"]),
                       value: 1
                     }
                   ],
                   types: MapSet.new(["http://schema.org/ListItem"])
                 }
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.seriouseats.com/recipes/topics/ingredient"
                     },
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/position"]),
                       value: 2
                     }
                   ],
                   types: MapSet.new(["http://schema.org/ListItem"])
                 }
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value:
                         "https://www.seriouseats.com/recipes/topics/ingredient/meats-and-poultry"
                     },
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/position"]),
                       value: 3
                     }
                   ],
                   types: MapSet.new(["http://schema.org/ListItem"])
                 }
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value:
                         "https://www.seriouseats.com/recipes/topics/ingredient/meats-and-poultry/other-meats"
                     },
                     %Microdata.Property{
                       html: nil,
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
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.seriouseats.com/recipes/"
                     },
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/position"]),
                       value: 1
                     }
                   ],
                   types: MapSet.new(["http://schema.org/ListItem"])
                 }
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.seriouseats.com/recipes/topics/meal"
                     },
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/position"]),
                       value: 2
                     }
                   ],
                   types: MapSet.new(["http://schema.org/ListItem"])
                 }
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.seriouseats.com/recipes/topics/meal/mains"
                     },
                     %Microdata.Property{
                       html: nil,
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
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.seriouseats.com/recipes/"
                     },
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/position"]),
                       value: 1
                     }
                   ],
                   types: MapSet.new(["http://schema.org/ListItem"])
                 }
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.seriouseats.com/recipes/topics/method"
                     },
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/position"]),
                       value: 2
                     }
                   ],
                   types: MapSet.new(["http://schema.org/ListItem"])
                 }
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.seriouseats.com/recipes/topics/method/sous-vide"
                     },
                     %Microdata.Property{
                       html: nil,
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
       }}
    end

    test "converts from text", %{doc: doc} do
      assert {:ok, doc} == @recipe_file |> File.read!() |> Microdata.parse()
    end

    test "converts from file", %{doc: doc} do
      assert {:ok, doc} == Microdata.parse(file: @recipe_file)
    end

    @tag :remote
    test "converts from url", %{doc: doc} do
      assert {:ok, doc} == Microdata.parse(url: @recipe_url)
    end
  end

  describe "json-ld annotations" do
    @recipe_url "https://food52.com/recipes/22467-rao-s-meatballs"
    @recipe_file "./test/_cache/ld-recipe.html"

    setup do
      {:ok,
       doc: %Microdata.Document{
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
       }}
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
      {:ok,
       doc: %Microdata.Document{
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
               %Microdata.Property{
                 names: MapSet.new(["http://schema.org/nutrition"]),
                 value: nil
               },
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
       }}
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
      {:ok,
       doc: %Microdata.Document{
         items: [
           %Microdata.Item{
             id: nil,
             types: MapSet.new(["https://schema.org/SiteNavigationElement"]),
             properties: [
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/about/\" itemprop=\"url\"><span itemprop=\"name\">About</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/about/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">About</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "About"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/welcome-to-fooduzzi/\" itemprop=\"url\"><span itemprop=\"name\">Start Here</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/welcome-to-fooduzzi/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Start Here</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Start Here"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/food/\" itemprop=\"url\"><span itemprop=\"name\">Recipes</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/food/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Recipes</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Recipes"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/food-index/\" itemprop=\"url\"><span itemprop=\"name\">Recipe Index</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/food-index/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Recipe Index</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Recipe Index"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/breakfast/\" itemprop=\"url\"><span itemprop=\"name\">Breakfast</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/breakfast/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Breakfast</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Breakfast"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/oats/\" itemprop=\"url\"><span itemprop=\"name\">Oats</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/oats/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Oats</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Oats"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/smoothies/\" itemprop=\"url\"><span itemprop=\"name\">Smoothies</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/smoothies/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Smoothies</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Smoothies"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/appetizers/\" itemprop=\"url\"><span itemprop=\"name\">Appetizers</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/appetizers/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Appetizers</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Appetizers"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/entree/\" itemprop=\"url\"><span itemprop=\"name\">Entree</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/entree/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Entree</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Entree"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/salad/\" itemprop=\"url\"><span itemprop=\"name\">Salad</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/salad/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Salad</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Salad"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/sandwiches/\" itemprop=\"url\"><span itemprop=\"name\">Sandwiches</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/sandwiches/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Sandwiches</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Sandwiches"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/soup/\" itemprop=\"url\"><span itemprop=\"name\">Soup</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/soup/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Soup</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Soup"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/sauces/\" itemprop=\"url\"><span itemprop=\"name\">Sauces</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/sauces/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Sauces</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Sauces"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/snack/\" itemprop=\"url\"><span itemprop=\"name\">Snack</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/snack/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Snack</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Snack"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/dessert/\" itemprop=\"url\"><span itemprop=\"name\">Dessert</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/dessert/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Dessert</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Dessert"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"#\" itemprop=\"url\"><span itemprop=\"name\">Dietary Restriction</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: ""
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Dietary Restriction</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Dietary Restriction"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/vegan/\" itemprop=\"url\"><span itemprop=\"name\">Vegan</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/vegan/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Vegan</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Vegan"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/glutenfree/\" itemprop=\"url\"><span itemprop=\"name\">Gluten Free</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/glutenfree/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Gluten Free</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Gluten Free"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/vegetarian/\" itemprop=\"url\"><span itemprop=\"name\">Vegetarian</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/vegetarian/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Vegetarian</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Vegetarian"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/how-tos/\" itemprop=\"url\"><span itemprop=\"name\">Kitchen How-Tos</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/how-tos/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Kitchen How-Tos</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Kitchen How-Tos"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/favorites/\" itemprop=\"url\"><span itemprop=\"name\">Favorites</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/favorites/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Favorites</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Favorites"
               },
               %Microdata.Property{
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/favorites/alexa-favorites/",
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/favorites/alexa-favorites/\" itemprop=\"url\"><span itemprop=\"name\">Alexa Favorites</span></a>"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Alexa Favorites</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Alexa Favorites"
               },
               %Microdata.Property{
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/favorites/reader-favorites/",
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/favorites/reader-favorites/\" itemprop=\"url\"><span itemprop=\"name\">Reader Favorites</span></a>"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Reader Favorites</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Reader Favorites"
               }
             ]
           },
           %Microdata.Item{
             id: nil,
             properties: [
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/life/\" itemprop=\"url\"><span itemprop=\"name\">Life</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/life/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Life</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Life"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/category/life/travel/\" itemprop=\"url\"><span itemprop=\"name\">Vegan Travel</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/category/life/travel/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Vegan Travel</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Vegan Travel"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"https://www.fooduzzi.com/work-with-me/\" itemprop=\"url\"><span itemprop=\"name\">Work with Me</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: "https://www.fooduzzi.com/work-with-me/"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Work with Me</span>",
                 names: MapSet.new(["https://schema.org/name"]),
                 value: "Work with Me"
               },
               %Microdata.Property{
                 html:
                   "<a href=\"mailto:fooduzzi@gmail.com\" itemprop=\"url\"><span itemprop=\"name\">Contact</span></a>",
                 names: MapSet.new(["https://schema.org/url"]),
                 value: ""
               },
               %Microdata.Property{
                 html: "<span itemprop=\"name\">Contact</span>",
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
                 html: "<h3 class=\"mr-section\" itemprop=\"name\">Hemp Heart Tabouli</h3>",
                 names: MapSet.new(["http://schema.org/name"]),
                 value: "Hemp Heart Tabouli"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"author\">Fooduzzi</span>",
                 names: MapSet.new(["http://schema.org/author"]),
                 value: "Fooduzzi"
               },
               %Microdata.Property{
                 html:
                   "<span itemprop=\"url\">https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/</span>",
                 names: MapSet.new(["http://schema.org/url"]),
                 value: "https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/"
               },
               %Microdata.Property{
                 html:
                   "<span class=\"mr-hide\" itemprop=\"image\">https://www.fooduzzi.com/wp-content/uploads/2018/08/hemp-heart-tabouli-7.jpg</span>",
                 names: MapSet.new(["http://schema.org/image"]),
                 value:
                   "https://www.fooduzzi.com/wp-content/uploads/2018/08/hemp-heart-tabouli-7.jpg"
               },
               %Microdata.Property{
                 html: "<time itemprop=\"prepTime\" datetime=\"PT10M\">10m</time>",
                 names: MapSet.new(["http://schema.org/prepTime"]),
                 value: "10m"
               },
               %Microdata.Property{
                 html: "<span itemprop=\"recipeYield\">serves 4-6</span>",
                 names: MapSet.new(["http://schema.org/recipeYield"]),
                 value: "serves 4-6"
               },
               %Microdata.Property{
                 html: "<time itemprop=\"totalTime\" datetime=\"PT0H10M\">0h 10m</time>",
                 names: MapSet.new(["http://schema.org/totalTime"]),
                 value: "0h 10m"
               },
               %Microdata.Property{
                 html:
                   "<div itemprop=\"description\" class=\"mr-section mr-description\">\n        \t\t\t\t<p>A simple, no-cook vegan tabouli made with hemp hearts! A protein- and nutrient-packed snack, lunch, or side!</p>        \t\t\t</div>",
                 names: MapSet.new(["http://schema.org/description"]),
                 value:
                   "A simple, no-cook vegan tabouli made with hemp hearts! A protein- and nutrient-packed snack, lunch, or side!"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">2 cups packed parsley, minced</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "2 cups packed parsley, minced"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">5 large mint leaves, minced</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "5 large mint leaves, minced"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1/2 cup hemp hearts</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "1/2 cup hemp hearts"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">juice of 1-2 small lemons</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "juice of 1-2 small lemons"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1 roma tomato, chopped </li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "1 roma tomato, chopped"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1 large green onion, minced</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "1 large green onion, minced"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1/4 large english cucumber, chopped</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "1/4 large english cucumber, chopped"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1/4 tsp. allspice, optional for toasty flavor</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "1/4 tsp. allspice, optional for toasty flavor"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1 Tbsp. olive oil</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "1 Tbsp. olive oil"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">salt + pepper</li>",
                 names: MapSet.new(["http://schema.org/recipeIngredient"]),
                 value: "salt + pepper"
               },
               %Microdata.Property{
                 html:
                   "<li itemprop=\"recipeInstructions\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">Mix all of your ingredients in a medium bowl. Season with salt and pepper to taste and enjoy!</li>",
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
                 html:
                   "<p class=\"site-title\" itemprop=\"headline\"><a href=\"https://www.fooduzzi.com/\">Fooduzzi</a></p>",
                 names: MapSet.new(["https://schema.org/headline"]),
                 value: "Fooduzzi"
               },
               %Microdata.Property{
                 html:
                   "<p class=\"site-description\" itemprop=\"description\">the plant-based food blog</p>",
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
                 html: "<h1 class=\"entry-title\" itemprop=\"headline\">Hemp Heart Tabouli</h1>",
                 names: MapSet.new(["https://schema.org/headline"]),
                 value: "Hemp Heart Tabouli"
               },
               %Microdata.Property{
                 html:
                   "<time class=\"entry-time\" itemprop=\"datePublished\" datetime=\"2018-08-20T06:00:05+00:00\">August 20, 2018</time>",
                 names: MapSet.new(["https://schema.org/datePublished"]),
                 value: "August 20, 2018"
               },
               %Microdata.Property{
                 html:
                   "<span class=\"entry-author\" itemprop=\"author\" itemscope=\"\" itemtype=\"https://schema.org/Person\"><a href=\"https://www.fooduzzi.com/author/peduzziagmail-com/\" class=\"entry-author-link\" itemprop=\"url\" rel=\"author\"><span class=\"entry-author-name\" itemprop=\"name\">Alexa [fooduzzi.com]</span></a></span>",
                 names: MapSet.new(["https://schema.org/author"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html:
                         "<a href=\"https://www.fooduzzi.com/author/peduzziagmail-com/\" class=\"entry-author-link\" itemprop=\"url\" rel=\"author\"><span class=\"entry-author-name\" itemprop=\"name\">Alexa [fooduzzi.com]</span></a>",
                       names: MapSet.new(["https://schema.org/url"]),
                       value: "https://www.fooduzzi.com/author/peduzziagmail-com/"
                     },
                     %Microdata.Property{
                       html:
                         "<span class=\"entry-author-name\" itemprop=\"name\">Alexa [fooduzzi.com]</span>",
                       names: MapSet.new(["https://schema.org/name"]),
                       value: "Alexa [fooduzzi.com]"
                     }
                   ],
                   types: MapSet.new(["https://schema.org/Person"])
                 }
               },
               %Microdata.Property{
                 html:
                   "<div class=\"entry-content\" itemprop=\"text\"><p>If you have a garden that is totally overgrown with parsley, mint, and tomatoes, this recipe is for you!</p>\n<p>This recipe is <em>also</em> for you if you’re a fan of delicious flavor.</p>\n<p>(name that show)<span id=\"more-10649\"></span></p>\n<p><a href=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-6.jpg\"><img class=\"aligncenter wp-image-10656 size-full\" src=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-6.jpg\" alt=\"a bunch of parsley\" width=\"600\" height=\"900\" data-pin-description=\"Hemp Heart Tabouli: A simple, no-cook vegan and gluten free tabouli made with hemp hearts! A protein- and nutrient-packed snack, lunch, or side! || fooduzzi.com recipe #hemphearts #tabouli #vegan #veganmeal\" srcset=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-6.jpg 600w, https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-6-200x300.jpg 200w\" sizes=\"(max-width: 600px) 100vw, 600px\" /></a></p>\n<p>I. Love. Tabouli. Or tabbouleh. However you spell it, I love it.</p>\n<p>There’s a fabulous Mediterranean restaurant chain here in Pittsburgh (Aladdin’s), and they have the best tabouli ever. They add it to this salad that I <em>swear</em> I’m not going to get again every time I go. But alas, I end up ordering it again and it never ever ever disappoints.</p>\n<p>Tabouli is typically made with bulgur wheat, buuuut I wanted to lay off the wheat a bit. I’ve been eating a ton of wheat in the form of bread, pizza, and pasta recently. Not like it’s a bad thing in moderation. But I am desperately missing some moderation in my life.</p>\n<p>And because I’ve been working out more recently, I’ve been looking for ways to increase my protein intake. And one of my favorite plant-based protein sources is…the hemp heart!</p>\n<p><a href=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-2.jpg\"><img class=\"aligncenter wp-image-10660 size-full\" src=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-2.jpg\" alt=\"hemp hearts in a measuring cup\" width=\"600\" height=\"900\" data-pin-description=\"Hemp Heart Tabouli: A simple, no-cook vegan and gluten free tabouli made with hemp hearts! A protein- and nutrient-packed snack, lunch, or side! || fooduzzi.com recipe #hemphearts #tabouli #vegan #veganmeal\" srcset=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-2.jpg 600w, https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-2-200x300.jpg 200w\" sizes=\"(max-width: 600px) 100vw, 600px\" /></a></p>\n<h2>So, uh, what are hemp hearts?</h2>\n<p>Fab question, my dear. They are the creamy, nutty, delicious little seeds from the hemp plant!</p>\n<p><em>Yes</em>, that hemp plant. <em>No</em>, they won’t get you high.</p>\n<p>You can actually buy them in pretty much any grocery store. Typically over by the oats / cereals or over by the nuts and seeds. But they’re awesome. 3 Tbsp. of hemp hearts have 10g protein. Plus <a href=\"https://www.bobsredmill.com/hulled-hemp-seed-hearts.html\">omega-3s and omega-6s</a> for healthy hearts and brains, iron, manganese, thiamine, and lots of other goodness.</p>\n<p>They’re a cute little nutritional powerhouse, and they’re delicious in this tabouli.</p>\n<p>But honestly, how could they <em>not</em> be delicious in this tabouli when there are ingredients like copious amounts of parsley, a bit of mint, some lemon juice, a bit of veggies, and a wee bit of seasoning?</p>\n<p>This is the kind of dish that just <em>shines</em> in its simplicity. It’s stupidly simple, but ridiculously flavorful and addictive.</p>\n<p><a href=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-9.jpg\"><img class=\"aligncenter wp-image-10659 size-full\" src=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-9.jpg\" alt=\"hemp heart tabouli in bowl\" width=\"600\" height=\"900\" data-pin-description=\"Hemp Heart Tabouli: A simple, no-cook vegan and gluten free tabouli made with hemp hearts! A protein- and nutrient-packed snack, lunch, or side! || fooduzzi.com recipe #hemphearts #tabouli #vegan #veganmeal\" srcset=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-9.jpg 600w, https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-9-200x300.jpg 200w\" sizes=\"(max-width: 600px) 100vw, 600px\" /></a></p>\n<p>Wahoo! I highly suggest enjoying this tabouli in <a href=\"https://www.fooduzzi.com/2018/01/vegan-mediterranean-quinoa-falafel-salad/\">salads</a>, on <a href=\"https://www.fooduzzi.com/2017/05/how-to-make-a-vegan-cheese-plate/\">cheese plates</a>, with <a href=\"https://www.fooduzzi.com/2017/05/garlic-herb-almond-flour-crackers/\">crackers</a>, in pitas, or on its own with a fork or spoon.</p>\n<p>I love it. You’ll love it. I know it.</p>\n\n    <!--  ////////////////////////////////  -->\n    <!--         Begin Matcha Recipe        -->\n    <!--     https://www.zeph.co/matcha     -->\n    <!--  ////////////////////////////////  -->\n\n    <div id=\"recipe\">\n    \t<div id=\"matcha\" itemscope=\"\" itemtype=\"http://schema.org/Recipe\">\n\n            <!--  Open Matcha's Header  -->\n    \t\t<div id=\"matchaheader\" class=\"mr-section\">\n    \t\t\t<div class=\"mr-image\"></div>\n    \t\t\t<div class=\"mr-section mr-padding\">\n    \t\t\t\t<h3 class=\"mr-section\" itemprop=\"name\">Hemp Heart Tabouli</h3>\n    \t\t\t\t<div class=\"printMeta mr-hide\">\n    \t\t\t\t\tFrom <span itemprop=\"author\">Fooduzzi</span>\n    \t\t\t\t\tat <span itemprop=\"url\">https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/</span><br /><br />\n    \t\t\t\t</div>\n                                            <img class=\"mr-print-image\" src=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2018/08/hemp-heart-tabouli-7.jpg\" />\n                        <span class=\"mr-hide\" itemprop=\"image\">https://www.fooduzzi.com/wp-content/uploads/2018/08/hemp-heart-tabouli-7.jpg</span>\n                        \t\t\t\t<table><tbody><tr><td>Prep: <time itemprop=\"prepTime\" datetime=\"PT10M\">10m</time></td><td>Yield: <span itemprop=\"recipeYield\">serves 4-6</span></td><td class=\"mr-hide\">Total: <time itemprop=\"totalTime\" datetime=\"PT0H10M\">0h 10m</time></td></tr></tbody></table>    \t\t\t</div>\n    \t\t</div>\n\n            <!--  Open Matcha's Body  -->\n    \t\t<div class=\"matcha-body\">\n                <div class=\"mr-section mr-padding\">\n        \t\t\t                    <div itemprop=\"description\" class=\"mr-section mr-description\">\n        \t\t\t\t<p>A simple, no-cook vegan tabouli made with hemp hearts! A protein- and nutrient-packed snack, lunch, or side!</p>        \t\t\t</div>\n                            \t\t\t<div class=\"mr-section mr-ingredients\">\n        \t\t\t\t<h4>You'll Need...</h4>\n        \t\t\t\t<ul>\n        \t\t\t\t\t<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">2 cups packed parsley, minced</li>\n<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">5 large mint leaves, minced</li>\n<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1/2 cup hemp hearts</li>\n<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">juice of 1-2 small lemons</li>\n<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1 roma tomato, chopped </li>\n<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1 large green onion, minced</li>\n<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1/4 large english cucumber, chopped</li>\n<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1/4 tsp. allspice, optional for toasty flavor</li>\n<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">1 Tbsp. olive oil</li>\n<li itemprop=\"recipeIngredient\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">salt + pepper</li>        \t\t\t\t</ul>\n        \t\t\t</div>\n        \t\t\t<div class=\"mr-section mr-directions\">\n        \t\t\t\t<h4>Directions</h4>\n        \t\t\t\t<ol>\n        \t\t\t\t\t<li itemprop=\"recipeInstructions\" class=\"matcha-li\" onclick=\"matchaStrikethrough(this);\">Mix all of your ingredients in a medium bowl. Season with salt and pepper to taste and enjoy!</li>        \t\t\t\t</ol>\n        \t\t\t</div>\n                        \t\t\t\t<div class=\"mr-section mr-footer\">\n    \t\t\t\t\t<a href=\"https://www.zeph.co/matcha\" class=\"mr-branding\" target=\"_blank\">Generated with <span class=\"mr-heart\">♥︎</span> by Matcha</a>\n                                                    <a class=\"mr-print\" onclick=\"printMatcha('recipe')\">Print</a>\n                            \t\t\t\t</div>\n        \t\t</div>\n            </div>\n    \t</div>\n    </div>\n    <!--  End Matcha  -->\n<div class=\"et_bloom_below_post\"><div class=\"et_bloom_inline_form et_bloom_optin et_bloom_make_form_visible et_bloom_optin_3\" style=\"display: none;\">\n\t\t\t\t\n\t\t\t\t<div class=\"et_bloom_form_container  with_edge carrot_edge et_bloom_rounded et_bloom_form_text_dark et_bloom_form_right et_bloom_inline_2_fields\">\n\t\t\t\t\t\n\t\t\t<div class=\"et_bloom_form_container_wrapper clearfix\">\n\t\t\t\t<div class=\"et_bloom_header_outer\">\n\t\t\t\t\t<div class=\"et_bloom_form_header et_bloom_header_text_light\">\n\t\t\t\t\t\t<img width=\"610\" height=\"160\" src=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2017/04/fooduzzi-2017-no-background-white-610x160.png\" class=\" et_bloom_image_slideup et_bloom_image\" alt=\"\" srcset=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2017/04/fooduzzi-2017-no-background-white-610x160.png 610w, https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2017/04/fooduzzi-2017-no-background-white-300x79.png 300w, https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2017/04/fooduzzi-2017-no-background-white-768x201.png 768w, https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2017/04/fooduzzi-2017-no-background-white.png 1024w\" sizes=\"(max-width: 610px) 100vw, 610px\" />\n\t\t\t\t\t\t<div class=\"et_bloom_form_text\">\n\t\t\t\t\t\t<h2 style=\"text-align: center;\">Join the Fooduzzi Fam!</h2><p style=\"text-align: center;\">I'll send you healthy takes on classic recipes, delectable recipe roundups, and more updates on my growing blog. You'll also receive a free eCookbook featuring my best recipes!</p>\n\t\t\t\t\t</div>\n\t\t\t\t\t\t\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t<div class=\"et_bloom_form_content et_bloom_2_fields\">\n\t\t\t\t\t\n\t\t\t\t\t\n\t\t\t\t\t<form method=\"post\" class=\"clearfix\">\n\t\t\t\t\t\t<p class=\"et_bloom_popup_input et_bloom_subscribe_name\">\n\t\t\t\t\t\t\t\t<input placeholder=\"First Name\" maxlength=\"50\" />\n\t\t\t\t\t\t\t</p>\n\t\t\t\t\t\t<p class=\"et_bloom_popup_input et_bloom_subscribe_email\">\n\t\t\t\t\t\t\t<input placeholder=\"Email\" />\n\t\t\t\t\t\t</p>\n\n\t\t\t\t\t\t<button data-optin_id=\"optin_3\" data-service=\"mailchimp\" data-list_id=\"91657c27d5\" data-page_id=\"10649\" data-account=\"peduzzia\" data-disable_dbl_optin=\"\" class=\"et_bloom_submit_subscription\">\n\t\t\t\t\t\t\t<span class=\"et_bloom_subscribe_loader\"></span>\n\t\t\t\t\t\t\t<span class=\"et_bloom_button_text et_bloom_button_text_color_light\">Send me healthy recipes!</span>\n\t\t\t\t\t\t</button>\n\t\t\t\t\t</form>\n\t\t\t\t\t<div class=\"et_bloom_success_container\">\n\t\t\t\t\t\t<span class=\"et_bloom_success_checkmark\"></span>\n\t\t\t\t\t</div>\n\t\t\t\t\t<h2 class=\"et_bloom_success_message\">Check your email to confirm and to download your free eCookbook!</h2>\n\t\t\t\t\t\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t\t<span class=\"et_bloom_close_button\"></span>\n\t\t\t\t</div>\n\t\t\t</div></div><span class=\"et_social_bottom_trigger\"></span><!-- <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n\t\t\txmlns:dc=\"http://purl.org/dc/elements/1.1/\"\n\t\t\txmlns:trackback=\"http://madskills.com/public/xml/rss/module/trackback/\">\n\t\t<rdf:Description rdf:about=\"https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/\"\n    dc:identifier=\"https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/\"\n    dc:title=\"Hemp Heart Tabouli\"\n    trackback:ping=\"https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/trackback/\" />\n</rdf:RDF> -->\n</div>",
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
                 html:
                   "<form class=\"search-form\" itemprop=\"potentialAction\" itemscope=\"\" itemtype=\"https://schema.org/SearchAction\" method=\"get\" action=\"https://www.fooduzzi.com/\" role=\"search\"><label class=\"search-form-label screen-reader-text\" for=\"searchform-5c55e8fe6e0a34.32699570\">Search this website</label><input class=\"search-form-input\" type=\"search\" itemprop=\"query-input\" name=\"s\" id=\"searchform-5c55e8fe6e0a34.32699570\" placeholder=\"Search this website\" /><input class=\"search-form-submit\" type=\"submit\" value=\"Search\" /><meta itemprop=\"target\" content=\"https://www.fooduzzi.com/?s={s}\" /></form>",
                 names: MapSet.new(["https://schema.org/potentialAction"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html:
                         "<input class=\"search-form-input\" type=\"search\" itemprop=\"query-input\" name=\"s\" id=\"searchform-5c55e8fe6e0a34.32699570\" placeholder=\"Search this website\" />",
                       names: MapSet.new(["https://schema.org/query-input"]),
                       value: ""
                     },
                     %Microdata.Property{
                       html:
                         "<meta itemprop=\"target\" content=\"https://www.fooduzzi.com/?s={s}\" />",
                       names: MapSet.new(["https://schema.org/target"]),
                       value: "https://www.fooduzzi.com/?s={s}"
                     }
                   ],
                   types: MapSet.new(["https://schema.org/SearchAction"])
                 }
               },
               %Microdata.Property{
                 html:
                   "<img width=\"150\" height=\"150\" src=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/popcorn-2-150x150.jpg\" class=\"entry-image attachment-post\" alt=\"Popcorn\" itemprop=\"image\" data-pin-description=\"Read about what we've been up to lately! Sharing my new book recommendations, favorite restaurants, a new tool for social media, and so much more! || fooduzzi.com #fooduzzi #life #lately #lifestyle #vegan\" />",
                 names: MapSet.new(["https://schema.org/image"]),
                 value:
                   "https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/popcorn-2-150x150.jpg"
               },
               %Microdata.Property{
                 html:
                   "<h4 class=\"entry-title\" itemprop=\"headline\"><a href=\"https://www.fooduzzi.com/2019/02/lately-8/\">Lately</a></h4>",
                 names: MapSet.new(["https://schema.org/headline"]),
                 value: "Lately"
               },
               %Microdata.Property{
                 html:
                   "<img width=\"150\" height=\"150\" src=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/vegan-buffalo-tofu-tacos-3-150x150.jpg\" class=\"entry-image attachment-post\" alt=\"girl holding a vegan buffalo tofu taco\" itemprop=\"image\" data-pin-description=\"Vegan Buffalo Tofu Tacos: A filling, fresh, and spicy taco topped with all the things! Perfect for making-ahead so that mealtime is a breeze. || fooduzzi.com recipe #fooduzzi #tacos #vegan #buffalo #tofu\" />",
                 names: MapSet.new(["https://schema.org/image"]),
                 value:
                   "https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/vegan-buffalo-tofu-tacos-3-150x150.jpg"
               },
               %Microdata.Property{
                 html:
                   "<h4 class=\"entry-title\" itemprop=\"headline\"><a href=\"https://www.fooduzzi.com/2019/01/vegan-buffalo-tofu-tacos/\">Vegan Buffalo Tofu Tacos</a></h4>",
                 names: MapSet.new(["https://schema.org/headline"]),
                 value: "Vegan Buffalo Tofu Tacos"
               },
               %Microdata.Property{
                 html:
                   "<img width=\"150\" height=\"150\" src=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/homemade-whole-wheat-flour-tortillas-7-150x150.jpg\" class=\"entry-image attachment-post\" alt=\"whole wheat flour tortillas in a basket\" itemprop=\"image\" data-pin-description=\"Homemade Whole Wheat Tortillas: Soft, chewy, foldable homemade whole wheat tortilla recipe that's as simple as it is delicious! You'll love using them for tacos, burritos, wraps, and more! || fooduzzi.com recipe #fooduzzi #tortillas #homemadebread #bobsredmill #mexican #vegan\" />",
                 names: MapSet.new(["https://schema.org/image"]),
                 value:
                   "https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/homemade-whole-wheat-flour-tortillas-7-150x150.jpg"
               },
               %Microdata.Property{
                 html:
                   "<h4 class=\"entry-title\" itemprop=\"headline\"><a href=\"https://www.fooduzzi.com/2019/01/homemade-whole-wheat-tortillas/\">Homemade Whole Wheat Tortillas</a></h4>",
                 names: MapSet.new(["https://schema.org/headline"]),
                 value: "Homemade Whole Wheat Tortillas"
               },
               %Microdata.Property{
                 html:
                   "<img width=\"150\" height=\"150\" src=\"https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/easy-baked-buffalo-tofu-2-150x150.jpg\" class=\"entry-image attachment-post\" alt=\"easy baked buffalo tofu on a baking sheet\" itemprop=\"image\" data-pin-description=\"Easy Baked Buffalo Tofu: A simple, healthy, protein-packed vegan main! Perfect for dinners, bowls, salads, and more! || fooduzzi.com recipe #vegan #glutenfree #tofu #fooduzzi\" />",
                 names: MapSet.new(["https://schema.org/image"]),
                 value:
                   "https://swj0y6xl9l-flywheel.netdna-ssl.com/wp-content/uploads/2019/01/easy-baked-buffalo-tofu-2-150x150.jpg"
               },
               %Microdata.Property{
                 html:
                   "<h4 class=\"entry-title\" itemprop=\"headline\"><a href=\"https://www.fooduzzi.com/2019/01/baked-buffalo-tofu/\">Easy Baked Buffalo Tofu</a></h4>",
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
                 html:
                   "<article itemprop=\"comment\" itemscope=\"\" itemtype=\"https://schema.org/Comment\">\n\n\t\t\n\t\t<header class=\"comment-header\">\n\t\t\t<p class=\"comment-author\" itemprop=\"author\" itemscope=\"\" itemtype=\"https://schema.org/Person\">\n\t\t\t\t<img alt=\"\" src=\"https://secure.gravatar.com/avatar/4c3136874c21f6a3f5ee48f892bda305?s=120&d=mm&r=g\" srcset=\"https://secure.gravatar.com/avatar/4c3136874c21f6a3f5ee48f892bda305?s=240&d=mm&r=g 2x\" class=\"avatar avatar-120 photo\" height=\"120\" width=\"120\" /><span itemprop=\"name\"><a href=\"https://ramshacklepantry.com/\" class=\"comment-author-link\" rel=\"external nofollow\" itemprop=\"url\">Ben Myhre</a></span> <span class=\"says\">says</span>\t\t\t</p>\n\n\t\t\t<p class=\"comment-meta\"><time class=\"comment-time\" datetime=\"2018-08-20T15:51:42+00:00\" itemprop=\"datePublished\"><a href=\"https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/#comment-19606\" class=\"comment-time-link\" itemprop=\"url\">August 20, 2018 at 3:51 PM</a></time></p>\t\t</header>\n\n\t\t<div class=\"comment-content\" itemprop=\"text\">\n\t\t\t\n\t\t\t<p>This looks really good and interesting. I have never tried hemp hearts, but not I am going to have to give it a whirl. Remember to enjoy everything with moderation… even moderation. ;) Thanks for sharing with us!</p>\n\t\t</div>\n\n\t\t<div class=\"comment-reply\"><a rel=\"nofollow\" class=\"comment-reply-link\" href=\"#comment-19606\" onclick='return addComment.moveForm( \"comment-19606\", \"19606\", \"respond\", \"10649\" )' aria-label=\"Reply to Ben Myhre\">Reply</a></div>\n\t\t\n\t</article>",
                 names: MapSet.new(["https://schema.org/comment"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html:
                         "<p class=\"comment-author\" itemprop=\"author\" itemscope=\"\" itemtype=\"https://schema.org/Person\">\n\t\t\t\t<img alt=\"\" src=\"https://secure.gravatar.com/avatar/4c3136874c21f6a3f5ee48f892bda305?s=120&d=mm&r=g\" srcset=\"https://secure.gravatar.com/avatar/4c3136874c21f6a3f5ee48f892bda305?s=240&d=mm&r=g 2x\" class=\"avatar avatar-120 photo\" height=\"120\" width=\"120\" /><span itemprop=\"name\"><a href=\"https://ramshacklepantry.com/\" class=\"comment-author-link\" rel=\"external nofollow\" itemprop=\"url\">Ben Myhre</a></span> <span class=\"says\">says</span>\t\t\t</p>",
                       names: MapSet.new(["https://schema.org/author"]),
                       value: %Microdata.Item{
                         id: nil,
                         properties: [
                           %Microdata.Property{
                             html:
                               "<span itemprop=\"name\"><a href=\"https://ramshacklepantry.com/\" class=\"comment-author-link\" rel=\"external nofollow\" itemprop=\"url\">Ben Myhre</a></span>",
                             names: MapSet.new(["https://schema.org/name"]),
                             value: "Ben Myhre"
                           },
                           %Microdata.Property{
                             html:
                               "<a href=\"https://ramshacklepantry.com/\" class=\"comment-author-link\" rel=\"external nofollow\" itemprop=\"url\">Ben Myhre</a>",
                             names: MapSet.new(["https://schema.org/url"]),
                             value: "https://ramshacklepantry.com/"
                           }
                         ],
                         types: MapSet.new(["https://schema.org/Person"])
                       }
                     },
                     %Microdata.Property{
                       html:
                         "<time class=\"comment-time\" datetime=\"2018-08-20T15:51:42+00:00\" itemprop=\"datePublished\"><a href=\"https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/#comment-19606\" class=\"comment-time-link\" itemprop=\"url\">August 20, 2018 at 3:51 PM</a></time>",
                       names: MapSet.new(["https://schema.org/datePublished"]),
                       value: "August 20, 2018 at 3:51 PM"
                     },
                     %Microdata.Property{
                       html:
                         "<a href=\"https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/#comment-19606\" class=\"comment-time-link\" itemprop=\"url\">August 20, 2018 at 3:51 PM</a>",
                       names: MapSet.new(["https://schema.org/url"]),
                       value: "https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/#comment-19606"
                     },
                     %Microdata.Property{
                       html:
                         "<div class=\"comment-content\" itemprop=\"text\">\n\t\t\t\n\t\t\t<p>This looks really good and interesting. I have never tried hemp hearts, but not I am going to have to give it a whirl. Remember to enjoy everything with moderation… even moderation. ;) Thanks for sharing with us!</p>\n\t\t</div>",
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
                 html: nil,
                 names: MapSet.new(["http://schema.org/name"]),
                 value: "Alexa [fooduzzi.com]"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://www.facebook.com/pages/Fooduzzi/761543773962006"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://instagram.com/fooduzzi/"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://www.pinterest.com/fooduzzi/"
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/sameAs"]),
                 value: "https://twitter.com/fooduzzi"
               },
               %Microdata.Property{
                 html: nil,
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
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.fooduzzi.com/"
                     },
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/position"]),
                       value: 1
                     }
                   ],
                   types: MapSet.new(["http://schema.org/ListItem"])
                 }
               },
               %Microdata.Property{
                 html: nil,
                 names: MapSet.new(["http://schema.org/itemListElement"]),
                 value: %Microdata.Item{
                   id: nil,
                   properties: [
                     %Microdata.Property{
                       html: nil,
                       names: MapSet.new(["http://schema.org/item"]),
                       value: "https://www.fooduzzi.com/2018/08/hemp-heart-tabouli/"
                     },
                     %Microdata.Property{
                       html: nil,
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
       }}
    end

    test "converts from text", %{doc: doc} do
      assert {:ok, doc} == @recipe_file |> File.read!() |> Microdata.parse()
    end

    test "converts from file", %{doc: doc} do
      assert {:ok, doc} == Microdata.parse(file: @recipe_file)
    end

    @tag :remote
    test "converts from url", %{doc: doc} do
      assert {:ok, doc} == Microdata.parse(url: @recipe_url)
    end
  end
end
