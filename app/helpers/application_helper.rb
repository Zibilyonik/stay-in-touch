module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friend_posts(friend)
    return nil unless current_user.friends.include?(friend)

    render @posts
  end

  def friend_request_button(usr, fri)
    return nil if fri == current_user

    f1 = usr.friendships.find_by(friend_id: fri.id)
    f2 = usr.inverse_friendships.find_by(user_id: fri.id)
    if f1
      if f2
        button_to('Delete', user_friendship_path(id: f1.id, user_id: usr.id, friend_id: fri.id), method: :destroy)
      else
        button_to('Cancel', user_friendship_path(id: f1.id, user_id: usr.id, friend_id: fri.id), method: :destroy)
      end
    elsif f2
      button_to('Accept Friend', user_friendships_path(user_id: usr.id, friend_id: fri.id), method: :create)
    else
      button_to('Add Friend', user_friendships_path(user_id: usr.id, friend_id: fri.id), method: :create)
    end
  end
end
