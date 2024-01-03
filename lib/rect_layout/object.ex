defprotocol RectLayout.Object do
  @moduledoc """
    A common attribute access protocol that graphical object implement
    Allows them to be used inside the layout calculations
    You can use your own custom objects as well, as long as they implement the same protocol
  """

  @spec x(t) :: number()
  def x(item)

  @spec x(t, number()) :: t
  def x(item, x)

  @spec x(t) :: number()
  def y(item)

  @spec x(t, number()) :: t
  def y(item, y)

  @spec x(t) :: number()
  def width(item)

  @spec x(t, number()) :: t
  def width(item, width)

  @spec x(t) :: number()
  def height(item)

  @spec x(t, number()) :: t
  def height(item, height)
end
