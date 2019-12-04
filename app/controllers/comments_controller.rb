class CommentsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @comment = Comment.new(comment_params)
    @comment.group = @group
    @comment.user = current_user

    if @comment.save!
      respond_to do |format|
        format.html { redirect_to group_path(@group) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'groups/show' }
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @group = @comment.group
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to group_path(@group) }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
