json.extract! knowledge_basis, :id, :header, :content, :created_at, :updated_at
json.url knowledge_basis_url(knowledge_basis, format: :json)
json.content knowledge_basis.content.to_s
