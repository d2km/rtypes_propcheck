# rtypes_propcheck

The library implements a
[PropCheck](https://hexdocs.pm/propcheck/readme.html) generator
backend for the [RTypes library](https://github.com/d2km/rtypes).

## Usage

Let's suppose you defined a type and you have a function `f/1` which
takes a value of that type and returns a value of some other type

```elixir
defmodule MyModule do
  @type foo :: %{key1: integer(), key2: Keyword.t()}
  @type goo :: 1..512

  @spec f(foo) :: goo
  def f(a_foo) do
    # ...
  end
end
```

Now, you want to write a property to ensure that your function is
total, that is, for any value that belongs to type `foo` you expect
the function to return a value of type `goo`.

You can achieve this as follows

```elixir
defmodule MyTest do
  use PropCheck
  use ExUnit.Case
  require RTypes.Generator, as Generator
  require RTypes

  property "f(foo) always returns goo" do
    gen = Generator.make(MyModule.foo(), Generator.PropCheck)
    goo? = RTypes.make_predicate(MyModule.goo())

    forall value <- gen() do
      goo?.(MyModule.f(value))
    end
  end
end
```

See `test/rtypes_propcheck_test.exs` for some examples.
