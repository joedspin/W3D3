class AddNotNullToVisits < ActiveRecord::Migration[5.2]
  def change
    change_column_null :visits, :user_id, true 
    change_column_null :visits, :shortened_url_id, true
  end
end
