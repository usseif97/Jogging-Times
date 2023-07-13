class JogsController < ApplicationController
    before_action :unauthorized
    before_action :set_jog, only: [:show, :update, :destroy]

    # GET /jogs
    def index
        @jogs = current_user.jogs
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
        @group_by_week = current_user.jogs.group_by_week(:created_at)
        @distances_sum = @group_by_week.sum(:distance).values[0]
        @time_sum = @group_by_week.sum(:time).values[0]
        @speed = @distances_sum / @time_sum
        if @speed
            render json: @speed
        else
            render json: @speed.errors, status: :unprocessable_entity
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_jog
        @jog = current_user.jogs.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def jog_params
        params.require(:jog).permit(:date, :distance, :time, :user)
    end

    def unauthorized
        if current_user == nil
            render json: { error: 'Not authorized' }, status: :unauthorized
        end
    end
end
