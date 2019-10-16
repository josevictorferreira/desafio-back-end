class StoreController < ApplicationController
  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(store_params[:id])
  end

  private

  def store_params
    params.permit(:id)
  end
end
