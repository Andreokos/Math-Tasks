class TasksController < ApplicationController

  def index
    @tasks = Task.all
    @tasks_sub = []
    @task_tags = []
    @tasks.each do |task|
      if task[:subject_id].to_s == params[:subject_id]
        @tasks_sub << task
        task.tags.each do |tag|
          @task_tags << tag
        end
      end
    end
  end

  def show
    @task = Task.find params[:id]
    @tags = @task.tags
    @comments = []
    Comment.all.each do |comment|
      if comment[:task_id].to_s == params[:id]
        @comments << comment
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @subject = Subject.where(name: params[:task][:titl]).first

    @task = @subject.tasks.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to page_user_task_path( current_user.id, @task), notice: 'Task was succesfully create'
    else
      render :new
    end
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    if params[:task][:title] == @task[:titl]
      @task.update task_params
      redirect_to subject_task_path(params[:subject_id], @task), notice: 'Task was succesfully update'
    else
      @task.delete
      create
    end
  end

  def destroy
    @task = Task.find params[:id]
    @idd = @task.subject_id
    @task.delete
    redirect_to subject_tasks_path(@idd), notice: 'Task was succesfully delete'
  end

  private

  def task_params
    params.require(:task).permit(:name, :titl, :condition, :answer, images: [], tags_attributes: %i[id name destroy])
  end
end
