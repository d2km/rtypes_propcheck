defmodule RTypesPropCheckTest do
  use ExUnit.Case
  use PropCheck

  require RTypes
  require RTypes.Generator, as: Generator
  alias RTypes.Generator.PropCheck, as: PC
  alias RTypesPropCheck.Types, as: T

  property "atom" do
    p? = RTypes.make_predicate(atom())
    gen = Generator.make(atom(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "map" do
    p? = RTypes.make_predicate(map())
    gen = Generator.make(map(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "tuple" do
    p? = RTypes.make_predicate(tuple())
    gen = Generator.make(tuple(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "float" do
    p? = RTypes.make_predicate(float())
    gen = Generator.make(float(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "integer" do
    p? = RTypes.make_predicate(integer())
    gen = Generator.make(integer(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "neg_integer" do
    p? = RTypes.make_predicate(neg_integer())
    gen = Generator.make(neg_integer(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "non_neg_integer" do
    p? = RTypes.make_predicate(non_neg_integer())
    gen = Generator.make(non_neg_integer(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "pos_integer" do
    p? = RTypes.make_predicate(pos_integer())
    gen = Generator.make(pos_integer(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "list" do
    p? = RTypes.make_predicate(list())
    gen = Generator.make(list(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "nonempty_list" do
    p? = RTypes.make_predicate(nonempty_list())
    gen = Generator.make(nonempty_list(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "maybe_improper_list" do
    p? = RTypes.make_predicate(maybe_improper_list())
    gen = Generator.make(maybe_improper_list(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "nonempty_maybe_improper_list" do
    p? = RTypes.make_predicate(nonempty_maybe_improper_list())
    gen = Generator.make(nonempty_maybe_improper_list(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "union" do
    p? = RTypes.make_predicate(T.union())
    gen = Generator.make(T.union(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "range" do
    p? = RTypes.make_predicate(T.range())
    gen = Generator.make(T.range(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "literal_atom" do
    p? = RTypes.make_predicate(T.literal_atom())
    gen = Generator.make(T.literal_atom(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "literal_integer" do
    p? = RTypes.make_predicate(T.literal_integer())
    gen = Generator.make(T.literal_integer(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "concrete_tuple" do
    p? = RTypes.make_predicate(T.concrete_tuple())
    gen = Generator.make(T.concrete_tuple(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "empty_list" do
    p? = RTypes.make_predicate(T.empty_list())
    gen = Generator.make(T.empty_list(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "bitstring_empty" do
    p? = RTypes.make_predicate(T.bitstring_empty())
    gen = Generator.make(T.bitstring_empty(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "bitstring_size" do
    p? = RTypes.make_predicate(T.bitstring_size())
    gen = Generator.make(T.bitstring_size(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "bitstring_units" do
    p? = RTypes.make_predicate(T.bitstring_units())
    gen = Generator.make(T.bitstring_units(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "bitstring_size_and_units" do
    p? = RTypes.make_predicate(T.bitstring_size_and_units())
    gen = Generator.make(T.bitstring_size_and_units(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "nonempty_list_short_any" do
    p? = RTypes.make_predicate(T.nonempty_list_short_any())
    gen = Generator.make(T.nonempty_list_short_any(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "Keyword.t" do
    p? = RTypes.make_predicate(Keyword.t())
    gen = Generator.make(Keyword.t(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "empty_map" do
    p? = RTypes.make_predicate(T.empty_map())
    gen = Generator.make(T.empty_map(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "empty_tuple" do
    p? = RTypes.make_predicate(T.empty_tuple())
    gen = Generator.make(T.empty_tuple(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "term" do
    p? = RTypes.make_predicate(term())
    gen = Generator.make(term(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "arity" do
    p? = RTypes.make_predicate(arity())
    gen = Generator.make(arity(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "binary" do
    p? = RTypes.make_predicate(binary())
    gen = Generator.make(binary(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "boolean" do
    p? = RTypes.make_predicate(boolean())
    gen = Generator.make(boolean(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "byte" do
    p? = RTypes.make_predicate(byte())
    gen = Generator.make(byte(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "char" do
    p? = RTypes.make_predicate(char())
    gen = Generator.make(char(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "string" do
    p? = RTypes.make_predicate(string())
    gen = Generator.make(string(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "nonempty_string" do
    p? = RTypes.make_predicate(nonempty_string())
    gen = Generator.make(nonempty_string(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "iodata" do
    p? = RTypes.make_predicate(iodata())
    gen = Generator.make(iodata(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "iolist" do
    p? = RTypes.make_predicate(iolist())
    gen = Generator.make(iolist(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "module" do
    p? = RTypes.make_predicate(module())
    gen = Generator.make(module(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "number" do
    p? = RTypes.make_predicate(number())
    gen = Generator.make(number(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "timeout" do
    p? = RTypes.make_predicate(timeout())
    gen = Generator.make(timeout(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "fixed keys map" do
    p? = RTypes.make_predicate(T.fixed_map())
    gen = Generator.make(T.fixed_map(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "required keys map" do
    p? = RTypes.make_predicate(T.required_keys_map())
    gen = Generator.make(T.required_keys_map(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "optional keys map" do
    p? = RTypes.make_predicate(T.optional_keys_map())
    gen = Generator.make(T.optional_keys_map(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end

  property "mixed keys map" do
    p? = RTypes.make_predicate(T.mixed_keys_map())
    gen = Generator.make(T.mixed_keys_map(), PC)

    forall val <- gen.() do
      assert(p?.(val))
    end
  end
end
