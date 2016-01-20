class PagesController < ApplicationController
  # Voordat er inglogd is
  skip_before_action :require_login, only: [:index, :contact]

  def index
  end

  def contact
  end
end
