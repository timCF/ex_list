defmodule ExList.Macro.Utils do
  defmacro __using__(_) do
    ExList.backends()
    |> Enum.reduce(
      quote do
      end,
      fn {quoted_backend_alias, quoted_backend_module}, acc ->
        {backend_alias, []} =
          quoted_backend_alias
          |> Code.eval_quoted([], __CALLER__)

        {backend_module, []} =
          quoted_backend_module
          |> Code.eval_quoted([], __CALLER__)

        quote do
          unquote(acc)
          unquote(generate(backend_alias, backend_module))
        end
      end
    )
  end

  defp generate(backend_alias, backend_module) do
    utils_module = Module.concat(backend_module, Utils)

    quote do
      defmodule unquote(utils_module) do
        import unquote(backend_module)
        import ExList.Monads.Decision

        @moduledoc """
        Runtime utils to operate with ExList implemented with #{unquote(inspect(backend_alias))} backend
        """

        @type a :: term()
        @type b :: term()

        @type t(a) :: unquote(backend_module).t(a)

        @doc """
        Function is similar to &Enum.reduce_while/3 but not generic

        ## Examples

        ```
        iex> use ExList, backend: #{unquote(backend_alias) |> inspect}
        #{unquote(utils_module)}
        iex> ex_list = list("hello", list("world", list("stop", list("please", list()))))
        iex> qty = ExList.reduce_while(ex_list, 0, &((&1 == "stop") && halt(&2) || cont(&2 + 1)))
        iex> "there are "<>to_string(qty)<>" words before stop..."
        "there are 2 words before stop..."
        ```
        """
        @spec reduce_while(t(a), b, (a, b -> ExList.Monads.Decision.t(b))) :: b
        def reduce_while(list(), acc, _), do: acc

        def reduce_while(list(head, tail), old_acc, func) do
          func.(head, old_acc)
          |> case do
            cont(new_acc) -> reduce_while(tail, new_acc, func)
            halt(final_acc) -> final_acc
          end
        end

        @doc """
        Function is similar to &Enum.reduce/3 but not generic

        ## Examples

        ```
        iex> use ExList, backend: #{unquote(backend_alias) |> inspect}
        #{unquote(utils_module)}
        iex> list(1, list(2, list(3, list()))) |> ExList.reduce(0, &(&1 + &2))
        6
        ```
        """
        @spec reduce(t(a), b, (a, b -> b)) :: b
        def reduce(list(), acc, _), do: acc
        def reduce(list(head, tail), acc, func), do: reduce(tail, func.(head, acc), func)

        @doc """
        Function is similar to &Enum.concat/2 but not generic

        ## Examples

        ```
        iex> use ExList, backend: #{unquote(backend_alias) |> inspect}
        #{unquote(utils_module)}
        iex> ex_list0 = list(1, list(2, list(3, list())))
        iex> ex_list1 = list(4, list(5, list()))
        iex> ExList.concat(ex_list0, ex_list1)
        list(1, list(2, list(3, list(4, list(5, list())))))
        ```
        """
        @spec concat(t(a), t(a)) :: t(a)
        def concat(ex_list0, ex_list1), do: concat(list(ex_list0, list(ex_list1, list())))

        @doc """
        Function is similar to &Enum.concat/1 but not generic

        ## Examples

        ```
        iex> use ExList, backend: #{unquote(backend_alias) |> inspect}
        #{unquote(utils_module)}
        iex> ex_list0 = list(1, list(2, list(3, list())))
        iex> ex_list1 = list(4, list(5, list()))
        iex> list(ex_list0, list(ex_list1, list())) |> ExList.concat
        list(1, list(2, list(3, list(4, list(5, list())))))
        ```
        """
        @spec concat(t(t(a))) :: t(a)
        def concat(ex_list) do
          ex_list
          |> reduce(list(), fn inner_ex_list, acc ->
            inner_ex_list
            |> reduce(acc, &list(&1, &2))
          end)
          |> reverse
        end

        @doc """
        Function is similar to &Enum.reverse/3 but not generic

        ## Examples

        ```
        iex> use ExList, backend: #{unquote(backend_alias) |> inspect}
        #{unquote(utils_module)}
        iex> list(1, list(2, list(3, list()))) |> ExList.reverse
        list(3, list(2, list(1, list())))
        ```
        """
        @spec reverse(t(a)) :: t(a)
        def reverse(ex_list), do: reduce(ex_list, list(), &list(&1, &2))

        #
        # TODO : obviously, with &reduce/3 and &reduce_while/3 power we can implement all other Enum.* functions ez
        #
      end
    end
  end
end
