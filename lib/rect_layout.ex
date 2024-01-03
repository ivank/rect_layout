defmodule RectLayout do
  @moduledoc """
  Create and manipulate rectangular objects and groups of them

  Use `import RectLayout` to import everything, or import only the methods you need.
  """

  alias RectLayout.Object
  alias RectLayout.Group
  alias RectLayout.Sprite
  alias RectLayout.Rect

  @doc """
  Creates an `%RectLayout.Group{}`, used to work with a group of graphical items.
  any modification of its x, y, width or height affects all of its children, proportionally.

  ## Examples

      iex> group([rect(10,20),rect(5,5)])
      %RectLayout.Group{
        rect: %RectLayout.Rect{x: 0, y: 0, width: 10, height: 20},
        children: [
          %RectLayout.Rect{x: 0, y: 0, width: 10, height: 20},
          %RectLayout.Rect{x: 0, y: 0, width: 5, height: 5}
        ]
      }
  """
  @doc section: :constructor
  @spec group(list(Object.t())) :: Group.t()
  def group(children) do
    %Group{rect: surrounding_rect(children), children: children}
  end

  @doc """
  Creates an `%RectLayout.Rect{}`, a primitive used to track info about rectangles.
  It does not have any other attributes except its x, y, width and height

  ## Examples

      iex> rect(10, 20, 2, 5)
      %RectLayout.Rect{x: 2, y: 5, width: 10, height: 20}

      iex> rect(10, 20)
      %RectLayout.Rect{x: 0, y: 0, width: 10, height: 20}

  """
  @doc section: :constructor
  @spec rect(width :: number(), height :: number(), x :: number(), y :: number()) :: Rect.t()
  def rect(width, height, x \\ 0, y \\ 0) do
    %Rect{x: x, y: y, width: width, height: height}
  end

  @doc """
  Creates an `%RectLayout.Sprite{}`, which is used to track external data for a rect.

  ## Examples

      iex> image = "my image"
      "my image"
      iex> sprite(rect(10, 20), image)
      %RectLayout.Sprite{
        rect: %RectLayout.Rect{x: 0, y: 0, width: 10, height: 20},
        content: "my image"
      }

  """
  @doc section: :constructor
  @spec sprite(Rect.t(), any()) :: Sprite.t()
  def sprite(rect, content) do
    %Sprite{rect: rect, content: content}
  end

  # Accessors
  # ---------------------------

  @doc """
  Get the content of a sprite.

  ## Examples

      iex> s = sprite(rect(10, 20), "one")
      iex> sprite_content(s)
      "one"

  """
  @doc section: :accessor
  @spec sprite_content(Sprite.t()) :: any()
  def sprite_content(%Sprite{content: content}) do
    content
  end

  @doc """
  Update the content of a sprite.

  ## Examples

      iex> s = sprite(rect(10, 20), "one")
      iex> sprite_content(s, "two")
      %RectLayout.Sprite{
        rect: %RectLayout.Rect{x: 0, y: 0, width: 10, height: 20},
        content: "two"
      }

  """
  @doc section: :accessor
  @spec sprite_content(Sprite.t(), any()) :: Sprite.t()
  def sprite_content(%Sprite{} = sprite, content) do
    %{sprite | content: content}
  end

  @doc """
  Get the children of a group

  ## Examples

      iex> g = group([rect(10, 20), rect(5, 5)])
      iex> group_children(g)
      [
        %RectLayout.Rect{x: 0, y: 0, width: 10, height: 20},
        %RectLayout.Rect{x: 0, y: 0, width: 5, height: 5}
      ]

  """
  @doc section: :accessor
  @spec group_children(Group.t()) :: list(Object.t())
  def group_children(%Group{children: children}) do
    children
  end

  @doc """
  Update the children of a group
  When updating it will also will update the bounding rect of the group

  ## Examples

      iex> g = group([rect(10, 20), rect(5, 5)])
      iex> group_children(g, [rect(2, 2)])
      %RectLayout.Group{
        rect: %RectLayout.Rect{x: 0, y: 0, width: 2, height: 2},
        children: [
          %RectLayout.Rect{x: 0, y: 0, width: 2, height: 2}
        ]
      }

  """
  @doc section: :accessor
  @spec group_children(Group.t(), list(Object.t())) :: Group.t()
  def group_children(%Group{} = group, children) do
    %{group | rect: surrounding_rect(children), children: children}
  end

  @doc """
  Get the x attribute of the item. Shortcut for `RectLayout.Object.x/1`
  """
  @doc section: :accessor
  @spec x(Object.t()) :: number()
  def x(item) do
    Object.x(item)
  end

  @doc """
  Set the x attribute of the item. Shortcut for `RectLayout.Object.x/2`
  """
  @doc section: :accessor
  @spec x(Object.t(), number()) :: Object.t()
  def x(item, x) do
    Object.x(item, x)
  end

  @doc """
  Get the y attribute of the item. Shortcut for `RectLayout.Object.y/1`
  """
  @doc section: :accessor
  @spec y(Object.t()) :: number()
  def y(item) do
    Object.y(item)
  end

  @doc """
  Set the y attribute of the item. Shortcut for `RectLayout.Object.y/2`
  """
  @doc section: :accessor
  @spec y(Object.t(), number()) :: Object.t()
  def y(item, y) do
    Object.y(item, y)
  end

  @doc """
  Get the width attribute of the item. Shortcut for `RectLayout.Object.width/1`
  """
  @doc section: :accessor
  @spec width(Object.t()) :: number()
  def width(item) do
    Object.width(item)
  end

  @doc """
  Set the width attribute of the item. Shortcut for `RectLayout.Object.width/2`
  """
  @doc section: :accessor
  @spec width(Object.t(), number()) :: Object.t()
  def width(item, width) do
    Object.width(item, width)
  end

  @doc """
  Get the height attribute of the item. Shortcut for `RectLayout.Object.height/1`
  """
  @doc section: :accessor
  @spec height(Object.t()) :: number()
  def height(item) do
    Object.height(item)
  end

  @doc """
  Set the height attribute of the item. Shortcut for `RectLayout.Object.height/2`
  """
  @doc section: :accessor
  @spec height(Object.t(), number()) :: Object.t()
  def height(item, height) do
    Object.height(item, height)
  end

  @doc """
  Get the center x attribute of the item.

  ## Visual

       *---*
      -|---|-
       *---*

  ## Examples

    iex> center_x(rect(3, 5))
    1.5

  """
  @doc section: :accessor
  @spec center_x(Object.t()) :: number()
  def center_x(value) do
    x(value) + width(value) / 2
  end

  @doc """
  Set the center x attribute of the item.
  Position the item so that the new x is now its horizontal center

  ## Visual

       *---*
      -|---|-
       *---*

  ## Examples

    iex> center_x(rect(3, 5), 5)
    %RectLayout.Rect{x: 3.5, y: 0, width: 3, height: 5}


  """
  @doc section: :accessor
  @spec center_x(Object.t(), number()) :: Object.t()
  def center_x(value, x) do
    value |> x(x - width(value) / 2)
  end

  @doc """
  Get the center y attribute of the item.

  ## Visual

      *-|-*
      | | |
      *-|-*

  ## Examples

    iex> center_y(rect(3, 5))
    2.5

  """
  @doc section: :accessor
  @spec center_y(Object.t()) :: number()
  def center_y(value) do
    y(value) + height(value) / 2
  end

  @doc """
  Set the center y attribute of the item.
  Position the item so that the new y is now its vertical center

  ## Visual

      *-|-*
      | | |
      *-|-*

  ## Examples

    iex> center_y(rect(3, 5), 5)
    %RectLayout.Rect{x: 0, y: 2.5, width: 3, height: 5}

  """
  @doc section: :accessor
  @spec center_y(Object.t(), number()) :: Object.t()
  def center_y(value, y) do
    value |> y(y - height(value) / 2)
  end

  @doc """
  Get the maximum height of a list of items

  ## Examples

    iex> max_height([rect(2, 1), rect(3, 5, 1, 1), rect(4, 4, 1, 1)])
    5

  """
  @doc section: :accessor
  @spec max_height(list(Object.t())) :: number()
  def max_height(rects) do
    rects |> Enum.map(&height/1) |> Enum.max()
  end

  @doc """
  Get the maximum width of a list of items

  ## Examples

    iex> max_width([rect(2, 1), rect(3, 5, 1, 1), rect(4, 4, 1, 1)])
    4

  """
  @doc section: :accessor
  @spec max_width(list(Object.t())) :: number()
  def max_width(rects) do
    rects |> Enum.map(&width/1) |> Enum.max()
  end

  @doc """
  Get the leftmost x of a list of items

  ## Visual

      |
      *---*
      |   |
      *---*
      |    *---*
      |    |   |
      |    *---*

  ## Examples

    iex> left([rect(2, 2), rect(2, 2, 2, 2)])
    0

  """
  @doc section: :accessor
  @spec left(list(Object.t())) :: number()
  def left(rects) do
    rects |> Enum.map(&x/1) |> Enum.min()
  end

  @doc """
  Get the topmost y of a list of items

  ## Visual

    -*---*-----
     |   |
     *---*
           *---*
           |   |
           *---*

  ## Examples

    iex> top([rect(2, 2), rect(2, 2, 2, 2)])
    0

  """
  @doc section: :accessor
  @spec top(list(Object.t())) :: number()
  def top(rects) do
    rects |> Enum.map(&y/1) |> Enum.min()
  end

  @doc """
  Get the rightmost x of an item or a list of items

  ## Visual

    *---*   |
    |   |   |
    *---*   |
        *---*
        |   |
        *---*
            |

  ## Examples

    iex> right(rect(2, 2))
    2
    iex> right(rect(2, 2, 2, 2))
    4
    iex> right([rect(2, 2), rect(2, 2, 2, 2)])
    4

  """
  @doc section: :accessor
  @spec right(Object.t() | list(Object.t())) :: number()
  def right(items) when is_list(items) do
    items |> Enum.map(&right/1) |> Enum.max()
  end

  def right(items) do
    x(items) + width(items)
  end

  @doc """
  Set the x so the rightmost part of the item is at x

  ## Examples

    iex> right(rect(2, 2), 4)
    %RectLayout.Rect{x: 2, y: 0, width: 2, height: 2}

  """
  @doc section: :accessor
  @spec right(Object.t(), number()) :: Object.t()
  def right(items, value) do
    x(items, value - width(items))
  end

  @doc """
  Get the bottommost y of an item or a list of items

  ## Visual

      *---*
      |   |
      *---*
           *---*
           |   |
      -----*---*-

  ## Examples

    iex> bottom(rect(2, 2))
    2
    iex> bottom(rect(2, 2, 2, 2))
    4
    iex> bottom([rect(2, 2), rect(2, 2, 2, 2)])
    4

  """
  @doc section: :accessor
  @spec bottom(Object.t() | list(Object.t())) :: number()
  def bottom(items) when is_list(items) do
    items |> Enum.map(&bottom/1) |> Enum.max()
  end

  def bottom(item) do
    y(item) + height(item)
  end

  @doc """
  Set the y so the bottommost part of the item is at y

  ## Examples

    iex> bottom(rect(2, 2), 4)
    %RectLayout.Rect{x: 0, y: 2, width: 2, height: 2}

  """
  @doc section: :accessor
  @spec bottom(Object.t(), number()) :: Object.t()
  def bottom(items, value) do
    y(items, value - height(items))
  end

  @doc """
  Create a rectangle that surrounds all the items in the list

  ## Visual

      *---*----*
      |   |    |
      *---*    |
      |    *---*
      |    |   |
      *----*---*

  ## Examples

      iex> surrounding_rect([rect(2, 2), rect(2, 2, 2, 2)])
      %RectLayout.Rect{x: 0, y: 0, width: 4, height: 4}

  """
  @doc section: :accessor
  @spec surrounding_rect(list(Object.t())) :: Rect.t()
  def surrounding_rect(list) do
    rect(right(list) - left(list), bottom(list) - top(list), left(list), top(list))
  end

  # Transform
  # ---------------------------

  @doc """
  Push item to the right of a given line. If the line is before it, don't do anything

  ## Visual

      *|--*    |---*
      ||  | -> |   |
      *|--*    |---*

  ## Examples

      iex> threshold_left(rect(2, 2), 1)
      %RectLayout.Rect{x: 1, y: 0, width: 2, height: 2}

      iex> threshold_left(rect(2, 2, 5), 1)
      %RectLayout.Rect{x: 5, y: 0, width: 2, height: 2}

  """
  @doc section: :transform
  @spec threshold_left(Object.t(), number()) :: Object.t()
  def threshold_left(item, value) do
    if(x(item) < value, do: x(item, value), else: item)
  end

  @doc """
  Push item to the left of a given line. If the line is before it, don't do anything

  ## Visual

         |         |
      *--|*    *---*
      |  || -> |   |
      *--|*    *---*
         |         |

  ## Examples

      iex> threshold_right(rect(2, 2), 4)
      %RectLayout.Rect{x: 0, y: 0, width: 2, height: 2}

      iex> threshold_right(rect(2, 2, 5), 4)
      %RectLayout.Rect{x: 2, y: 0, width: 2, height: 2}

  """
  @doc section: :transform
  @spec threshold_right(Object.t(), number()) :: Object.t()
  def threshold_right(item, value) do
    if(right(item) > value, do: right(item, value), else: item)
  end

  @doc """
  Push item to the bottom of a given line. If the line is before it, don't do anything

  ## Visual

       *---*     -*---*-
      -|---|- ->  |   |
       *---*      *---*

  ## Examples

      iex> threshold_top(rect(2, 2), 2)
      %RectLayout.Rect{x: 0, y: 2, width: 2, height: 2}

      iex> threshold_top(rect(2, 2, 0, 5), 2)
      %RectLayout.Rect{x: 0, y: 5, width: 2, height: 2}

  """
  @doc section: :transform
  @spec threshold_top(Object.t(), number()) :: Object.t()
  def threshold_top(item, value) do
    if(y(item) < value, do: y(item, value), else: item)
  end

  @doc """
  Push item to the top of a given line. If the line is before it, don't do anything

  ## Visual

       *---*      *---*
      -|---|- ->  |   |
       *---*     -*---*-

  ## Examples

      iex> threshold_bottom(rect(2, 2), 5)
      %RectLayout.Rect{x: 0, y: 0, width: 2, height: 2}

      iex> threshold_bottom(rect(2, 2, 0, 5), 4)
      %RectLayout.Rect{x: 0, y: 2, width: 2, height: 2}

  """
  @doc section: :transform
  @spec threshold_bottom(Object.t(), number()) :: Object.t()
  def threshold_bottom(item, value) do
    if(bottom(item) > value, do: bottom(item, value), else: item)
  end

  @doc """
  Extrude the edges of a rect outward (or inward) and keeping the position

  ## Visual

                 *-------*
      *---*      |       |
      |   |  ->  |       |
      *---*      |       |
                 *-------*
  ## Examples

      iex> extrude(rect(2, 2), 1)
      %RectLayout.Rect{x: -1, y: -1, width: 4, height: 4}

      iex> extrude(rect(4, 4), -1)
      %RectLayout.Rect{x: 1, y: 1, width: 2, height: 2}

  """
  @doc section: :transform
  @spec extrude(item :: Object.t(), number()) :: Object.t()
  def extrude(item, value) do
    item
    |> x(x(item) - value)
    |> y(y(item) - value)
    |> width(width(item) + value * 2)
    |> height(height(item) + value * 2)
  end

  @doc """
  Set the width and modify the height to keep the aspect ratio
  For a list, apply the new width to each item in the list

  ## Examples

      iex> constrain_width(rect(2, 4), 4)
      %RectLayout.Rect{x: 0, y: 0, width: 4, height: 8.0}

      iex> constrain_width([rect(2, 4), rect(8, 4)], 4)
      [
        %RectLayout.Rect{x: 0, y: 0, width: 4, height: 8.0},
        %RectLayout.Rect{x: 0, y: 0, width: 4, height: 2.0}
      ]

  """
  @doc section: :transform
  @spec constrain_width(items :: list(Object.t()), value :: number()) :: list(Object.t())
  def constrain_width(items, value) when is_list(items) do
    items |> Enum.map(&constrain_width(&1, value))
  end

  @spec constrain_width(item :: Object.t(), value :: number()) :: Object.t()
  def constrain_width(item, value) do
    item |> width(value) |> height(height(item) / width(item) * value)
  end

  @doc """
  Set the height and modify the width to keep the aspect ratio
  For a list, apply the new height to each item in the list

  ## Examples

      iex> constrain_height(rect(4, 2), 4)
      %RectLayout.Rect{x: 0, y: 0, width: 8.0, height: 4}

      iex> constrain_height([rect(4, 2), rect(4, 8)], 4)
      [
        %RectLayout.Rect{x: 0, y: 0, width: 8.0, height: 4},
        %RectLayout.Rect{x: 0, y: 0, width: 2.0, height: 4}
      ]

  """
  @doc section: :transform
  @spec constrain_height(items :: list(Object.t()), value :: number()) :: list(Object.t())
  def constrain_height(item, value) when is_list(item) do
    item |> Enum.map(&constrain_height(&1, value))
  end

  @spec constrain_height(item :: Object.t(), value :: number()) :: Object.t()
  def constrain_height(item, value) do
    item |> height(value) |> width(width(item) / height(item) * value)
  end

  @doc """
  Align each item the leftmost item

  ## Visual

                        |
      *--*              *--*
      |  |              |  |
      *--*              *--*
           *---*   ->   *---*
           |   |        |   |
           *---*        *---*
                        |

  ## Examples

      iex> align_left([rect(2, 2), rect(3, 3, 2, 2)])
      [
        %RectLayout.Rect{x: 0, y: 0, width: 2, height: 2},
        %RectLayout.Rect{x: 0, y: 2, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec align_left(list(Object.t())) :: list(Object.t())
  def align_left(items) do
    items |> Enum.map(&x(&1, left(items)))
  end

  @doc """
  Align each item to a given x value to the left

  ## Visual

      |                    |
      | *--*               *--*
      | |  |               |  |
      | *--*               *--*
      |      *---*   ->    *---*
      |      |   |         |   |
      |      *---*         *---*
      |                    |

  ## Examples

      iex> align_left([rect(2, 2), rect(3, 3, 2, 2)], -2)
      [
        %RectLayout.Rect{x: -2, y: 0, width: 2, height: 2},
        %RectLayout.Rect{x: -2, y: 2, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec align_left(list(Object.t()), value :: number()) :: list(Object.t())
  def align_left(items, value) do
    items |> Enum.map(&x(&1, value))
  end

  @doc """
  Align each item to the topmost item

  ## Visual

      *--*            -*--*-*---*-
      |  |             |  | |   |
      *--*         ->  *--* *---*
            *---*
            |   |
            *---*

  ## Examples

      iex> align_top([rect(2, 2), rect(3, 3, 2, 2)])
      [
        %RectLayout.Rect{x: 0, y: 0, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 0, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec align_top(list(Object.t())) :: list(Object.t())
  def align_top(items) do
    items |> Enum.map(&y(&1, top(items)))
  end

  @doc """
  Align each item to a given y value

  ## Visual

      ------------    -*--*-*---*-
      *--*             |  | |   |
      |  |             *--* *---*
      *--*         ->
            *---*
            |   |
            *---*

  ## Examples

      iex> align_top([rect(2, 2), rect(3, 3, 2, 2)])
      [
        %RectLayout.Rect{x: 0, y: 0, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 0, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec align_top(items :: list(Object.t()), value :: number()) :: list(Object.t())
  def align_top(items, value) do
    items |> Enum.map(&y(&1, value))
  end

  @doc """
  Align each item to the rightmost item


  ## Visual

                           |
      *--*              *--*
      |  |              |  |
      *--*        ->    *--*
           *---*       *---*
           |   |       |   |
           *---*       *---*
                           |
  ## Examples

      iex> align_right([rect(2, 2), rect(3, 3, 2, 2)])
      [
        %RectLayout.Rect{x: 3, y: 0, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 2, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec align_right(items :: list(Object.t())) :: list(Object.t())
  def align_right(items) do
    items |> Enum.map(&right(&1, right(items)))
  end

  @doc """
  Align each item to a given x value to the right

  ## Visual

                 |            |
      *--*       |         *--*
      |  |       |         |  |
      *--*       | ->      *--*
           *---* |        *---*
           |   | |        |   |
           *---* |        *---*
                 |            |
  ## Examples

      iex> align_right([rect(2, 2), rect(3, 3, 2, 2)], 6)
      [
        %RectLayout.Rect{x: 4, y: 0, width: 2, height: 2},
        %RectLayout.Rect{x: 3, y: 2, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec align_right(items :: list(Object.t()), value :: number()) :: list(Object.t())
  def align_right(items, value) do
    items |> Enum.map(&right(&1, value))
  end

  @doc """
  Align each item to the bottommost item

  ## Visual

      *--*
      |  |
      *--*         ->
            *---*      *--* *---*
            |   |      |  | |   |
            *---*     -*--*-*---*-

  ## Examples

      iex> align_bottom([rect(2, 2), rect(3, 3, 2, 2)])
      [
        %RectLayout.Rect{x: 0, y: 3, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 2, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec align_bottom(items :: list(Object.t())) :: list(Object.t())
  def align_bottom(items) do
    items |> Enum.map(&bottom(&1, bottom(items)))
  end

  @doc """
  Align each item to a given y value

  ## Visual

      *--*
      |  |
      *--*         ->
            *---*
            |   |      *--* *---*
            *---*      |  | |   |
      ------------    -*--*-*---*-

  ## Examples

      iex> align_bottom([rect(2, 2), rect(3, 3, 2, 2)], 6)
      [
        %RectLayout.Rect{x: 0, y: 4, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 3, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec align_bottom(items :: list(Object.t()), value :: number()) :: list(Object.t())
  def align_bottom(items, value) do
    items |> Enum.map(&bottom(&1, value))
  end

  @doc """
  Spread out each item in the list horizontally to cover the assigned `width`
  Items are spread evenly centered on their vertical axis
  No overlap is allowed and items push each other to the right

  ### Options:

  - `:x` from which x position to start the spread, default `0`
  - `:gap` the minimum gap between items, default `0`
  - `:cols` the number of columns to spread items in, you can select a bigger number than the number of items, default `length(items)`

  ## Visual

                          |        |        |
      *---*-*-*         *-|-*   *--|--* *---|---*
      |   | | |         | | |   |  |  | |   |   |
      *---* | |    ->   *-|-*   |  |  | |   |   |
      *---*-*-*           |     *--|--* *---|---*
                          |        |        |
                          |        |        |
                      <----------width---------->


  ## Examples

      iex> spread_horizontal([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], 9)
      [
        %RectLayout.Rect{x: 1.0, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 3.5, y: 1, width: 2, height: 2},
        %RectLayout.Rect{x: 6.0, y: 2, width: 3, height: 3}
      ]

      iex> spread_horizontal([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], 6, gap: 2)
      [
        %RectLayout.Rect{x: 0.5, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 3.5, y: 1, width: 2, height: 2},
        %RectLayout.Rect{x: 7.5, y: 2, width: 3, height: 3}
      ]

      iex> spread_horizontal([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], 9, x: 2)
      [
        %RectLayout.Rect{x: 3.0, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 5.5, y: 1, width: 2, height: 2},
        %RectLayout.Rect{x: 8.0, y: 2, width: 3, height: 3}
      ]

      iex(4)> spread_horizontal([rect(1, 1, 0, 0), rect(2, 2, 1, 1)], 9, cols: 3)
      [
        %RectLayout.Rect{x: 1.0, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 3.5, y: 1, width: 2, height: 2},
      ]

  """
  @doc section: :transform
  @type spread_horizontal_option :: [{:x, number()} | {:gap, number()} | {:cols, number()}]
  @spec spread_horizontal(
          items :: list(Object.t()),
          width :: number(),
          opts :: spread_horizontal_option()
        ) :: list(Object.t())
  def spread_horizontal(items, width, opts \\ []) when is_list(items) do
    opts = opts |> Keyword.validate!(x: 0, cols: length(items), gap: 0)
    col_width = width / opts[:cols]
    offset = col_width / 2

    items
    |> Enum.with_index()
    |> Enum.map_reduce(nil, fn {rect, index}, prev ->
      rect =
        rect
        |> center_x(opts[:x] + col_width * index + offset)
        |> threshold_left(if(prev, do: opts[:gap] + right(prev), else: x(rect)))

      {rect, rect}
    end)
    |> elem(0)
  end

  @doc """
  Spread out each item in the list vertically to cover the assigned `height`
  Items are spread evenly centered on their horizontal axis
  No overlap is allowed and items push each other down

  ### Options:

  - `:y` from which y position to start the spread, default `0`
  - `:gap` the minimum gap between items, default `0`
  - `:rows` the number of rows to spread items in, you can select a bigger number than the number of items, default `length(items)`

  ## Visual

                                             ▲
                                             |
                              *---*          |
                          ----|   |------    |
                              *---*          |
                                             |
      *---*-*-*                              |
      |   | | |               *-----*        |
      *---* | |    ->         |     |        |
      |     | |           ----|     |----  height
      *-----* |               |     |        |
      |       |               *-----*        |
      *-------*               *-------*      |
                              |       |      |
                              |       |      |
                          ----|       |--    |
                              |       |      |
                              |       |      |
                              *-------*      ▼


  ## Examples

      iex> spread_vertical([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], 9)
      [
        %RectLayout.Rect{x: 0, y: 1.0, width: 1, height: 1},
        %RectLayout.Rect{x: 1, y: 3.5, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 6.0, width: 3, height: 3}
      ]

      iex> spread_vertical([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], 6, gap: 2)
      [
        %RectLayout.Rect{x: 0, y: 0.5, width: 1, height: 1},
        %RectLayout.Rect{x: 1, y: 3.5, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 7.5, width: 3, height: 3}
      ]

      iex> spread_vertical([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], 9, y: 2)
      [
        %RectLayout.Rect{x: 0, y: 3.0, width: 1, height: 1},
        %RectLayout.Rect{x: 1, y: 5.5, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 8.0, width: 3, height: 3}
      ]

      iex(4)> spread_vertical([rect(1, 1, 0, 0), rect(2, 2, 1, 1)], 9, rows: 3)
      [
        %RectLayout.Rect{x: 0, y: 1.0, width: 1, height: 1},
        %RectLayout.Rect{x: 1, y: 3.5, width: 2, height: 2},
      ]

  """
  @doc section: :transform
  @type spread_vertical_option :: [{:x, number()} | {:gap, number()} | {:cols, number()}]
  @spec spread_vertical(
          items :: list(Object.t()),
          height :: number(),
          opts :: spread_vertical_option()
        ) :: list(Object.t())
  def spread_vertical(items, height, opts \\ []) when is_list(items) do
    opts = opts |> Keyword.validate!(y: 0, rows: length(items), gap: 0)
    row_height = height / opts[:rows]
    offset = row_height / 2

    items
    |> Enum.with_index()
    |> Enum.map_reduce(nil, fn {rect, index}, prev ->
      rect =
        rect
        |> center_y(opts[:y] + row_height * index + offset)
        |> threshold_top(if(prev, do: opts[:gap] + bottom(prev), else: y(rect)))

      {rect, rect}
    end)
    |> elem(0)
  end

  @doc """
  Distribute each item in the list horizontally to cover the assigned `width` with a consistent gap between items

  ## Visual

      *---*-*-*         *---*  *-----*  *-------*
      |   | | |         |   |  |     |  |       |
      *---* | |    ->   *---*  |     |  |       |
      *---*-*-*                *---*-*  *---*---*
                        <--------width---------->


  ## Examples

      iex> distribute_horizontal([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], 12)
      [
        %RectLayout.Rect{x: 0, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 4.0, y: 1, width: 2, height: 2},
        %RectLayout.Rect{x: 9.0, y: 2, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec distribute_horizontal(items :: list(Object.t()), width :: number()) :: list(Object.t())
  def distribute_horizontal(items, width) when is_list(items) do
    gap = (width - (items |> Enum.map(&width(&1)) |> Enum.sum())) / (length(items) - 1)
    items |> Enum.map_reduce(0, &{x(&1, &2), &2 + width(&1) + gap}) |> elem(0)
  end

  @doc """
  Distribute each item in the list vertically to cover the assigned `height` with a consistent gap between items

  ## Visual

                         *---*      ▲
                         |   |      |
                         *---*      |
                                    |
      *---*-*-*          *-----*    |
      |   | | |          |     |    |
      *---* | |    ->    |     |    |
      |     | |          |     |  height
      *-----* |          *-----*    |
      |       |                     |
      *-------*          *-------*  |
                         |       |  |
                         |       |  |
                         |       |  |
                         |       |  |
                         |       |  |
                         *-------*  ▼

  ## Examples

      iex> distribute_vertical([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], 12)
      [
        %RectLayout.Rect{x: 0, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 1, y: 4.0, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 9.0, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @spec distribute_vertical(items :: list(Object.t()), height :: number()) :: list(Object.t())
  def distribute_vertical(items, height) when is_list(items) do
    gap = (height - (items |> Enum.map(&height(&1)) |> Enum.sum())) / (length(items) - 1)
    items |> Enum.map_reduce(0, &{y(&1, &2), &2 + height(&1) + gap}) |> elem(0)
  end

  @doc """
  Distribute each item in the list horizontally with a set gap

  ### Options

  - `:x` where to start the flow from, default `0`
  - `:gap` the gap between items, default `0`

  ## Visual

      *---*-*-*         *---**-----**-------*
      |   | | |         |   ||     ||       |
      *---* | |    ->   *---*|     ||       |
      *---*-*-*              *-----**-------*
                        <-------width------->


  ## Examples

      iex> flow_horizontal([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)])
      [
        %RectLayout.Rect{x: 0, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 1, y: 1, width: 2, height: 2},
        %RectLayout.Rect{x: 3, y: 2, width: 3, height: 3}
      ]

      iex> flow_horizontal([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], gap: 2)
      [
        %RectLayout.Rect{x: 0, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 3, y: 1, width: 2, height: 2},
        %RectLayout.Rect{x: 7, y: 2, width: 3, height: 3}
      ]

      iex> flow_horizontal([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], gap: 2, x: 2)
      [
        %RectLayout.Rect{x: 2, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 5, y: 1, width: 2, height: 2},
        %RectLayout.Rect{x: 9, y: 2, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @type flow_horizontal_option :: [{:x, number()} | {:gap, number()}]
  @spec flow_horizontal(items :: list(Object.t()), opts :: flow_horizontal_option()) ::
          list(Object.t())
  def flow_horizontal(items, opts \\ []) when is_list(items) do
    opts = opts |> Keyword.validate!(x: 0, gap: 0)
    items |> Enum.map_reduce(opts[:x], &{x(&1, &2), &2 + width(&1) + opts[:gap]}) |> elem(0)
  end

  @doc """
  Distribute each item in the list vertically with a set gap

  ### Options

  - `:y` where to start the flow from, default `0`
  - `:gap` the gap between items, default `0`

  ## Visual

                         *---*      ▲
                         |   |      |
                         *---*      |
      *---*-*-*          *-----*    |
      |   | | |          |     |    |
      *---* | |    ->    |     |    |
      |     | |          |     |  height
      *-----* |          *-----*    |
      |       |          *-------*  |
      *-------*          |       |  |
                         |       |  |
                         |       |  |
                         |       |  |
                         |       |  |
                         *-------*  ▼

  ## Examples

      iex> flow_vertical([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)])
      [
        %RectLayout.Rect{x: 0, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 1, y: 1, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 3, width: 3, height: 3}
      ]

      iex> flow_vertical([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], gap: 2)
      [
        %RectLayout.Rect{x: 0, y: 0, width: 1, height: 1},
        %RectLayout.Rect{x: 1, y: 3, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 7, width: 3, height: 3}
      ]

      iex> flow_vertical([rect(1, 1, 0, 0), rect(2, 2, 1, 1), rect(3, 3, 2, 2)], gap: 2, y: 2)
      [
        %RectLayout.Rect{x: 0, y: 2, width: 1, height: 1},
        %RectLayout.Rect{x: 1, y: 5, width: 2, height: 2},
        %RectLayout.Rect{x: 2, y: 9, width: 3, height: 3}
      ]

  """
  @doc section: :transform
  @type flow_vertical_option :: [{:y, number()} | {:gap, number()}]
  @spec flow_vertical(items :: list(Object.t()), opts :: flow_vertical_option()) ::
          list(Object.t())
  def flow_vertical(items, opts \\ []) when is_list(items) do
    opts = opts |> Keyword.validate!(y: 0, gap: 0)
    items |> Enum.map_reduce(opts[:y], &{y(&1, &2), &2 + height(&1) + opts[:gap]}) |> elem(0)
  end
end
