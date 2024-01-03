defmodule RectLayout.Rect do
  @moduledoc """
  Represent a rectangle. Used as the backbone of all the graphics calculations
  You should probably not use this directly but use `%RectLayout.Sprite{}` structs as they can track which external (svg) object you are manipulating

  Should not be created directly but by using the `RectLayout.rect/4` constructor

  Implements `RectLayout.Object` protocol so it can be used in the layout calculations
  """
  defstruct x: 0, y: 0, width: 0, height: 0

  @type t() :: %__MODULE__{
          :x => number(),
          :y => number(),
          :width => number(),
          :height => number()
        }
end

defimpl RectLayout.Object, for: RectLayout.Rect do
  alias RectLayout.Rect

  def x(%Rect{x: x}), do: x

  def x(%Rect{} = rect, x), do: %{rect | x: x}

  def y(%Rect{y: y}), do: y

  def y(%Rect{} = rect, y), do: %{rect | y: y}

  def width(%Rect{width: width}), do: width

  def width(%Rect{} = rect, width), do: %{rect | width: width}

  def height(%Rect{height: height}), do: height

  def height(%Rect{} = rect, height), do: %{rect | height: height}
end
