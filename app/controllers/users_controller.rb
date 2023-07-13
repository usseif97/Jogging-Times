class UsersController < ApplicationController
    before_action :unauthorized
    before_action :check_role, only: [:index]
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    def index
        if @users 
            render json: @users, status:200
        else
            render json: @users.errors, status: :unprocessable_entity
        end
    end

    # GET /users/1
    def show
        if @user  
            render json: @user, status:200
        else
            render json: {error: "Not Found"}    
        end 
    end

    # GET /users/manager
    def create_manager
        current_user.role = "manager"
        @user = current_user
        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    # GET /users/admin
    def create_admin
        current_user.role = "admin"
        @user = current_user
        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end    
    end

    # PATCH/PUT /users/1
    def update
        if @user
            if @user.update(user_params)
                render json: @user
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        else
            render json: {error: "Not Found"}    
        end
    end

    # DELETE /users/1
    def destroy
        if @user
            if @user.destroy
                render json: @user
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        else
            render json: {error: "Not Found"}    
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user    
        if current_user.role == "user"
            render json: { error: 'Not authorized' }, status: :unauthorized    
        elsif current_user.role == "manager"
            @users = User.where(role: "user").find(params[:id])
        elsif current_user.role == "admin"
            @users = User.find(params[:id])
        end

    end

    def check_role
        if current_user.role == "user"
            render json: { error: 'Not authorized' }, status: :unauthorized
        elsif current_user.role == "manager"
            @users = User.where(role: "manager").or(User.where(role: "user"))
        elsif current_user.role == "admin"
            @users = User.all
        end
    end

    def user_params
        params.require(:user).permit(:email, :password, :name)
    end
      
    def unauthorized
        if current_user == nil
            render json: { error: 'Not authorized' }, status: :unauthorized
        end
    end

end
