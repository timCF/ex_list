defimpl Inspect, for: ExList.Backends.Struct do
  use ExList, backend: :struct
  import Inspect.Algebra

  def inspect(ex_list, opts) do
    open = color("#ExList<", :list, opts)
    sep = color(",", :list, opts)
    close = color(">", :list, opts)
    container_doc(open, Enum.to_list(ex_list), close, opts, &to_doc/2, separator: sep)
  end
end
