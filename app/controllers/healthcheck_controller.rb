class HealthcheckController < ApplicationController

  def index
    @item = Item.limit(1)

    if @items
      head :ok
    else
      head :not_found
    end
  end
end
