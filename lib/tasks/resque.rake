require "resque/tasks"

task "resque:setup" => :environment do
  ENV["QUEUE"] = "gists"
  ENV["VVERBOSE"] = "1"

  # Squash 'PG::Error: ERROR: prepared statement "a1" already exists' error
  # @see http://stackoverflow.com/a/11497019/177524
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end
