class CommentsController < ApplicationController

  # POST /posts/:post_id/comments
  #   html:   <form action='/posts/1/comments', method='post' ..>
  #   haml:   =form_for [@post, @post.comments.new] ..
  #   router: post '/posts/:post_id/comments', to: 'comments#create'
  def create
    
  end
  # No view. Excplicitly redirect_to|render action|view
end
