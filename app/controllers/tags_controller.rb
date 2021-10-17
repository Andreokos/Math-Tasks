class TagsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    if tag_params[:name].include?(', ')
      tag_params[:name].split(',').each do |tag|
        create_tag(@task, tag)
        end
    else
      @tag = Tag.new(name: tag)
      create_tag(@task, tag_params[:name])
    end
    redirect_to page_user_path(id: @task.user_id), notice: 'tag was succesfully create'
  end

  def create_tag(task, tag)
    @tag = Tag.new(name: tag)
    task.tags << @tag
    @tag.save
  end

  def find_tasks
    @tasks = []
    @tags = []

    tag_params[:name].split(',').each do |tag|
      @tags << Tag.where(name: tag)[0]
    end

    Task.all.each do |task|
      binding.pry
      if task.tags.include?(@tags)
        @tasks << task
      end
    end

    @tasks_find = Task.where(tags: @tags)
    redirect_to subject_find_tasks_path(params[:subject_id]), notice: 'Tasks were succesfully find'
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end