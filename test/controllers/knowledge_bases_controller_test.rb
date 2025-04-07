require "test_helper"

class KnowledgeBasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @knowledge_basis = knowledge_bases(:one)
  end

  test "should get index" do
    get knowledge_bases_url
    assert_response :success
  end

  test "should get new" do
    get new_knowledge_basis_url
    assert_response :success
  end

  test "should create knowledge_basis" do
    assert_difference("KnowledgeBasis.count") do
      post knowledge_bases_url, params: { knowledge_basis: { header: @knowledge_basis.header } }
    end

    assert_redirected_to knowledge_basis_url(KnowledgeBasis.last)
  end

  test "should show knowledge_basis" do
    get knowledge_basis_url(@knowledge_basis)
    assert_response :success
  end

  test "should get edit" do
    get edit_knowledge_basis_url(@knowledge_basis)
    assert_response :success
  end

  test "should update knowledge_basis" do
    patch knowledge_basis_url(@knowledge_basis), params: { knowledge_basis: { header: @knowledge_basis.header } }
    assert_redirected_to knowledge_basis_url(@knowledge_basis)
  end

  test "should destroy knowledge_basis" do
    assert_difference("KnowledgeBasis.count", -1) do
      delete knowledge_basis_url(@knowledge_basis)
    end

    assert_redirected_to knowledge_bases_url
  end
end
