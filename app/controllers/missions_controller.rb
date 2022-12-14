class MissionsController < ApplicationController
    wrap_parameters format: []

    def create
        mission = Mission.create(mission_params)
        planet = Planet.find_by(id: params[:planet_id])
        if mission.valid?
            render json: planet, status: :created
        else
            render json: { errors: ["validation errors"] }, status: :unprocessable_entity
        end
    end

    private

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end
end
