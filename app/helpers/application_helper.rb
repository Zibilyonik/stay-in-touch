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

  def friend_request_button(friend)
    return nil if friend == current_user
    friendship1 = current_user.friendships.find_by(friend_id: friend.id)
    friendship2 = current_user.inverse_friendships.find_by(user_id: friend.id, friend_id: current_user.id)
    if friendship1 && friendship2
      button_to('Delete Friend', user_friendships_path(user_id: current_user.id, friend_id: friend.id), method: :destroy)
    elsif !friendship1 && !friendship2
      button_to('Add Friend', user_friendships_path(user_id: current_user.id, friend_id: friend.id), method: :create)
    elsif friendship1 && !friendship2
      button_to('Cancel Request', user_inverse_friendships_destroy_path(user_id: current_user.id, friend_id: friend.id), method: :cancel)
    else
      button_to('Accept Friend', user_friendships_path(user_id: current_user.id, friend_id: friend.id), method: :create)
    end
  end
end
