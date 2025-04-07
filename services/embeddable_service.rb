module EmbeddableService
  extend ActiveSupport::Concern

  included do
    has_many :embeddings, as: :resourceable, dependent: :destroy
  end

  def find_similar_input(q, k = 6) # takes a query as first param and limit of records
    q_embedding = Embedding.get_embedding_text(q)
    return [] if q_embedding.blank?
    # k-nearest neighbor | cosine | range -1 to 1 where vectors are identical and perfectly aligned
    # Cosine similarity is a val that ranges from -1 to 1, where 1 indicates the vectors are identical & perfectly aligned (w/no angle between them), 0 indicates the vectors are orthogonal (90 degrees to each other) with no match and -1 indicates completely opposite vectors (with a 180 degree angle between them).
    embeddings.nearest_neighbors(:embeddings, q_embedding, distance: "cosine").limit(k)
  end

  class_methods do
    # find closest knowledge base with similar meaning
    # KnowledgeBasis.find_similar_input(q, k = 12)
    def find_similar_input(q, k = 10)
      q_embedding = Embedding.get_embedding_text(q)
      Embedding
        .where(resourceable_type: name)
        .nearest_neighbors(:embedding, q_embedding, distance: "cosine")
        .limit(k)
        .includes(:resourceable)
        .map(&:resourceable)
        .uniq
    end
  end
end