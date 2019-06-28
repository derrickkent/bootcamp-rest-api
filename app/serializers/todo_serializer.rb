class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_by, :created_at, :updated_at, :user_id, :title_with_created_by, :items

  def title_with_created_by
    "#{ object.title } created by #{ object.created_by } "  
  end

  def items 
    object.items
  end

end
