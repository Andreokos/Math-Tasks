class CommentsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.username = current_user.email
    if @task.save
      redirect_to subject_task_path(id: @task), notice: 'Task was succesfully create'
    else
      render :new
    end
  end

  def destroy
    @task = Task.find params[:id]
    @comment = Comment.find(params[:task_id]).delete
    redirect_to subject_task_path(id: params[:id]), notice: 'Comment was succesfully delete'
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

