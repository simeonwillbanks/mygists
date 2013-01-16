namespace :cache do

  desc "Write caches"
  task write: :environment do

    [:profiles, :tags].each { |key| MyGists::Cache.write(key) }
  end
end
