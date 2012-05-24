<<-INTRO

Question:
  Is there any discernible difference?

    alias :to :from

    alias to from

    alias_method :to, :from

Answer:
  No
                               user     system      total        real
  alias :to :from          8.880000   0.000000   8.880000 (  8.879882)
  alias to from            8.700000   0.000000   8.700000 (  8.708889)
  alias_method :to, :from  8.970000   0.010000   8.980000 (  8.968266)

INTRO

require 'benchmark'

class Klass
  def from
  end

  alias :aliased_as_symbol      :from
  alias  aliased_direct          from
  alias_method :alias_methoded, :from

end

INSTANCE = Klass.new

TIMES = 100_000_000

Benchmark.bm(25) do |x|
  x.report "alias :to :from" do
    TIMES.times do
      INSTANCE.aliased_as_symbol
    end
  end

  x.report "alias to from" do
    TIMES.times do
      INSTANCE.aliased_direct
    end
  end

  x.report "alias_method :to, :from" do
    TIMES.times do
      INSTANCE.alias_methoded
    end
  end
end