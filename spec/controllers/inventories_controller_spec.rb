require 'rails_helper'

RSpec.describe InventoriesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) }

  describe 'GET #index' do
    it 'assigns all inventories to @inventories' do
      user = create(:user)
      inventory = create(:inventory, user:)
      sign_in(user)

      get :index
      expect(assigns(:inventories)).to eq([inventory])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested inventory to @inventory' do
      user = create(:user)
      inventory = create(:inventory, user:)
      sign_in(user)

      get :show, params: { id: inventory.id }
      expect(assigns(:inventory)).to eq(inventory)
    end

    it 'renders the :show template' do
      user = create(:user)
      inventory = create(:inventory, user:)
      sign_in(user)

      get :show, params: { id: inventory.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new inventory to @inventory' do
      user = create(:user)
      sign_in(user)

      get :new
      expect(assigns(:inventory)).to be_a_new(Inventory)
    end

    it 'renders the :new template' do
      user = create(:user)
      sign_in(user)

      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new inventory' do
        inventory_attributes = attributes_for(:inventory)
        user = create(:user)
        sign_in(user)
        expect do
          post :create, params: { inventory: inventory_attributes }
        end.to change(Inventory, :count).by(1)
      end

      it 'redirects to the inventories index' do
        inventory_attributes = attributes_for(:inventory)
        user = create(:user)
        sign_in(user)
        post :create, params: { inventory: inventory_attributes }
        expect(response).to redirect_to(inventories_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new inventory' do
        user = create(:user)
        sign_in(user)
        expect do
          post :create, params: { inventory: { name: nil } }
        end.not_to change(Inventory, :count)
      end

      it 're-renders the :new template' do
        user = create(:user)
        sign_in(user)
        post :create, params: { inventory: { name: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    it 'deletes the inventory' do
      inventory = create(:inventory, user:)
      sign_in(user)
      expect do
        delete :destroy, params: { id: inventory.id }
      end.to change(Inventory, :count).by(-1)
    end

    it 'redirects to the inventories index' do
      inventory = create(:inventory, user:)
      sign_in(user)
      delete :destroy, params: { id: inventory.id }
      expect(response).to redirect_to(inventories_path)
    end

    # it "doesn't delete an inventory if the user doesn't have permission" do
    #   other_user = create(:user)
    #   inventory = create(:inventory, user: other_user)
    #   sign_in(user)
    #   expect {
    #     delete :destroy, params: { id: inventory.id }
    #   }.not_to change(Inventory, :count)
    # end

    # it 'redirects to the inventories index with an alert if the user lacks permission' do
    #   other_user = create(:user)
    #   inventory = create(:inventory, user: other_user)
    #   sign_in(user)
    #   delete :destroy, params: { id: inventory.id }
    #   expect(response).to redirect_to(inventories_path)
    #   expect(flash[:alert]).to be_present
    # end
  end
end
