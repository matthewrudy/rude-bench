<<-INTRO

Question:
  Is define_method slower than an eval?

    define_method :something do
    end

    class_eval do
      def something
    end

    class_eval "def something; end"

    def something
    end

Answer:
  define_method is quite a bit slower

                                  user     system      total        real
  define_method               1.230000   0.000000   1.230000 (  1.230895)
  class_eval - block          0.860000   0.000000   0.860000 (  0.858202)
  class_eval - string         0.850000   0.000000   0.850000 (  0.851699)
  real method                 0.890000   0.000000   0.890000 (  0.888830)

INTRO

require 'benchmark'

TIMES = 10_000_000

class MyClass

  define_method :defined_method do
  end

  class_eval do
    def class_eval_with_block
    end
  end

  class_eval <<-RUBY
    def class_eval_with_string
    end
  RUBY

  def real_method
  end

end

INSTANCE = MyClass.new

Benchmark.bmbm(25) do |x|
  x.report("define_method") do
    TIMES.times do
      INSTANCE.defined_method
    end
  end

  x.report("class_eval - block") do
    TIMES.times do
      INSTANCE.class_eval_with_block
    end
  end

  x.report("class_eval - string") do
    TIMES.times do
      INSTANCE.class_eval_with_string
    end
  end

  x.report("real method") do
    TIMES.times do
      INSTANCE.real_method
    end
  end
end