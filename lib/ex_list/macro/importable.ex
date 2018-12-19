defmodule ExList.Macro.Importable do
  defmacro __using__(opts) do
    extra_code =
      case opts do
        [] ->
          quote do
          end

        [do: code] ->
          code
      end

    quote do
      unquote(extra_code)

      defmacro __using__(opts) do
        extra_code_ast = unquote(extra_code |> Macro.escape())

        extra_alias_ast =
          case opts do
            [as: quoted_module_alias] ->
              {module_alias, []} =
                quoted_module_alias
                |> Code.eval_quoted([], __CALLER__)

              quote do
                alias unquote(__MODULE__), as: unquote(module_alias)
              end

            [] ->
              quote do
              end
          end

        quote do
          unquote(extra_code_ast)
          unquote(extra_alias_ast)
          import unquote(__MODULE__)
        end
      end
    end
  end
end
