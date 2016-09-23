class WelcomeController < ApplicationController
	before_action :authenticated_admin!, only: [:dashboard]
  def index
  end

  def dashboard
  	#@articles = Article.ultimos.all
    @articles = Article.paginate(page: params[:page], per_page:5)
  end
end
