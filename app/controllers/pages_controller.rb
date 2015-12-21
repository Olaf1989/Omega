class PagesController < ApplicationController
  skip_before_action :require_login, only: [:index, :contact]

  def index
  end

  def contact
  end

end
