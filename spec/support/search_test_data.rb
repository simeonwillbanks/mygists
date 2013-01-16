class SearchTestData

  attr_reader :user, :profile, :public_tag, :public_gist, :private_tag,
              :private_gist, :generic_tag, :generic_public_gist,
              :generic_private_gist, :generic_private_gist_decorated,
              :generic_public_gist_decorated

  def self.generate
    new.tap do |sd|
      sd.generate_public_and_private
      sd.generate_generic
    end
  end

  def generate_public_and_private
    @user = FactoryGirl.create(:user)
    @profile = @user.profile
    @public_tag = FactoryGirl.create(:tag, name: public_tag_name)
    @private_tag = FactoryGirl.create(:tag, name: private_tag_name)
    @generic_tag = FactoryGirl.create(:tag, name: generic_tag_name)
    @public_gist = FactoryGirl.create(:gist, :public, profile: profile,
                                                      tags: [public_tag])
    @private_gist = FactoryGirl.create(:gist, :private, profile: profile,
                                                        tags: [private_tag])
  end

  def generate_generic
    @generic_public_gist = FactoryGirl.create(:gist, :public, profile: profile, tags: [generic_tag]).decorate
    @generic_private_gist = FactoryGirl.create(:gist, :private, profile: profile, tags: [generic_tag]).decorate
  end

  def private_tag_name
    "private"
  end

  def public_tag_name
    "public"
  end

  def generic_tag_name
    "generic"
  end

  def public_tag_decorated
    public_tag.decorate
  end

  def private_tag_decorated
    private_tag.decorate
  end

  def generic_tag_decorated
    generic_tag.decorate
  end

  def public_gist_decorated
    public_gist.decorate
  end

  def private_gist_decorated
    private_gist.decorate
  end

  def generic_public_gist_decorated
    generic_public_gist.decorate
  end

  def generic_private_gist_decorated
    generic_private_gist.decorate
  end
end
