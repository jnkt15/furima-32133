require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order = FactoryBot.build(:transaction, item_id: item.id, user_id: user.id)
      sleep(1)
    end
    describe '商品購入機能' do
      context '商品の購入がうまくいくとき' do
        it 'tokenとpostal_codeとprefecture_idとmunicipalityとaddressとphone_numberが存在すれば登録できる' do
          expect(@order).to be_valid
        end

        it 'building_nameが存在しなくても登録できる' do
          @order.building_name = nil
          expect(@order).to be_valid
        end
      end

      context '商品の購入がうまくいかないとき' do
        it 'tokenが空では登録できない' do
          @order.token = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Token can't be blank")
        end

        it 'postal_codeが空では登録できない' do
          @order.postal_code = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Postal code can't be blank")
        end

        it 'postal_codeがハイフンがなければ登録できない' do
          @order.postal_code = '1234567'
          @order.valid?
          expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
        end

        it 'prefecture_idが空では登録できない' do
          @order.prefecture_id = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Prefecture can't be blank")
        end

        it 'prefecture_idが0では登録できない' do
          @order.prefecture_id = 0
          @order.valid?
          expect(@order.errors.full_messages).to include('Prefecture must be other than 0')
        end

        it 'municipalityが空では登録できない' do
          @order.municipality = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Municipality can't be blank")
        end

        it 'addressが空では登録できない' do
          @order.address = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Address can't be blank")
        end

        it 'phone_numberが空では登録できない' do
          @order.phone_number = nil
          @order.valid?
          expect(@order.errors.full_messages).to include("Phone number can't be blank")
        end

        it 'phone_numberがハイフンは不要で、11桁以内でないと登録できない' do
          @order.phone_number = '123-45678901'
          @order.valid?
          expect(@order.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
        end

        it 'phone_numberは英語を混ぜて登録できない' do
          @order.phone_number = '123-4567-aaaa'
          @order.valid?
          expect(@order.errors.full_messages).to include("Phone number is invalid. Input full-width characters")
        end
  
      end
    end
  end
end
