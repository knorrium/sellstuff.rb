Sellstuff.controllers :page do

  get :about, :map => '/about' do
    render 'page/about'
  end

  get :contact , :map => "/contact" do
    render 'page/contact'
  end

  get :home, :map => "/" do
    redirect to('/items')
  end

end
