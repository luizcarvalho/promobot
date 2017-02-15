require 'rails/application_controller'
require_relative '../helpers/admin_helper'
class AdminController < Rails::ApplicationController
  def index
    @q = Promotion.search(params[:q])
    @promotions = @q.result(distinct: true).page(params[:page]).per(30)
    render file: Rails.root.join('app', 'views', 'admin', 'index.html')
  end
end
