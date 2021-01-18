# Benchmarking A...
# Benchmarking Z...

# Name           ips        average  deviation         median         99th %
# A         696.29 K        1.44 μs  ±1591.67%           1 μs           3 μs
# Z          30.54 K       32.75 μs   ±101.03%          26 μs         156 μs

# Comparison:
# A         696.29 K
# Z          30.54 K - 22.80x slower +31.31 μs

Benchee.run(%{
  "A" => fn -> Diamond.build_shape(?A) end,
  "Z" => fn -> Diamond.build_shape(?Z) end
})
