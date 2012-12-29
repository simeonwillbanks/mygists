namespace :tags do
  desc "Rename default tag from 'Uncategorized' to 'Without Tags'"
  task rename_default_tag: :environment do
    ActsAsTaggableOn::Tag.find_by_name('Uncategorized').update_attribute(:name, 'Without Tags')
  end
end
