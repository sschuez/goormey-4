module ApplicationHelper
  def query_array
    params[:query].to_s.split(' ')
  end

  def liked?(recipe)
    if current_user.nil?
      'far'
    elsif
      current_user.likes.exists?(recipe_id: recipe.id)
      'fas'
    else
      'far'
    end
  end
end
