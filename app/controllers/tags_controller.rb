# frozen_string_literal: true

class TagsController < ApplicationController
  def create
    @tag = Tag.create tag_params
    @task = Task.find(params[:task_id])
    @task.tags << @tag
    if @tag.save
      redirect_to page_user_path(id: @task.user_id), notice: 'tag was succesfully create'
    else
      redirect_to page_user_path(id: @task.user_id), alert: @tag.errors.full_messages
    end
  end


  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end