Admin.controllers :item_statuses do

  get :index do
    @item_statuses = ItemStatus.all
    render 'item_statuses/index'
  end

  get :new do
    @item_status = ItemStatus.new
    render 'item_statuses/new'
  end

  post :create do
    @item_status = ItemStatus.new(params[:item_status])
    if @item_status.save
      flash[:notice] = 'ItemStatus was successfully created.'
      redirect url(:item_statuses, :edit, :id => @item_status.id)
    else
      render 'item_statuses/new'
    end
  end

  get :edit, :with => :id do
    @item_status = ItemStatus.find(params[:id])
    render 'item_statuses/edit'
  end

  put :update, :with => :id do
    @item_status = ItemStatus.find(params[:id])
    if @item_status.update_attributes(params[:item_status])
      flash[:notice] = 'ItemStatus was successfully updated.'
      redirect url(:item_statuses, :edit, :id => @item_status.id)
    else
      render 'item_statuses/edit'
    end
  end

  delete :destroy, :with => :id do
    item_status = ItemStatus.find(params[:id])
    if item_status.destroy
      flash[:notice] = 'ItemStatus was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy ItemStatus!'
    end
    redirect url(:item_statuses, :index)
  end
end
