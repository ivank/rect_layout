# RectLayout

[![Hex.pm](https://img.shields.io/hexpm/v/rect_layout.svg)](https://hexdocs.pm/rect_layout)
[![github deploy](https://github.com/ivank/rect_layout/actions/workflows/deploy.yml/badge.svg)](https://github.com/ivank/rect_layout)
[![codecov](https://codecov.io/gh/ivank/rect_layout/graph/badge.svg?token=T7UZUFT8VR)](https://codecov.io/gh/ivank/rect_layout)

Create and manipulate rectangular objects and groups of objects.
This is meant to allow generating dynamic svgs easier as it allows you to calculate positions of various svg elements with relation to each other.

Documentation: [https://hexdocs.pm/rect_layout](https://hexdocs.pm/rect_layout)

## Example

Arrange 6 images in 2 rows 3 columns, where images are constrained to height 100 and spread horizontally on each row in 500 pixels and aligned to their bottom.

```elixir
iex> images = [
...>  %{width: 25, height: 100, id: 1, src: "http://example.com/img1.svg"},
...>  %{width: 16, height: 10, id: 2, src: "http://example.com/img2.svg"},
...>  %{width: 16, height: 32, id: 3, src: "http://example.com/img3.svg"},
...>  %{width: 88, height: 44, id: 4, src: "http://example.com/img4.svg"},
...>  %{width: 30, height: 231, id: 5, src: "http://example.com/img5.svg"},
...>  %{width: 332, height: 123, id: 6, src: "http://example.com/img6.svg"},
...>]
iex> rows = images
...>  |> Enum.map(&sprite(rect(&1.width, &1.height), &1))
...>  |> Enum.chunk_every(3)
...>  |> Enum.map(fn chunk ->
...>    group(chunk |> constrain_width(100) |> spread_right(500, gap: 2) |> align_bottom(100))
...>  end)
...>  |> flow_bottom(gap: 10)
iex> for row <- rows do
...>   for s <- group_children(row) do
...>     "<image x='#{x(s)}' y='#{y(s)}' width='#{width(s)}' height='#{height(s)}' xlink:href='#{sprite_content(s).src}' />"
...>   end
...> end
[
  [
    "<image x='33.33333333333333' y='0.0' width='100' height='400.0' xlink:href='http://example.com/img1.svg' />",
    "<image x='200.0' y='337.5' width='100' height='62.5' xlink:href='http://example.com/img2.svg' />",
    "<image x='366.66666666666663' y='200.0' width='100' height='200.0' xlink:href='http://example.com/img3.svg' />",
  ],
  [
    "<image x='33.33333333333333' y='1130.0' width='100' height='50.0' xlink:href='http://example.com/img4.svg' />",
    "<image x='200.0' y='410.0' width='100' height='770.0' xlink:href='http://example.com/img5.svg' />",
    "<image x='366.66666666666663' y='1142.9518072289156' width='100' height='37.04819277108434' xlink:href='http://example.com/img6.svg' />",
  ]
]
```

## Installation

The package can be installed by adding `rect_layout` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rect_layout, "~> 0.1.0"}
  ]
end
```

## LICENSE

See [LICENSE.md](/LICENSE.md)
