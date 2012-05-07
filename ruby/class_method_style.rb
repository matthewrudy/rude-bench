<<-INTRO

Question:
  Is there any discernible difference?

    class << self
      def some_method

    def self.some_method

    def Klass.some_method

Answer:
  No

                        user     system      total        real
  class << self
    def method      8.520000   0.000000   8.520000 (  8.521993)
  def self.method   8.700000   0.000000   8.700000 (  8.701712)
  def Klass.method  8.530000   0.000000   8.530000 (  8.532483)

INTRO

require 'benchmark'

class Klass
  class << self
    def with_here_self
    end
  end

  def self.self_dot
  end

  def Klass.class_dot
  end
end

TIMES = 100_000_000

Benchmark.bm(15) do |x|
  x.report "class << self\n  def method    " do
    TIMES.times do
      Klass.with_here_self
    end
  end

  x.report "def self.method" do
    TIMES.times do
      Klass.self_dot
    end
  end

  x.report "def Klass.method" do
    TIMES.times do
      Klass.class_dot
    end
  end
end