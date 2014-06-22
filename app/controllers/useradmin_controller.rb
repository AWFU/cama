class UseradminController < ApplicationController
  layout "useradmin"

  before_action :authenticate_user!
end
