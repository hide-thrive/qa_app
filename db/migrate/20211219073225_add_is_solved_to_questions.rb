class AddIsSolvedToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :is_solved, :boolean, default: false, null: false
  end
end
