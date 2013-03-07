<<-INTRO

Question:
  Is saying any? on an array slow than saying !empty?

    [].any? vs ![].empty? vs [].present?

Answer:
  any? is quite a bit slower

                      user     system      total        real
 empty.any?       2.230000   0.000000   2.230000 (  2.231780)
 full.any?        3.730000   0.000000   3.730000 (  3.738668)
!empty.empty?     0.640000   0.000000   0.640000 (  0.643684)
!full.empty?      0.640000   0.000000   0.640000 (  0.643675)
 empty.present?   1.070000   0.000000   1.070000 (  1.077638)
 full.present?    1.100000   0.000000   1.100000 (  1.107385)

INTRO

require 'benchmark'
require 'active_support/core_ext/array'

TIMES = 10_000_000

empty = []
full  = ("a".."z").to_a

Benchmark.bmbm do |x|
  x.report " empty.any?" do
    TIMES.times do
      empty.any?
    end
  end
  x.report " full.any?" do
    TIMES.times do
      full.any?
    end
  end

  x.report " empty.any?{true}" do
    TIMES.times do
      empty.any?{true}
    end
  end
  x.report " full.any?{true}" do
    TIMES.times do
      full.any?{true}
    end
  end

  x.report "!empty.empty?" do
    TIMES.times do
      !empty.empty?
    end
  end

  x.report "!full.empty?" do
    TIMES.times do
      !full.empty?
    end
  end

   x.report " empty.present?" do
    TIMES.times do
      empty.present?
    end
  end
  x.report " full.present?" do
    TIMES.times do
      full.present?
    end
  end
end
