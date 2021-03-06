class CreateQuestions < ActiveRecord::Migration
  def change
      create_table :questions do |t|
        t.string :title, null: false, limit: 140
        t.text :content, null: false
        t.belongs_to :user, null: false
        t.integer :best_answer_id

        t.timestamps(null: false)
    end
  end
end
