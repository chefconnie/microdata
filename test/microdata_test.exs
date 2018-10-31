defmodule MicrodataTest do
  use ExUnit.Case, async: true
  doctest Microdata, except: [parse: 1]

  @recipe_url "https://www.seriouseats.com/recipes/2010/09/sous-vide-101-duck-breast-recipe.html"
  @recipe_file "./test/_cache/recipe.html"
  @empty_file "./test/_cache/empty.html"

  setup_all do
    HTTPoison.start()

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
