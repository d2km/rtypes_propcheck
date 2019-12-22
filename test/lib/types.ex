defmodule RTypesPropCheck.Types do
  @type literal_atom :: :foo
  @type literal_integer :: 42
  @type concrete_tuple :: {integer(), float()}
  @type empty_list :: []
  @type bitstring_empty :: <<>>
  @type bitstring_size :: <<_::10>>
  @type bitstring_units :: <<_::_*16>>
  @type bitstring_size_and_units :: <<_::20, _::_*8>>
  @type nonempty_list_short_any :: [...]
  @type union :: atom() | integer()
  @type range :: 0..500
  @type empty_map :: %{}
  @type empty_tuple :: {}
  @type fixed_map :: %{key1: atom(), key2: integer()}
  @type required_keys_map :: %{
          required(integer) => atom(),
          required(atom) => integer()
        }
  @type optional_keys_map :: %{optional(integer) => atom()}
  @type mixed_keys_map :: %{
          required(:foo) => String.t(),
          required(integer) => atom(),
          optional(String.t()) => integer()
        }
end
