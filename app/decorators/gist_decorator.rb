class GistDecorator < Draper::Base
  decorates :gist

  PROTOCOL_AND_DOMAIN = 'https://gist.github.com'
  DEFAULT_DESCRIPTION = 'Gist without a description'

  def icons
    icons = []
    if gist.starred?
      icons << h.content_tag(:i, nil, class: 'icon-star')
    end
    if gist.public?
      icons << h.content_tag(:i, nil, class: 'icon-ok-sign')
    else
      icons << h.content_tag(:i, nil, class: 'icon-lock')
    end
    icons.join('').html_safe
  end

  def url
    "#{PROTOCOL_AND_DOMAIN}/#{model.gid}"
  end

  def description
    model.description? ? model.description : DEFAULT_DESCRIPTION
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
