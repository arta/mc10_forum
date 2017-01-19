class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

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
    @post = current_user.posts.new
  end
  # Implicitly renders /posts/new haml view with /posts/_form partial
  #   =form_for @post .. with a @post.new_record? = true
  #   <form action='/posts', method='post' ..>
  #     <input name='post[:title]' ..

  # POST /posts
  #   <form action='/posts', method='post' ..>
  #   =form_for @post .. when @post.new_record? == true
  #   post '/posts', to: 'posts#create'
  def create
    @post = current_user.posts.new post_params
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
  end
  # Implicitly renders /posts/show haml view with @post :id available to it

  # GET /posts/:id/edit
  #   <a href='/posts/1/edit'>..</a>
  #   =link_to .. [:edit, @post] | edit_post_path( @post )
  #   get '/posts/:id/edit', to: 'posts#edit', as: edit_post(_path is implied)
  #   router reads :id value from the request and assigns it to params[:id] key
  def edit
  end
  # Implicitly renders /posts/1/edit haml view with the @post :id loaded into
  #   /posts/_form partial which contains:
  #   =form_for @post .. with a @post.persisted? == true, which renders:
  #   <form action='/posts/1', method='patch' .. >
  #     <input name='post[title]' ..>

  # PATCH|PUT /posts/:id
  #   <from action='/posts/1', method='patch' .. >
  #   =form_for @post .. when @post.persisted? == true
  #   match '/posts/:id', to: 'posts#udpate', via: [:patch, :put]
  #   router reads :id value from the request and assigns it to params[:id] key
  def update
    if @post.update post_params
      redirect_to @post, notice:'Post updated.'
    else
      render 'edit'
    end
  end
  # No view. Explicitly redirect_to|render action|view

  # DELETE /posts/:id
  #   <a href='/posts/1', rel='nofollow', data-method='delete'>..</a>
  #   =link_to .. @post | post_path( @post ), method: :delete
  #   delete '/posts/:id', to: 'posts#destroy'
  #   router reads :id value from the request and assigns it to params[:id] key
  def destroy
    @post.destroy
    redirect_to posts_path, notice:'Post deleted.'
  end
  # No view. Explicitly redirect_to ation.

  private
    def post_params
      params.require( :post ).permit( :title, :content )
    end
    def set_post
      @post = Post.find params[:id]
    end
end
