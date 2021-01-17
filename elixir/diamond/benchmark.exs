# Benchmarking A...
# Benchmarking Z...

# Name           ips        average  deviation         median         99th %
# A         310.09 K        3.22 μs   ±665.62%           2 μs          11 μs
# Z          21.01 K       47.61 μs    ±70.80%          37 μs         201 μs

# Comparison:
# A         310.09 K
# Z          21.01 K - 14.76x slower +44.38 μs

Benchee.run(%{
  "A" => fn -> Diamond.build_shape(?A) end,
  "Z" => fn -> Diamond.build_shape(?Z) end
})
