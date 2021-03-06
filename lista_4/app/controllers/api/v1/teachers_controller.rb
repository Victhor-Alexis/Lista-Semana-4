class Api::V1::TeachersController < ApplicationController

    acts_as_token_authentication_handler_for Admin

    def index
        profs = Teacher.all
        render json: profs, status: 200
    end

    def show
        prof = Teacher.find(params[:id])
        render json: prof, status: 200
    rescue StandardError
        head(:not_found)    
    end

    def create
        prof = Teacher.new(prof_params)
        prof.save!
        render json: prof, status: 201
    rescue StandardError => e
        render json: {message: e.message}, status: :unprocessable_entity
       # head(:unprocessable_entity)    
    end

    def update
        prof = Teacher.find(params[:id])
        prof.update!(prof_params)
        render json: prof, status: 200
    rescue StandardError
        head(:unprocessable_entity)
    end

    def delete
        prof = Teacher.find(params[:id])
        prof.destroy
        render json: prof, status: 200
    rescue StandardError
        head(:bad_request)
    end

    ######################## Questão extra ##########################
    def my_students
        alunos = Student.where(teacher_id: params[:id])
        render json: alunos, status: 200
    rescue StandardError
        head(:not_found)
    end

    private

    def prof_params
        params.require(:teacher).permit(
            :name,
            :email,
            :birthdate,
            :photo
        )    
    end
end
