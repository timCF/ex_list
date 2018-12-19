# defimpl Inspect, for: ExList.Backends.Struct do
#   use ExList, backend: :struct
#
#   def inspect(ex_list, opts) do
#     payload =
#       ex_list
#       |> ExList.reduce("", fn
#         x, "" -> Kernel.inspect(x, opts)
#         x, acc -> "#{acc}, #{Kernel.inspect(x, opts)}"
#       end)
#
#     "#ExList<#{payload}>"
#   end
# end
