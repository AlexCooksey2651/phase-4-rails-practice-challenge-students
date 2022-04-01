class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
    
    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find_by(id: params[:id])
        if student
            render json: student
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    def create
        instructor = Instructor.find_by(id: params[:instructor_id])
        if instructor
            new_student = instructor.students.create!(student_params)
            render json: new_student, status: :created
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end

    def update
        student = Student.find_by(id: params[:id])
        if student
            student.update!(student_params)
            render json: student
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    def destroy
        student = Student.find_by(id: params[:id])
        if student
            student.destroy
            head :no_content
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end
    
    private

    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end

    def invalid_record(invalid)
        render json: {errors: invalid.record.full_messages}, status: :unprocessable_entity
    end
end
