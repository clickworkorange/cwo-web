class Helm::PagesController < Helm::ApplicationController
  before_action :set_page, only: %i[ show edit update destroy ]

  # TODO: create a separate Image model for images, which automagically handles file deletion 
  # This model would allow things like alt text, caption and sort order.

  # GET /helm/pages
  def index
    @pages = Page.all
  end

  # GET /helm/pages/1
  def show
  end

  # GET /helm/pages/new
  def new
    @page = Page.new
  end

  # GET /helm/pages/1/edit
  def edit
  end

  # POST /helm/pages
  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to [:helm, @page], notice: "Page was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /helm/pages/1
  def update
    # if params[:banner_delete] & @page.banner.attached?
    #   @page.banner.purge
    # end
    if @page.update(page_params)
      redirect_to [:helm, @page], notice: "Page was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /helm/pages/1
  def destroy
    @page.destroy!
    redirect_to helm_pages_url, notice: "Page was successfully deleted.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:live, :title, :abstract, :body, :parent_id, :banner, :banner_delete)
    end
end
