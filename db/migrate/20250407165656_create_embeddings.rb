class CreateEmbeddings < ActiveRecord::Migration[8.0]
  def change
    enable_extension 'vector' unless extension_enabled?("vector")
    create_table :embeddings do |t|
      t.references :resourceable, polymorphic: true, null: false
      t.vector :embedding, null: false, limit: 766 # pg vector has a limit on size of vector | optimal 766 for now
      t.text :content, null: false

      t.timestamps
    end
  end
end
