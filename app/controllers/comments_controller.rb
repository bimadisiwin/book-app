# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, except: :create

  # GET /reports/1/comments/1/edit
  def edit; end

  # POST /reports/1/comments
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    redirect_to @commentable, notice: t('notice.new') if @comment.save
  end

  # PATCH/PUT /reports/1/comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t('notice.edit')
    else
      render :edit
    end
  end

  # DELETE /reports/1/comments/1
  def destroy
    redirect_to @commentable, notice: t('notice.destroy') if @comment.destroy
  end

  private

  def set_commentable
    @commentable = Report.find(params[:report_id]) if params[:report_id]
    @commentable = Book.find(params[:book_id]) if params[:book_id]
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
