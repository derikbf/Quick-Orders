module Admin
  class EmployeesController < ApplicationController
    before_action :find_employee, only: [:show, :edit, :update, :destroy, :activate]

    def index
      @employees = User.all
    end

    def show;end

    def create
      @employee = User.create(params.require(:user).permit(:first_name, :last_name, :email, :password, :role))

      respond_to do |format|
        if @employee.save
          format.html { redirect_to admin_employees_path, notice: "Employee successfully created." }
          format.json { render :show, status: :created, location: @employee }
        else
          format.html do
            flash.now[:error] = @employee.errors.full_messages.join(', ')
            render :new, status: :unprocessable_entity
          end
          format.json { render json: @employee.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      @employee.attributes = params.require(:user).permit(:first_name, :last_name, :email, :password, :role)

      respond_to do |format|
        if @employee.save
          format.html { redirect_to admin_employees_path, notice: "Employee successfully created." }
          format.json { render :show, status: :created, location: @employee }
        else
          format.html do
            flash.now[:error] = @employee.errors.full_messages.join(', ')
            render :edit, status: :unprocessable_entity
          end
          format.json { render json: @employee.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit;end

    def new
      @employee = User.new
    end

    def activate
      respond_to do |format|
        if @employee.activate!
          format.html { redirect_to admin_employees_path, notice: "Employee successfully activated." }
          format.json { render :show, status: :success, location: @employee }
        else
          format.html do
            flash[:error] = "Could not activate employee: #{@employee.errors.full_messages.join(', ')}"
            redirect_to admin_employees_path
          end
          format.json { render json: @employee.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @employee.destroy
          format.html { redirect_to admin_employees_path, notice: "Employee successfully deactivated." }
          format.json { render :show, status: :success, location: @employee }
        else
          format.html do
            flash[:error] = "Could not deactivate employee: #{@employee.errors.full_messages.join(', ')}"
            redirect_to admin_employees_path
          end
          format.json { render json: @employee.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    def find_employee
      @employee = User.find(params[:id])
    end

  end
end
