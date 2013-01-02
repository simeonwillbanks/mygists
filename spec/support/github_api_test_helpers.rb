module GithubApiTestHelpers
  module_function

  def options
    {
      username: 'simeonwillbanks',
      token: '818a1ec03f404d5d35527cb953c99f521aee2700'
    }
  end

  def tag
    'protip'
  end

  def timestamp
    DateTime.now.in_time_zone.strftime('%Y-%m-%dT%H:%M:%SZ')
  end

  def gists
    [{
      'description' => "A gist with a ##{tag}",
      'public' => true,
      'updated_at' => timestamp,
      'created_at' => timestamp,
      'id' => rand(0..1000).to_s
    }]
  end
end
