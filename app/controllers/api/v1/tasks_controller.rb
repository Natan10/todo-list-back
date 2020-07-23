class Api::V1::TasksController < Api::V1::ApiController
  before_action :set_task , only: [:update, :show, :destroy]
  #before_action :require_authorization , only: [:show,:update,:destroy]


  def index
    @tasks = current_user.tasks.order(:created_at)
    render json: @tasks.to_json(only: [:id,:name,:description,:status,:priority])
  end

  def show
    if !@task.nil?
      render json: @task.to_json(only: [:name,:description,:status,:priority])
    else
      render json: {} ,status: :not_found
    end
  end


  def create
    @task = Task.new(task_params.merge(user: current_user))

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)

      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = Task.find_by(id:params[:id])
    if !@task.nil?
      unless current_user == @task.user
        render json: {}, status: :forbidden
      end
    end
  end

  def task_params
    
    @task = params.require(:task).permit(:name,:description,:status,:priority)
  end

#  def require_authorization
#    unless current_user == @task.user
#      render json: {}, status: :forbidden
#    end
#  end

end

