class KnowledgeBasis < ApplicationRecord
  include EmbeddableService
  has_rich_text :content
  after_save do
    GenerateEmbeddingsDataJob.perform_later(self)
  end
end
