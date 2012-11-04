<<-INTRO

Question:
  Using .tap to avoid assigning a variable, mutating it, then returning it

    hash = {}
    hash[:name] = "Peter"
    hash[:age]  = 23
    hash[:hair_colour] = "black"
    hash

    {}.tap do |hash|
      hash[:name] = "Peter"
      hash[:age]  = 23
      hash[:hair_colour] = "black"
    end

Answer:
  Not really

                       user     system      total        real
  local variable  14.170000   0.060000  14.230000 ( 14.223995)
  tap             15.440000   0.040000  15.480000 ( 15.492474)

INTRO

require 'benchmark'

TIMES = 10_000_000

Benchmark.bmbm do |x|
  x.report "local variable" do
    TIMES.times do
      hash = {}

      hash[:name] = "Peter"
      hash[:age]  = 23
      hash[:hair_colour] = "black"

      hash
    end
  end

  x.report "tap" do
    TIMES.times do
      {}.tap do |hash|
        hash[:name] = "Peter"
        hash[:age]  = 23
        hash[:hair_colour] = "black"
      end
    end
  end
end
