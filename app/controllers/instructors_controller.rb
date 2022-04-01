class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

    def index
        instructors = Instructor.all
        render json: instructors
    end

    def show
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            render json: instructor
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end

    def create
        new_instructor = Instructor.create!(instructor_params)
        render json: new_instructor, status: :created
    end

    def update
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.update(instructor_params)
            render json: instructor
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end

    def destroy
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.destroy
            head :no_content
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end
    
    private

    def instructor_params
        params.permit(:name)
    end

    def invalid_record(invalid)
        render json: {errors: invalid.record.full_messages}, status: :unprocessable_entity
    end
end
