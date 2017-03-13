get '/' do
  # let user create new short URL, display a list of shortened URLs
  @urls = Url.last(5)
  # @test = "hi"
	@urls.reverse!
  erb :"static/index"
end

post '/urls' do
  # create a new Url
  @url = Url.new(long_url: params[:long_url])

  if @url.save
    redirect "/"
  else
    @error = "Invalid URL! Please include 'http://' OR 'https://'."
    @urls.all
    erb :"static/index"
  end
  
end

# i.e. /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  @url = Url.find_by(short_url: params[:short_url])
  redirect @url.long_url
  @url.click_count += 1
  @url.save
  erb :"static/index"
end
