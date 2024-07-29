package com.fuhousefinder.dao;

import com.fuhousefinder.entity.Post;
import com.fuhousefinder.entity.Profile;
import java.util.List;

public interface IPost {

    public void addPost(Post p);

    public List<Post> ListAllPosts();

    public boolean deletePost(int post_id);

    public void deleteImagePost(int post_id);

    public void editPost(Post p);

    public Post getById(int id);

    public List<String> getImgPost(int idPost);

    public String getAvatarLandlord(int id);

    public Profile getLandLordProfile(int landlordId);

    public void addImagePost(int postId, String imageUrl);

    public int getIdNewPost();

}
