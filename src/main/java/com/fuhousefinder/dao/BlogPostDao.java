/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuhousefinder.dao;
import com.fuhousefinder.context.DBContext;
import com.fuhousefinder.entity.BlogPost;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BlogPostDao extends DBContext {

    public void addBlogPost(BlogPost blogPost) {
        String sql = "INSERT INTO BLOG_POSTS (user_id, title, content, publish_date) VALUES (?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogPost.getUserId());
            ps.setString(2, blogPost.getTitle());
            ps.setString(3, blogPost.getContent());
            ps.setTimestamp(4, Timestamp.valueOf(blogPost.getPublishDate()));
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<BlogPost> getBlogPosts(int page, int pageSize, String sort, String search) {
        List<BlogPost> blogPosts = new ArrayList<>();
        String sortOrder = "newest".equals(sort) ? "DESC" : "ASC";
        String sql = "SELECT bp.post_id, bp.user_id, bp.title, bp.content, bp.publish_date " +
                     "FROM BLOG_POSTS bp " +
                     "JOIN USERS u ON bp.user_id = u.user_id " +
                     "WHERE bp.title LIKE ? " +
                     "ORDER BY bp.publish_date " + sortOrder + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BlogPost blogPost = new BlogPost();
                    blogPost.setPostId(rs.getInt("post_id"));
                    blogPost.setUserId(rs.getInt("user_id"));
                    blogPost.setTitle(rs.getString("title"));
                    blogPost.setContent(rs.getString("content"));
                    blogPost.setPublishDate(rs.getTimestamp("publish_date").toLocalDateTime());

                    blogPosts.add(blogPost);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return blogPosts;
    }


   public int getTotalBlogPosts(String search) {
        String sql = "SELECT COUNT(*) FROM BLOG_POSTS WHERE title LIKE ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
