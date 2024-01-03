defmodule RectLayout.Group do
  @moduledoc """
  Represent a group of graphical object, moves and scales them together proportionally

  Any change to its `x` and `y` would change all of its children with the same amount
  Any change in `width` and `height` would be propogated to its children propotionally

  Should not be created directly but by using the `RectLayout.group/1` constructor

  If the children are modified externally should run the `RectLayout.group_children/2` to update them and the bounding rectangle

  Implements `RectLayout.Object` protocol so it can be used in the layout calculations
  """
  defstruct rect: %RectLayout.Rect{}, children: []

  @type t() :: %__MODULE__{:rect => RectLayout.Rect.t(), :children => list()}
end

defimpl RectLayout.Object, for: RectLayout.Group do
  alias RectLayout.Object
  alias RectLayout.Group

  def x(%Group{rect: rect}), do: Object.x(rect)

  def x(%Group{rect: rect, children: children} = group, x) do
    delta = x - Object.x(rect)

    %{
      group
      | rect: Object.x(rect, x),
        children: Enum.map(children, &Object.x(&1, Object.x(&1) + delta))
    }
  end

  def y(%Group{rect: rect}), do: Object.y(rect)

  def y(%Group{rect: rect, children: children} = group, y) do
    delta = y - Object.y(rect)

    %{
      group
      | rect: Object.y(rect, y),
        children: Enum.map(children, &Object.y(&1, Object.y(&1) + delta))
    }
  end

  def width(%Group{rect: rect}), do: Object.width(rect)

  def width(%Group{rect: rect, children: children} = group, width) do
    scale = width / Object.width(rect)

    children =
      Enum.map(
        children,
        &(&1 |> Object.x(Object.x(&1) * scale) |> Object.width(Object.width(&1) * scale))
      )

    %{group | rect: Object.width(rect, width), children: children}
  end

  def height(%Group{rect: rect}), do: Object.height(rect)

  def height(%Group{rect: rect, children: children} = group, height) do
    scale = height / Object.height(rect)

    children =
      Enum.map(
        children,
        &(&1 |> Object.y(Object.y(&1) * scale) |> Object.height(Object.height(&1) * scale))
      )

    %{group | rect: Object.height(rect, height), children: children}
  end
end
