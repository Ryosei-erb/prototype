class CardsController < ApplicationController
  protect_from_forgery expect: :pay
  require "payjp"

  def new
    card = Card.where(user_id: current_user.id).first
    redirect_to card_path(card.id) if card.present?
  end

  def pay
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(card: params['payjpToken'])
    @card = Card.new(user_id: params[:current_user_id], customer_id: customer.id, card_id: customer.default_card)
    if @card.save
      redirect_to card_path(@card.id)
    else
      redirect_to new_card_path
    end
  end

  def show
    card = current_user.cards.first # DBにあるカードのデータを取得
    if card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id) # Payjpの顧客情報を取得
      @card_info = customer.cards.retrieve(card.card_id) # Payjpのカード情報を取得
    end
  end
end
