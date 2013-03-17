Sellstuff.controllers :item do

  get :index, :map => '/items' do
    @categories = Category.all
    @items = Item.find(:all, :order => "status_id ASC")
    if @items.size == 0
    	render 'item/empty'
    else
    	render 'item/index'
    end
  end

  get :index_text, :map => '/items-text' do
    @categories = Category.all
    @items = Item.find(:all, :order => "status_id ASC")
    if @items.size == 0
      render 'item/empty'
    else
      render 'item/index_text'
    end
  end

  get :category_items_text, :map => '/items-text/:permalink' do
    @categories = Category.all
    @items = Item.find_all_by_category_id(Category.find_by_permalink(params[:permalink]).id)
    if @items.size == 0
      render 'item/empty'
    else
      render 'item/index_text'
    end
  end

  get :category_items, :map => '/items/:permalink' do
    @categories = Category.all
    @items = Item.find_all_by_category_id(Category.find_by_permalink(params[:permalink]).id)
    if @items.size == 0
    	render 'item/empty'
    else
    	render 'item/index'
    end
  end

  get :item_details, :map => '/items/show/:permalink' do
  	@categories = Category.all
    @item = Item.find_by_permalink(params[:permalink])
	render 'item/show'
  end

  get :item_new, :map => '/item/new' do
    @statuses = ItemStatus.all
    @categories = Category.all
    # @uploads = Upload.all
    render 'item/new'
  end

  post :item_upload, :map => '/item/new' do

    item = Item.create(:title => params[:title], :description => params[:description], :category_id => params[:category], :price => params[:price], :status_id => params[:status_id])

    if item.valid? then
      if params[:image] then
        upload = Upload.create(:file => params[:image], :item_id => item.id)
        if upload.valid? then
          item.picture = upload.file
          item.save
        end
      end

      redirect to('/items')
    else
      @categories = Category.all
      @errors = item.errors
      render 'item/new_error'
    end
  end

end
