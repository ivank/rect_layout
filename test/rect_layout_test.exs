defmodule RectLayoutTest do
  use ExUnit.Case
  import RectLayout

  doctest_file("README.md")

  doctest RectLayout

  describe "RectLayout" do
    test "group getters" do
      g = group([rect(10, 20, 2, 3), rect(20, 50, 7, 10)])

      assert x(g) == 2
      assert y(g) == 3
      assert width(g) == 25
      assert height(g) == 57
    end

    test "group setters" do
      g = group([rect(2, 2), rect(4, 4, 2, 2)])

      assert x(g, 2) == group([rect(2, 2, 2), rect(4, 4, 4, 2)])
      assert y(g, 2) == group([rect(2, 2, 0, 2), rect(4, 4, 2, 4)])
      assert width(g, 12) == group([rect(4, 2), rect(8, 4, 4, 2)])
      assert height(g, 12) == group([rect(2, 4), rect(4, 8, 2, 4)])
    end

    test "transform real test" do
      rects = [
        rect(1000, 424),
        rect(1000, 217),
        rect(1000, 186),
        rect(1000, 168),
        rect(1000, 152),
        rect(1000, 126),
        rect(1000, 105),
        rect(1000, 87),
        rect(1000, 72)
      ]

      expects = [
        rect(1000, 424, 0, 0),
        rect(1000, 217, 0, 731.875),
        rect(1000, 186, 0, 1256.75),
        rect(1000, 168, 0, 1750.625),
        rect(1000, 152, 0, 2226.5),
        rect(1000, 126, 0, 2686.375),
        rect(1000, 105, 0, 3120.25),
        rect(1000, 87, 0, 3533.125),
        rect(1000, 72, 0, 3928.0)
      ]

      assert distribute_bottom(rects, 4000) == expects
    end

    test "layout" do
      r1 = %{image_meta: %{width: 10, height: 20}, height: 60.2, flag: "ROC", name: "R1"}
      r2 = %{image_meta: %{width: 5, height: 20}, height: 100.2, flag: "USSR", name: "R2"}
      r3 = %{image_meta: %{width: 7, height: 15}, height: 121.2, flag: "US", name: "R3"}
      r4 = %{image_meta: %{width: 10, height: 45}, height: 70.2, flag: "CN", name: "R4"}
      rockets = [r1, r2, r3, r4]

      row_height_zoom = 10
      width = 3000
      cols = 2
      gap = 40
      padding = 40
      infobox_height = 100

      results =
        rockets
        |> Enum.map(&sprite(rect(&1.image_meta.width, &1.image_meta.height), &1))
        |> Enum.chunk_every(cols)
        |> Enum.map(fn items ->
          group(
            items
            |> Enum.map(&constrain_height(&1, sprite_content(&1).height * row_height_zoom))
            |> spread_right(width, x: padding, cols: cols, gap: gap)
            |> align_bottom()
            |> Enum.map(fn image ->
              flag =
                sprite(rect(24, 15), sprite_content(image).flag)
                |> constrain_height(infobox_height * 0.25)
                |> y(bottom(image) + infobox_height * 0.08)
                |> center_x(center_x(image))

              text =
                sprite(
                  rect(Integer.floor_div(width, cols) - gap, infobox_height * 0.5),
                  sprite_content(image).name
                )
                |> y(bottom(flag) + infobox_height * 0.08)
                |> center_x(center_x(image))

              group([image, flag, text])
            end)
          )
        end)
        |> flow_bottom(gap: gap, y: padding)

      expected = [
        group([
          group([
            sprite(rect(301.0, 602.0, 639.5, 440.0), r1),
            sprite(rect(40.0, 25.0, 770.0, 1050.0), "ROC"),
            sprite(rect(1_460, 50.0, 60.0, 1083.0), "R1")
          ]),
          group([
            sprite(rect(250.5, 1002.0, 2164.75, 40.0), r2),
            sprite(rect(40.0, 25.0, 2270.0, 1050.0), "USSR"),
            sprite(rect(1_460, 50.0, 1560.0, 1083.0), "R2")
          ])
        ]),
        group([
          group([
            sprite(rect(565.6, 1212.0, 507.2, 1173.0), r3),
            sprite(rect(40.0, 25.0, 770.0, 2393.0), "US"),
            sprite(rect(1_460, 50.0, 60.0, 2426.0), "R3")
          ]),
          group([
            sprite(rect(156.0, 702.0, 2212.0, 1683.0), r4),
            sprite(rect(40.0, 25.0, 2270.0, 2393.0), "CN"),
            sprite(rect(1_460, 50.0, 1560.0, 2426.0), "R4")
          ])
        ])
      ]

      assert results == expected
    end
  end
end
