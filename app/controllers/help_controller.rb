class HelpController < ApplicationController
  before_filter :authenticate_user!

  def index
    respond_to { |format| format.html }
  end
end
