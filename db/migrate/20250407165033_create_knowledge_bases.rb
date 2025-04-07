class CreateKnowledgeBases < ActiveRecord::Migration[8.0]
  def change
    create_table :knowledge_bases do |t|
      t.string :header

      t.timestamps
    end
  end
end
