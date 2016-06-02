module ArticlesHelper

  def article_params
    params.require(:article).permit(:title, :body)
  end# this method was written so that app/controllers/articles_controller's #create method could use params[:article] as an argument for Article.new but that wasnt allowed

end
