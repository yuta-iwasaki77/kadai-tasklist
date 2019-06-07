class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit,]
    before_action :require_user_logged_in
    before_action :correct_user, only: [:edit, :update, :destroy]
 
  def index
      @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task=Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Taskを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Taskの投稿に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
  @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end
  
 
   private

  # Strong Parameter
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end