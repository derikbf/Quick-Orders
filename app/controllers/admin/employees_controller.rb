class Admin::EmployeesController < ApplicationController
  def index
    @employees = User.all
  end

  def show
    @employee = User.find(params[:id])
  end

  def create
    params.permit(employee: [:first_name, :last_name, :email, :password, :role])
    @employee = User.create(params[:employee])
  end

  def update
  end

  def edit
  end

  def new
    @employee = User.new
  end

  def destroy
  end

end
