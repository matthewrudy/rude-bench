<<-INTRO

Question:
  Are aliased methods any slower than regular methods?

    def original
    end

    alias :aliased :original

Answer:
  No

                  user     system      total        real
  original    8.180000   0.010000   8.190000 (  8.182336)
  aliased     8.230000   0.000000   8.230000 (  8.230926)
  aliased2    8.080000   0.010000   8.090000 (  8.085406)
  original2   8.120000   0.000000   8.120000 (  8.116027)

INTRO

require 'benchmark'

TIMES = 100_000_000

def original
end

alias :aliased :original

Benchmark.bmbm do |x|
  x.report "original" do
    TIMES.times do
      original
    end
  end
  x.report "aliased" do
    TIMES.times do
      aliased
    end
  end
  x.report "aliased2" do
    TIMES.times do
      aliased
    end
  end
  x.report "original2" do
    TIMES.times do
      original
    end
  end
end
