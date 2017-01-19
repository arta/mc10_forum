class CommentsController < ApplicationController
  before_action :authenticate_user!

  # POST /posts/:post_id/comments
  #   html:   <form action='/posts/1/comments', method='post' ..>
  #   haml:   =form_for [@post, @post.comments.new] ..
  #   router: post '/posts/:post_id/comments', to: 'comments#create'
  def create
    @post = Post.find params[:post_id]
    comment = @post.comments.create( comment_params.merge( user:current_user ) )
    flash[:notice] = 'Comment posted.' if comment
    redirect_to @post
  end
  # No view. Excplicitly redirect_to|render action|view

  # DELETE /posts/:post_id/:comments/:id
  #   <a href='/posts/1/comments/1', rel='nofollow', data-method='delete'>..</a>
  #   =link_to .. [@post, @comment], method: :delete
  #   router reads :post_id, :id values from the request and
  #   assignes them to the params namesake keys: params[:post_id], params[:id]
  def destroy
    @post = Post.find params[:post_id]
    comment = @post.comments.find( params[:id] )
    comment.destroy
    redirect_to @post, notice:'Comment deleted.'
  end
  # No View. Explicitly redirect_to action

  private
    def comment_params
      params.require( :comment ).permit( :comment )
    end
end
