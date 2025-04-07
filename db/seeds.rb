require 'openai'

def openai_client
  @openai_client ||= OpenAI::Client.new(
    uri_base: "http://ollama_local_ip_or_open_ai_ip:port"
  )
end

def generate_content(prompt, max_tokens: 4096, temperature: 0.7)
  response = openai_client.chat(
    parameters: {
      model: "llama3.2:3b-instruct-q8_0",
      messages: [ { role: "user", content: prompt } ],
      temperature: temperature,
      max_tokens: max_tokens
    }
  )
  response.dig("choices", 0, "message", "content")
end

(1..100).each do |i|
  header_prompt = <<~PROMPT
    Write a header for a knowledge post.
  PROMPT

  header = generate_content(header_prompt, max_tokens: 64).strip.delete('"')

  content_prompt = <<~PROMPT
    Write a detailed, helpful, and informative knowledge post content that matches this header "#{header}".
    Do not use markdown, but new lines can be added.
  PROMPT

  content = generate_content(content_prompt).strip

  knowledge = KnowledgeBasis.create!(header: header, content: content)

  puts "added some new knowledge! '#{header}'."
  GenerateEmbeddingsDataJob.perform_later(knowledge)
end
