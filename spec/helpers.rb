
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
