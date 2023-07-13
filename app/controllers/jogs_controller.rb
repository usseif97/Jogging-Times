class JogsController < ApplicationController
    before_action :unauthorized
    before_action :check_role, only: [:index]
    before_action :set_jog, only: [:show, :update, :destroy]

    # GET /jogs
    def index
        if @jogs
            render json: @jogs, status:200
        else
            render json: @jog.errors, status: :unprocessable_entity
        end 
    end

    # GET /jogs/1
    def show
        if @jog  
            render json: @jog, status:200
        else
            render json: {error: "Not Found"}    
        end 
    end

    # POST /jogs
    def create
        @jog = current_user.jogs.build(jog_params)
        if @jog.save
            render json: @jog, status: :created, location: @jog
        else
            render json: @jog.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /jogs/1
    def update
        if @jog.update(jog_params)
            render json: @jog
          else
            render json: @jog.errors, status: :unprocessable_entity
        end
    end

    # DELETE /jogs/1
    def destroy
        if @jog.destroy
            render json: @jog
        else
            render json: @jog.errors, status: :unprocessable_entity
        end
    end

    # GET /average_distance
    def average_distance
        @group_by_week = current_user.jogs.group_by_week(:created_at)
        @distances_sum = @group_by_week.sum(:distance)
        if @distances_sum
            render json: @distances_sum
        else
            render json: @distances_sum.errors, status: :unprocessable_entity
        end
    end

    # GET /average_speed
    def average_speed
        @speed ||= []
        @group_by_week = current_user.jogs.group_by_week(:created_at)
        @distances_sum = @group_by_week.sum(:distance)
        @time_sum = @group_by_week.sum(:time)

        @distances_sum.values.zip(@time_sum.values).each do |distance, time|
            @speed.push( distance / time )
        end

        if @speed
            render json: {:distance => @distances_sum, :time => @time_sum, :speed => @speed}
        else
            render json: @speed.errors, status: :unprocessable_entity
        end
    end

    def filter
        @jogs = current_user.jogs.where(date: params.require(:from)..params.require(:to))

        if @jogs
            render json: @jogs
        else
            render json: @jogs.errors, status: :unprocessable_entity    
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_jog
        if current_user.role == "user"
            @jog = current_user.jogs.find(params[:id])
        elsif current_user.role == "admin"
            @jog = Jog.find(params[:id])
        end
    end

    def check_role
        if current_user.role == "user"
            @jogs = current_user.jogs
        elsif current_user.role == "admin"
            @jogs = Jog.all
        end
    end

    def jog_params
        params.require(:jog).permit(:date, :distance, :time, :user)
    end

    def unauthorized
        if current_user == nil
            render json: { error: 'Not authorized' }, status: :unauthorized
        end
    end
end
