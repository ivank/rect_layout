defmodule RectLayout.Sprite do
  @moduledoc """
  Represent a graphical object and tracks its position and size using `%RectLayout.Rect{}` struct

  Should not be created directly but by using the `RectLayout.sprite/2` constructor

  Implements `RectLayout.Object` protocol so it can be used in the layout calculations
  """

  alias RectLayout.Rect
  defstruct rect: %Rect{}, content: nil

  @type t() :: %__MODULE__{:rect => Rect.t(), :content => any()}
end

defimpl RectLayout.Object, for: RectLayout.Sprite do
  alias RectLayout.Object
  alias RectLayout.Sprite

  def x(%Sprite{rect: rect}), do: Object.x(rect)

  def x(%Sprite{rect: rect} = sprite, x), do: %{sprite | rect: Object.x(rect, x)}

  def y(%Sprite{rect: rect}), do: Object.y(rect)

  def y(%Sprite{rect: rect} = sprite, y), do: %{sprite | rect: Object.y(rect, y)}

  def width(%Sprite{rect: rect}), do: Object.width(rect)

  def width(%Sprite{rect: rect} = sprite, width),
    do: %{sprite | rect: Object.width(rect, width)}

  def height(%Sprite{rect: rect}), do: Object.height(rect)

  def height(%Sprite{rect: rect} = sprite, height),
    do: %{sprite | rect: Object.height(rect, height)}
end
