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
        ender 'item/empty'
      else
        render 'item/index'
      end
    end
  end

  get :item_details, :map => '/items/show/:permalink' do
    @categories = Category.all
    @item = Item.find_by_permalink!(params[:permalink])
    @indexes = Hash.new
    if params['prev'] && params['next'] && session['items']
      @items = Marshal::load(session["items"])
      idx_next = @items.find_index { |item| item.permalink == params['next'] }
      idx_prev = @items.find_index { |item| item.permalink == params['prev'] }
      prev = params['prev']
      nxt = params['next']
      idx = @items.find_index { |item| item.permalink == params[:permalink] }
      prev_prev_link = @items[idx-1].permalink
      prev_next_link = @items[idx].permalink
      next_prev_link = @items[idx].permalink
      next_next_link = (@items[idx_next+1].nil? or @items[idx_next+1].status_id == 3) ? @items[@items.index  { |x| x.status_id < 3 }].permalink : @items[idx_next+1].permalink
    else
      @items = Item.where("status_id < 3")
      idx = @items.find_index { |item| item.permalink == params[:permalink] }
      idx_next = idx+1
      idx_prev = idx-1
      prev = (@items[idx_prev].nil? or @items[idx_prev].status_id == 3) ? @items[@items.rindex { |x| x.status_id < 3 }].permalink : @items[idx_prev].permalink
      nxt  = (@items[idx_next].nil? or @items[idx_next].status_id == 3) ? @items[@items.index  { |x| x.status_id < 3 }].permalink : @items[idx_next].permalink
      prev_prev_link = (@items[idx-2].nil? or @items[idx-2].status_id == 3) ? @items[@items.rindex { |x| x.status_id < 3 }].permalink : @items[idx-2].permalink
      prev_next_link = @items[idx].permalink
      next_prev_link = @items[idx].permalink
      next_next_link = (@items[idx+2].nil? or @items[idx+2].status_id == 3) ? @items[@items.rindex { |x| x.status_id < 3 }].permalink : @items[idx+2].permalink
    end
    @indexes['full_prev_link'] = "/items/show/#{prev}/?prev=#{prev_prev_link}&next=#{prev_next_link}"
    @indexes['full_next_link'] = "/items/show/#{nxt}/?prev=#{next_prev_link}&next=#{next_next_link}"
    render 'item/show'
  end

end
