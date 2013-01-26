namespace :tags do
  desc "Rename default tag from 'Uncategorized' to 'Without Tags'"
  task rename_default_tag: :environment do
    ActsAsTaggableOn::Tag.find_by_name("Uncategorized").update_attribute(:name, "Without Tags")
  end

  desc "Generate slugs for existing tags"
  task generate_slugs: :environment do
    ActsAsTaggableOn::Tag.find_each(&:save)
  end
end
