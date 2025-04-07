require "application_system_test_case"

class KnowledgeBasesTest < ApplicationSystemTestCase
  setup do
    @knowledge_basis = knowledge_bases(:one)
  end

  test "visiting the index" do
    visit knowledge_bases_url
    assert_selector "h1", text: "Knowledge bases"
  end

  test "should create knowledge basis" do
    visit knowledge_bases_url
    click_on "New knowledge basis"

    fill_in "Header", with: @knowledge_basis.header
    click_on "Create Knowledge basis"

    assert_text "Knowledge basis was successfully created"
    click_on "Back"
  end

  test "should update Knowledge basis" do
    visit knowledge_basis_url(@knowledge_basis)
    click_on "Edit this knowledge basis", match: :first

    fill_in "Header", with: @knowledge_basis.header
    click_on "Update Knowledge basis"

    assert_text "Knowledge basis was successfully updated"
    click_on "Back"
  end

  test "should destroy Knowledge basis" do
    visit knowledge_basis_url(@knowledge_basis)
    click_on "Destroy this knowledge basis", match: :first

    assert_text "Knowledge basis was successfully destroyed"
  end
end
