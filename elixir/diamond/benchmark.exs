# Benchmarking A...
# Benchmarking Z...

# Name           ips        average  deviation         median         99th %
# A         571.42 K        1.75 μs  ±1586.51%        0.90 μs        4.90 μs
# Z          24.04 K       41.60 μs   ±134.03%       28.90 μs      331.90 μs

# Comparison:
# A         571.42 K
# Z          24.04 K - 23.77x slower +39.85 μs

Benchee.run(%{
  "A" => fn -> Diamond.build_shape(?A) end,
  "Z" => fn -> Diamond.build_shape(?Z) end
})
