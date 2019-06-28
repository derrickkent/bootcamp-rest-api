module Api 
  class TodosController < ApiController 
    def index 
      respond_to do |format| 
        begin
          @todos = Todo.all
          format.json { render json: @todos, status: 200 }
        rescue => exception
          format.json { render json: {error: "#{exception.message}"}, status: 500 } 
        end
      end
    end

    def create 
      respond_to do |format| 
        begin
        @todo = Todo.new(todo_params)

        if @todo.save 
          format.json { render json: {id: @todo.id }, status: 201 }
        else
          format.json { render json: {error: @todo.errors.full_messages.to_sentence }, status: 422 }
        end
          
        rescue => exception
          format.json { render json: {error: "#{exception.message}"}, status: 500 } 
        end
      end
    end

    def show 
      respond_to do |format| 
        begin
        @todo = Todo.find_by(id: params[:id])

        if @todo 
          format.json { render json: @todo, status: 200 }
        else
         format.json { render json: {error: "Record not found." }, status: 404 }
        end
          
        rescue => exception
          format.json { render json: {error: "#{exception.message}"}, status: 500 } 
        end
      end
    end

    def update 
      respond_to do |format| 
        begin
        @todo = Todo.find_by(id: params[:id])

        if @todo 
          if @todo.update_attributes(todo_params)
            format.json { render json: @todo, status: 200 }
          else
            format.json { render json: {error: @todo.errors.full_messages.to_sentence }, status: 422 }
          end
        else 
          format.json { render json: {error: "Record not found." }, status: 404 }
        end
          
        rescue => exception
          format.json { render json: {error: "#{exception.message}"}, status: 500 } 
        end
      end
    end

    def destroy 
      respond_to do |format| 
        begin
        @todo = Todo.find(params[:id])

        if @todo 
          if @todo.destroy
            format.json { render json: @todo, status: 200 }
          else
            format.json { render json: {error: @todo.errors.full_messages.to_sentence }, status: 422 }
          end
        else 
          format.json { render json: {error: "Record not found." }, status: 404 }
        end
          
        rescue => exception
          format.json { render json: {error: "#{exception.message}"}, status: 500 } 
        end
      end
    end

    

  private 

   def todo_params 
    params.require(:todo).permit(:title, :created_by)
   end
    
  end
end