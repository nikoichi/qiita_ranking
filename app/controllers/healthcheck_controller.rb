# frozen_string_literal: true

class HealthcheckController < ApplicationController
  def index
    @item = Item.limit(1)

    if @item.present?
      head :ok
    else
      head :not_found
    end
  end
end
