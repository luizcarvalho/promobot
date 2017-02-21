require 'rails/application_controller'
class AdminController < Rails::ApplicationController
  include AdminHelper
  def index
    @q = Promotion.search(params[:q])
    @promotions = @q.result(distinct: true).page(params[:page]).per(30)
    render file: Rails.root.join('app', 'views', 'admin', 'index.html')
  end
end
