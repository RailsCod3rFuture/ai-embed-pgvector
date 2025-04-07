class GenerateEmbeddingsDataJob < ApplicationJob
  queue_as :default

  def perform(record)
    text_content = record.content.to_plain_text
    return if content.blank?

    spliced_sentences = splice_sentences(text_content)
    sentence_chunks = group_sentences_by_word_count(spliced_sentences, 130) # 130 words per chunk
    sentence_chunks.each do |c|
      init_embedding = Embedding.get_embedding_text(c)
      next if init_embedding.blank?
      Embedding.create_or_find_by!(resourceable: record, embedding: init_embedding, content: c)
    end
  end

  def splice_sentences(text_content)
    text_content.gsub("\n", " ") # remove new line characters and add space
                .scan(/(?:[^.!?]+(?:\s(?:Dr|Mr|Ms|Mrs|Jr|Sr|St|etc)\.)?)+[.!?]/) # avoid removing prefixed/post fixed values
                .map(&:strip) # remove trailing whitespace
  end


  def group_sentences_by_word_count(all_sentences, target_word_count = 200)
    chunks = []
    current_chunk = []
    current_word_count = 0

    all_sentences.each do |sentence|
      sentence_word_count = sentence.split.size

      if current_word_count + sentence_word_count > target_word_count
        chunks << current_chunk.join(" ")
        current_chunk = []
        current_word_count = 0
      end

      current_chunk << sentence
      current_word_count += sentence_word_count
    end

    chunks << current_chunk.join(" ") unless current_chunk.empty?
    chunks # group by target_word_count -> 130
  end
end
