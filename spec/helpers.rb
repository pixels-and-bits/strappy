
def silence_stderr(&block)
  stderr = $stderr
  $stderr = StringIO.new
  yield
  $stderr = stderr
end

def silence_stdout(&block)
  stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout = stdout
end

def paginated(ary)
  WillPaginate::Collection.create(1, 10) do |pager|
    pager.replace(ary)
  end
end

class UseLayout
   def initialize(expected)
     @expected = 'layouts/' + expected
   end

   def matches?(controller)
     @actual = controller.layout
     @actual == @expected
   end

   def failure_message
     return "use_layout expected #{@expected.inspect}, got #{@actual.inspect}", @expected, @actual
   end

   def negeative_failure_message
     return "use_layout expected #{@expected.inspect} not to equal #{@actual.inspect}", @expected, @actual
   end
end

def use_layout(expected)
   UseLayout.new(expected)
end
