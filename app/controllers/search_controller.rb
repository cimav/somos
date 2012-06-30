class SearchController < ApplicationController
  def search
    if params[:q].length > 2 

      @users = User.order('first_name, last_name')
      @users = @users.where("(CONCAT(first_name,' ',last_name) LIKE :q OR display_name LIKE :q)", {:q => "%#{params[:q]}%"})

      @groups = Group.order('name')
      @groups = @groups.where("(name LIKE :q OR short_name LIKE :q OR description LIKE :q)", {:q => "%#{params[:q]}%"})

      @pages = Page.order('title').where('page_id IS NULL')
      @pages = @pages.where("(short_name LIKE :q OR title LIKE :q OR content LIKE :q)", {:q => "%#{params[:q]}%"})

      @posts = Post.order('created_at DESC').where('status = :s', {:s => Post::ACTIVE})
      @posts = @posts.where("(content LIKE :q)", {:q => "%#{params[:q]}%"})

      @page_files = PageFile.order('created_at DESC').where('status = :s', {:s => PageFile::PUBLISHED})
      @page_files = @page_files.where("(title LIKE :q OR description LIKE :q)", {:q => "%#{params[:q]}%"})

      @page_file_sections = PageFileSection.order('created_at DESC').where('status = :s', {:s => PageFileSection::PUBLISHED})
      @page_file_sections = @page_file_sections.where("(title LIKE :q OR description LIKE :q)", {:q => "%#{params[:q]}%"})

      render :layout => false
    else 
      render :inline => ''
    end
  end
end
