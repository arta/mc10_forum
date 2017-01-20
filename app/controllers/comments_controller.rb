class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, except: :create

  # POST /posts/:post_id/comments
  #   html:   <form action='/posts/1/comments', method='post' ..>
  #   rails:  =form_for [@post, @comment] .. <- @comment.new_record? == true
  #                                             from PostsController::show
  #   router: post '/posts/:post_id/comments', to: 'comments#create'
  #   Router reads :post_id value from the request and assigns it
  #   to :post_id key in params hash ( params[:post_id] )
  def create
    post = Post.find params[:post_id]
    comment = post.comments.new( comment_params.merge( user: current_user ) )
    flash[:notice] = 'Comment posted.' if comment.save
    redirect_to post
  end
  # No view. Excplicitly redirect_to|render action|view

  # GET /posts/:post_id/:comments/:id/edit
  #   html:   <a href='/posts/1/comments/1/edit'>..</a>
  #   rails:  =link_to .. [:edit, @post, comment] | edit_post_comment_path( @post, comment )
  #   router: get 'posts/:post_id/comments/:id/edit', to: 'comments#edit', as: edit_post_comment
  #   Router reads :post_id, :id values from the request and assigns them
  #   to namesake keys of params hash ( params[:post_id], params[:id] )
  def edit
    @post = @comment.post
  end
  # Implicitly renders /posts/:post_id/comments/:id/edit haml view which
  #   renders /comments/_form haml partial which contains
  #   rails:  =form_for [@post, @comment] .. which writes
  #   html:   <form action='/posts/1/comments/1', method='patch' ..>
  #             <input name='comment[comment]' ..

  # PATCH|PUT /posts/:post_id/:comments/:id
  #   html:   <form action='/posts/1/comments/1', method='patch' ..>
  #   rails:  =form_for [@post, @comment] .. <- @comment.persisted? == true
  #                                             from CommentsController::edit
  #   router: match '/posts/:post_id/comments/:id', to: 'comments#update', via:[:patch, :put]
  #   Router reads :post_id, :id values from the request and assigns them
  #   to namesake keys of params hash ( params[:post_id], params[:id] )
  def update
    @comment.update( comment_params )
    redirect_to @comment.post, notice: 'Comment updated.'
  end
  # No view. Explicitly redirect_to|render action|view

  # DELETE /posts/:post_id/:comments/:id
  #   html:   <a href='/posts/1/comments/1', rel='nofollow', data-method='delete'>..</a>
  #   rails:  =link_to .. [@post, @comment], method: :delete
  #   router: delete '/posts/:post_id/comments/:id', to: 'comments#destroy'
  #   Router reads :post_id, :id values from the request and assignes them
  #   to the params namesake keys: params[:post_id], params[:id]
  def destroy
    post = @comment.post
    @comment.destroy
    redirect_to post, notice:'Comment deleted.'
  end
  # No View. Explicitly redirect_to action

  private
    def comment_params
      params.require( :comment ).permit( :comment )
    end

    def set_comment
      @comment = Comment.find params[:id]
    end
end
