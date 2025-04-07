class KnowledgeBasesController < ApplicationController
  before_action :set_knowledge_basis, only: %i[ show edit update destroy ]

  # GET /knowledge_bases or /knowledge_bases.json
  def index
    @knowledge_bases = if params[:q].present?
                         KnowledgeBasis.find_similar_input(params[:q])
    else
                         KnowledgeBasis.all
    end
  end

  # GET /knowledge_bases/1 or /knowledge_bases/1.json
  def show
  end

  # GET /knowledge_bases/new
  def new
    @knowledge_basis = KnowledgeBasis.new
  end

  # GET /knowledge_bases/1/edit
  def edit
  end

  # POST /knowledge_bases or /knowledge_bases.json
  def create
    @knowledge_basis = KnowledgeBasis.new(knowledge_basis_params)

    respond_to do |format|
      if @knowledge_basis.save
        format.html { redirect_to @knowledge_basis, notice: "Knowledge basis was successfully created." }
        format.json { render :show, status: :created, location: @knowledge_basis }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @knowledge_basis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /knowledge_bases/1 or /knowledge_bases/1.json
  def update
    respond_to do |format|
      if @knowledge_basis.update(knowledge_basis_params)
        format.html { redirect_to @knowledge_basis, notice: "Knowledge basis was successfully updated." }
        format.json { render :show, status: :ok, location: @knowledge_basis }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @knowledge_basis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /knowledge_bases/1 or /knowledge_bases/1.json
  def destroy
    @knowledge_basis.destroy!

    respond_to do |format|
      format.html { redirect_to knowledge_bases_path, status: :see_other, notice: "Knowledge basis was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knowledge_basis
      @knowledge_basis = KnowledgeBasis.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def knowledge_basis_params
      params.expect(knowledge_basis: [ :header, :content ])
    end
end
