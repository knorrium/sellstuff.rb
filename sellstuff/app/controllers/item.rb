Sellstuff.controllers :item do

  get :index, :map => '/items' do
    redirect to('/items/' + Category.first.permalink)
  end

  get :index_text, :map => '/items-text' do
    @categories = Category.all
    @items = Item.find(:all, :order => "status_id, upper(title) ASC")
    if @items.size == 0
      render 'item/empty'
    else
      render 'item/index_text'
    end
  end

  get :category_items_text, :map => '/items-text/:permalink' do
    @categories = Category.all
    @items = Item.find_all_by_category_id(Category.find_by_permalink!(params[:permalink]).id, :order => "upper(title) ASC")
    if @items.size == 0
      render 'item/empty'
    else
      render 'item/index_text'
    end
  end

  get :category_items, :map => '/items/:permalink' do
    @categories = Category.all
    @items = Item.find_all_by_category_id(Category.find_by_permalink!(params[:permalink]).id, :order => "status_id ASC, upper(title) ASC")
    session["items"] = Marshal::dump(@items)
    if @items.size == 0
    	render 'item/empty'
    else
    	render 'item/index'
    end
  end

  get :item_details, :map => '/items/show/:permalink' do
    @categories = Category.all
    @item = Item.find_by_permalink!(params[:permalink])
    render 'item/show'
  end

end
