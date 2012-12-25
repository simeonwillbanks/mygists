class ProfileDecorator < Draper::Base
  EMPTY_GRAVATAR = 'empty_gravatar.png'

  decorates :profile

  def gravatar
    github.fetch(:gravatar, EMPTY_GRAVATAR)
  end

  def token
    github[:token]
  end

  def latest_gist_timestamp
    unless latest_gist.blank?
      latest_gist.updated_at.in_time_zone.strftime('%Y-%m-%dT%H:%M:%SZ')
    end
  end

  def gists(tag)
    Gist.tagged_with(tag.name, on: :descriptions, owned_by: profile).page(h.params[:page]).collect! {|g| g.decorate}
  end

  private

  def github
    h.user_signed_in? ? h.session['warden.user.user.session'].fetch(:github, {}) : {}
  end

  def latest_gist
    @lastest_gist ||= Gist.unscoped do
      profile.gists.order('"gists"."updated_at" DESC').limit(1).first
    end
  end

  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #
  #   Or, optionally enable "lazy helpers" by including this module:
  #     include Draper::LazyHelpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject's methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #
  #   def created_at
  #     h.content_tag :span, attributes["created_at"].strftime("%a %m/%d/%y"),
  #                   :class => 'timestamp'
  #   end
end
