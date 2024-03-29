class PostCommentsController < ApplicationController

	def create
		post = Post.find(params[:post_id])
		comment = current_user.post_comments.new(post_comment_params)
		comment.post_id = post.id
		comment.save
		comment.create_notification_by(current_user)
		redirect_to post_path(post)
	end

	private

	def post_comment_params
		params.require(:post_comment).permit(:user_id, :post_id, :comment)
	end

end
