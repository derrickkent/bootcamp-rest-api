module Api 
  class ItemsController < ApiController 
    before_action :set_todo

    def index
      respond_to do |format|
        begin
          @items = @todo.items 
          format.json { render json: @items, status: 200 }
        rescue => exception 
          format.json { render json: {error: "#{exception.message}"}, status: 500 } 
        end 
      end
    end

    def create 
      respond_to do |format|
        begin
          @item = @todo.items.new(item_params)
          
          
          if @item.save 
            format.json { render json: {id: @item.id }, status: 201 }
          else
            format.json { render json: {error: @item.errors.full_messages.to_sentence }, status: 422 }
          end
        
        rescue => exception 
          format.json { render json: {error: "#{exception.message}"}, status: 500 } 
        end 
      end
    end

    def show 
      respond_to do |format| 
        begin
        @item = Item.find_by(id: params[:id])

        if @item 
          format.json { render json: @item, status: 200 }
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
        @item = Item.find_by(id: params[:id])

        if @item 
          if @item.update_attributes(item_params)
            format.json { render json: @item, status: 200 }
          else
            format.json { render json: {error: @item.errors.full_messages.to_sentence }, status: 422 }
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
        @item = Item.find(params[:id])

        if @item 
          if @item.destroy
            format.json { render json: @item, status: 200 }
          else
            format.json { render json: {error: @item.errors.full_messages.to_sentence }, status: 422 }
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
    
    def item_params 
      params.require(:item).permit(:name, :done)
    end

    def set_todo 
      @todo = Todo.find_by(id: params[:todo_id])
    end
    
  end
end