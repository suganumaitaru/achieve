class CommentsController < ApplicationController
        # コメントを保存、投稿するためのアクションです。
    def create
        # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
        @comment = current_user.comments.build(comment_params)
        @blog = @comment.blog
        # クライアント要求に応じてフォーマットを変更
        respond_to do |format|
            if @comment.save
                format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました' }
                format.js{render :index}
            else
                format.html { render :new }
            end
        end
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            redirect_to blog_path(@comment.blog.id), notice: "コメントを更新しました！"
        else
            render 'edit'
        end
    end

    def destroy
        # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
        @comment = Comment.find(params[:id])
        @comment.destroy
        respond_to do |format|
                format.html { redirect_to blog_path(@blog), notice: 'コメントを削除しました' }
                format.js{render :index}

        end
    end




    private
        # ストロングパラメーター
        def comment_params
            params.require(:comment).permit(:blog_id, :content)
        end


end
