class PostsController < ApplicationController

  # GET /posts
  #   <a href='/posts'>..</a>
  #   =link_to .. posts_path
  #   get '/posts', to: 'posts#index'
  def  index
    @posts = Post.order created_at: :desc
  end
  # Implicitly renders /posts/index haml view

  # GET /posts/new
  #   <a href='/posts/new'>..</a>
  #   =link_to .. new_post_path
  #   get '/posts/new', to:'posts#new', as: new_post(_path is implied)
  def new
    @post = Post.new
  end
  # Implicitly renders /posts/new haml view with /posts/_form partial
  #   =form_for @post .. with a @post.new_record? = true
  #   <form action='/posts', method='post' ..>
  #     <input name='post[:title]' ..

  # POST /posts
  #   <form action='/posts', method='post' ..>
  #   =form_for @post .. when @post.new_record?
  #   post '/posts', to: 'posts#create'
  def create
    @post = Post.new post_params
    if @post.save
      redirect_to @post, notice:'Post created.'
    else
      render 'new'
    end
  end
  # No view. Explicitly redirect_to|render action|view

  # GET /posts/:id
  #   <a href='/posts/1'>..</a>
  #   =link_to .. @post | post_path( @post )
  #   get '/posts/:id', to: 'posts#show', as: post(_path is implied)
  #   router reads :id value from the request and assigns it to params[:id]
  def show
    @post = Post.find params[:id]
  end
  # Implicitly renders /posts/show haml view with @post :id available to it

  private
    def post_params
      params.require( :post ).permit( :title, :content )
    end
end
