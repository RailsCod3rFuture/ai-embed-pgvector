class Embedding < ApplicationRecord
  belongs_to :resourceable, polymorphic: true
  has_neighbors :embedding, dimensions: 769

  def self.get_embedding_text(chunk_input)
    resp = oa_client.embeddings(
      parameters: {
        model: 'nomic-embed-text:latest',
        input: chunk_input
      }
    )
    # returns array of embs using vectors [-0.000, 1.333...]
    resp.dig("data", 0, "embedding")
  end

  private
  # possible to use ollama | ollama.com/download
  def self.oa_client
    OpenAI::Client.new(
      uri_base: "http://ollama_local_ip_or_open_ai_ip:port"
    )
  end
end
