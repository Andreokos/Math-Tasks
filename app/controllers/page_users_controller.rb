class PageUsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @tasks = Task.all
    @user = User.find(params[:id])
    @tasks_user = []
    @tasks.each do |task|
      if task.user_id.to_s == params[:id]
        @tasks_user << task
      end
    end
  end
end
