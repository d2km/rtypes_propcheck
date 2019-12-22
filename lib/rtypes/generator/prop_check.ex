defmodule RTypes.Generator.PropCheck do
  @moduledoc """
  The module contains functions to derive generators to be used with PropCheck library.
  """

  import PropCheck, only: [let: 2]
  import PropCheck.BasicTypes

  @behaviour RTypes.Generator

  @doc """
  Derive a PropCheck generator for the specified type AST.
  """
  @spec derive(RTypes.Extractor.type()) :: PropCheck.BasicTypes.type()

  @impl RTypes.Generator

  def derive({:type, _line, :any, _args}), do: &any/0

  def derive({:type, _line, :atom, _args}), do: &atom/0

  def derive({:type, _line, :integer, _args}), do: &integer/0

  def derive({:type, _line, :float, _args}), do: &float/0

  ## literals
  def derive({:atom, _line, term}), do: fn -> exactly(term) end

  def derive({:integer, _line, term}), do: fn -> exactly(term) end

  ## ranges
  def derive({:type, _, :range, [{:integer, _, l}, {:integer, _, u}]}) do
    fn -> integer(l, u) end
  end

  ## binary
  def derive({:type, _line, :binary, []}), do: &binary/0

  ## bitstrings
  def derive({:type, _line, :binary, [{:integer, _, 0}, {:integer, _, 0}]}) do
    fn -> bitstring(0) end
  end

  def derive({:type, _line, :binary, [{:integer, _, 0}, {:integer, _, units}]}) do
    fn ->
      let count <- non_neg_integer() do
        bitstring(units * count)
      end
    end
  end

  def derive({:type, _line, :binary, [{:integer, _, size}, _]}) do
    fn -> bitstring(size) end
  end

  ## empty list
  def derive({:type, _line, nil, _args}), do: fn -> exactly([]) end

  ## composite types

  ## lists
  def derive({:type, _line, :list, []}), do: &list/0

  def derive({:type, _line, :list, [typ]}) do
    g = derive(typ)
    fn -> list(g.()) end
  end

  def derive({:type, _line, :nonempty_list, []}) do
    fn -> non_empty(list()) end
  end

  def derive({:type, _line, :nonempty_list, [typ]}) do
    g = derive(typ)
    fn -> non_empty(list(g.())) end
  end

  def derive({:type, _line, :maybe_improper_list, []}) do
    fn ->
      let {h, t} <- {term(), term()} do
        oneof([[], [h | t]])
      end
    end
  end

  def derive({:type, _line, :maybe_improper_list, [typ1, typ2]}) do
    g1 = derive(typ1)
    g2 = derive(typ2)

    fn ->
      let {h, t} <- {g1.(), g2.()} do
        oneof([[], [h | t]])
      end
    end
  end

  def derive({:type, _line, :nonempty_maybe_improper_list, []}) do
    fn ->
      let {h, t} <- {term(), term()} do
        [h | t]
      end
    end
  end

  def derive({:type, _line, :nonempty_maybe_improper_list, [typ1, typ2]}) do
    g1 = derive(typ1)
    g2 = derive(typ2)

    fn ->
      let {h, t} <- {g1.(), g2.()} do
        [h | t]
      end
    end
  end

  ## maps
  def derive({:type, _line, :map, :any}), do: fn -> map(term(), term()) end

  def derive({:type, _line, :map, typs}) do
    field_gens = Enum.map(typs, &derive_map_field/1)

    fn ->
      gens = Enum.map(field_gens, fn g -> g.() end)

      let fields <- gens do
        Enum.reduce(fields, %{}, &Map.merge/2)
      end
    end
  end

  ## tuples

  def derive({:type, _line, :tuple, :any}), do: &tuple/0

  def derive({:type, _line, :tuple, typs}) do
    element_gens = Enum.map(typs, &derive/1)

    fn ->
      tuple(Enum.map(element_gens, fn g -> g.() end))
    end
  end

  def derive({:type, _line, :neg_integer, []}), do: &neg_integer/0

  def derive({:type, _line, :non_neg_integer, []}), do: &non_neg_integer/0

  def derive({:type, _line, :pos_integer, []}), do: &pos_integer/0

  def derive({:type, _line, :timeout, []}), do: &timeout/0

  def derive({:type, _line, :string, []}), do: &char_list/0

  def derive({:type, _line, :nonempty_string, []}) do
    fn ->
      non_empty(char_list())
    end
  end

  def derive({:type, _line, :number, []}), do: &number/0

  def derive({:type, _line, :module, []}), do: &atom/0

  def derive({:type, _line, :iolist, []}) do
    fn ->
      list(union([list(byte()), binary()]))
    end
  end

  def derive({:type, _line, :iodata, []}) do
    fn ->
      union([binary(), list(union([list(byte()), binary()]))])
    end
  end

  def derive({:type, _line, :byte, []}), do: &byte/0

  def derive({:type, _line, :char, []}), do: &char/0

  def derive({:type, _line, :boolean, []}), do: &boolean/0

  def derive({:type, _line, :bitstring, []}), do: &bitstring/0

  def derive({:type, _line, :arity, []}), do: fn -> integer(0, 255) end

  def derive({:type, _line, :term, []}), do: &term/0

  def derive({:type, _, :union, types}) do
    gens = Enum.map(types, &derive/1)

    fn ->
      union(Enum.map(gens, fn g -> g.() end))
    end
  end

  def derive({:type, _line, typ, _args}) do
    raise "can not derive a generator for type #{typ}"
  end

  # required field where key is a known atom
  defp derive_map_field({:type, _, :map_field_exact, [{:atom, _, field}, val_typ]}) do
    g = derive(val_typ)

    fn ->
      let val <- g.() do
        %{field => val}
      end
    end
  end

  # required field
  defp derive_map_field({:type, _, :map_field_exact, [field_typ, val_typ]}) do
    g1 = derive(field_typ)
    g2 = derive(val_typ)

    fn ->
      let {k, v} <- {g1.(), g2.()} do
        %{k => v}
      end
    end
  end

  # optional field
  defp derive_map_field({:type, _, :map_field_assoc, [field_typ, val_typ]}) do
    g1 = derive(field_typ)
    g2 = derive(val_typ)

    fn ->
      r =
        let {k, v} <- {g1.(), g2.()} do
          %{k => v}
        end

      oneof([exactly(%{}), r])
    end
  end
end
