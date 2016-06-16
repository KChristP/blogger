class ArticlesController < ApplicationController
  include ArticlesHelper#added here so that in the create function we could use the article_params function which lets us pass the :article hash directly in to Article.new
  before_filter :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_filter :require_original_author, only: [:edit, :update, :destroy]

  def require_original_author
    @article = Article.find(params[:id])
    if @article.author_id != nil
      unless current_user == Author.find(@article.author_id)
        redirect_to root_path
        return false
      end
    else
      unless current_user == Author.first
        redirect_to root_path
        return false
      end
    end
  end

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @author = current_user
    @article.author_id = @author.id#############################################################
    @article.save

    flash.notice = "Article '#{@article.title}' Created!"

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id]).destroy

    flash.notice = "Article '#{@article.title}' Deleted!"

    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end
end
