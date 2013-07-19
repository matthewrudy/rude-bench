<<-INTRO

Question:
  What is the best way to create a Struct type object

    a struct?
    a custom class?
    an openstruct?
    or just a hash?

Answer:
  structs are convenient, and fast
  openstructs are a bit slower

  I guess it depends what you're trying to achieve.

                                user     system      total        real
custom class                0.710000   0.000000   0.710000 (  0.715378)
struct                      0.840000   0.000000   0.840000 (  0.834624)
openstruct                  1.770000   0.000000   1.770000 (  1.772208)
hash                        1.310000   0.000000   1.310000 (  1.310117)

INTRO

require 'benchmark'
require 'ostruct'

TIMES = 10_000_000

class CustomXY
  def initialize(x, y)
    @x = x
    @y = y
  end
  attr_reader :x, :y
end

StructXY = Struct.new(:x, :y)

Benchmark.bm(25) do |x|
  x.report("custom class") do
    xy = CustomXY.new(1,2)
    TIMES.times do
      xy.x
    end
  end

  x.report("struct") do
    xy = StructXY.new(1,2)
    TIMES.times do
      xy.x
    end
  end

  x.report("openstruct") do
    xy = OpenStruct.new(x: 1, y: 2)
    TIMES.times do
      xy.x
    end
  end

  x.report("hash") do
    xy = {x: 1, y: 2}
    TIMES.times do
      xy.fetch(:x)
    end
  end
end