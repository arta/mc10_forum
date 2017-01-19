class CommentsController < ApplicationController

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

  private
    def comment_params
      params.require( :comment ).permit( :comment )
    end
end
