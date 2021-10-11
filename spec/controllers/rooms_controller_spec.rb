require "rails_helper"

RSpec.describe RoomsController, type: :controller do
  let!(:room) {FactoryBot.create :room}
  let!(:furniture) {FactoryBot.create(:furniture, room_id: room.id)}
  let!(:user) {FactoryBot.create :user}
  let!(:receipt) {FactoryBot.create :receipt, user_id: user.id}
  let!(:receipts) {user.receipts}

  describe "GET rooms#show" do
    context "success when room do exist" do
      before{get :show, params: {id: room}}

      it "assigns @room" do
        expect(assigns(:room)).to eq room
      end

      it "assigns @time_busy" do
        expect(assigns(:time_busy)).to eq room.receipts.status_approved.select(:from_time, :end_time)
      end
  
      it "assigns @furnitures for room" do
        expect(assigns(:furnitures)).to eq room.furnitures
      end
    end

    context "fail when room doesn't exist" do
      before{get :show, params: {id: -1}}

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("rooms.not_exist")
      end

      it {expect(response).to redirect_to(root_path)}
    end
  end
end
