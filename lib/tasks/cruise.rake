task :cruise do
  system 'sudo gemtools install'
  Rake::Task['db:migrate'].invoke
  # this makes the output more readable in the cc.rd dashboard
  system 'echo "--loadby mtime --reverse" > spec/spec.opts'
  Rake::Task['spec:rcov'].invoke
end
