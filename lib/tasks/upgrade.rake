namespace :upgrade do

  desc "Upgrade gists by adding titles"
  task gists_by_setting_titles: :environment do

    default_title = "gistfile1.txt"

    Gist.where(title: nil).each do |gist|

      begin
        fetched = Octokit.gist(gist.gid)

        gist.title = fetched['files'].try(:first).try(:first) || default_title
      rescue Octokit::NotFound => e

        # Gist has probably been deleted, so lets give it a default title
        gist.title = default_title
      ensure
        gist.save!
      end
    end
  end


  desc "Upgrade profiles by setting gravatar id"
  task profiles_by_setting_gravatar_id: :environment do

    Profile.all.each do |profile|

      profile.gravatar_id = Octokit.user(profile.username).gravatar_id

      profile.save!
    end
  end

  desc "Upgrade gists and tags to use public and private statuses"
  task gists_tags_public_private_status: :environment do

    Gist.all.each do |gist|

      # Gist ID does not have a letter, so its a public gist
      if (gist.gid =~ /[a-z]/).nil?
        gist.public = true
        context = "public"
      else # Secret or private gist
        gist.public = false
        context = "private"
      end

      ActsAsTaggableOn::Tagging.where(taggable_id: gist.id, taggable_type: "Gist", tagger_id: gist.profile_id, tagger_type: "Profile").update_all(context: context)
      gist.save!
    end
  end
end
