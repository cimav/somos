class HomeController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json

  def index
  end
end
