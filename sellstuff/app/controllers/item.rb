Sellstuff.controllers :item do

  get :index, :map => '/items' do
    redirect to('/items/' + Category.first.permalink)
  end

  get :index_text, :map => '/items-text' do
    redirect to('/items-text/' + Category.first.permalink)
  end

  get :category_items_text, :map => '/items-text/:permalink' do
    @categories = Category.all
    @category = Category.find_by_permalink(params[:permalink])
    if @category.nil?
      redirect to('/items-text')
    else
      @items = Item.find_all_by_category_id(@category.id, :order => "status_id ASC, upper(title) ASC")
      session["items"] = Marshal::dump(@items)
      if @items.size == 0
        render 'item/empty'
      else
        render 'item/index_text'
      end
    end
  end

  get :category_items, :map => '/items/:permalink' do
    @categories = Category.all
    @category = Category.find_by_permalink(params[:permalink])
    if @category.nil?
      redirect to('/items')
    else
      @items = Item.find_all_by_category_id(@category.id, :order => "status_id ASC, upper(title) ASC")
      session["items"] = Marshal::dump(@items)
      if @items.size == 0
        render 'item/empty'
      else
        render 'item/index'
      end
    end
  end

  get :item_details, :map => '/items/show/:permalink' do
    @categories = Category.all
    @item = Item.find_by_permalink!(params[:permalink])
    @indexes = Hash.new
    @item_category = @categories.find { |category| category.id == @item.category_id }
    @items = Item.where("status_id < 3 and category_id = #{@item_category.id}", :order => "status_id ASC, upper(title) ASC")

    if @items.size == 0
      redirect to('/items')
    else
      idx = @items.find_index { |item| item.permalink == params[:permalink] }
      idx_next = idx+1
      idx_prev = idx-1
      prev_item = (@items[idx_prev].nil? or @items[idx_prev].status_id == 3) ? @items[@items.rindex { |x| x.status_id < 3 }].permalink : @items[idx_prev].permalink
      next_item  = (@items[idx_next].nil? or @items[idx_next].status_id == 3) ? @items[@items.index  { |x| x.status_id < 3 }].permalink : @items[idx_next].permalink
      @indexes['full_prev_link'] = "/items/show/#{prev_item}"
      @indexes['full_next_link'] = "/items/show/#{next_item}"
      render 'item/show'
    end
  end
end
