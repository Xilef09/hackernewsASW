class AsksController < ApplicationController
    before_action :set_contribution, only: [:show, :edit, :update, :destroy]
  
  # GET /asks
  # GET /asks.json
  def index
    @contributions =  Contribution.order("created_at desc").where("url='' OR url=' '  OR url is null") 
  end
  
 # DELETE /asks/1
  # DELETE /asks/1.json
  def destroy
    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to contri_url, notice: 'Ask was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribution_params
      params.require(:contribution).permit(:titulo, :user_id, :url, :puntos, :text)
    end
end