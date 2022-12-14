class ScientistsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        scientists = Scientist.all
        render json: scientists, status: :ok
    end

    def show
        scientist = Scientist.find_by(id: params[:id])
        if scientist
            render json: scientist, serializer: ScientistPlanetsSerializer
        else
            render json: { error: "Scientist not found" }, status: :not_found
        end
    end

    def create
        scientist = Scientist.create(scientist_params)
        if scientist.valid?
            render json: scientist, status: :created
        else
            render json: {errors: ["validations errors"] }, status: :unprocessable_entity
        end
    end

    def destroy 
        scientist = Scientist.find_by(id: params[:id])
        if scientist
            scientist.destroy
            head :no_content
        else
            render json: { error: "Scientist not found" }, status: :not_found
        end
    end

    def update
        scientist = Scientist.find_by(id: params[:id])
        if scientist
            scientist.update(scientist_params)
            if scientist.valid?
                render json: scientist, status: :accepted
            else
                render json: {errors: ["validations errors"] }, status: :unprocessable_entity
            end
        else
            render json: { error: "Scientist not found" }, status: :not_found
        end
    end

    private 

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def render_not_found_response
        render json: { error: "Scientist not found" }, status: :not_found
      end
end
