package com.fuhousefinder.dao;

import com.fuhousefinder.entity.*;
import com.fuhousefinder.context.DBContext;
import java.sql.*;
import java.util.*;
import java.util.logging.*;

public class PostDAO extends DBContext implements IPost {

    @Override
    public void addPost(Post p) {
        PreparedStatement ps = null;
        Connection connection = null;
        String query = "INSERT INTO [dbo].[Post]\n"
                + "           ([title]\n"
                + "           ,[price]\n"
                + "           ,[address]\n"
                + "           ,[area]\n"
                + "           ,[number_room]\n"
                + "           ,[description]\n"
                + "           ,[landlord_id]\n"
                + "           ,[status]\n"
                + "           ,[post_date]\n"
                + "           ,[location_id])\n"
                + "     VALUES (?,?,?,?,?,?,?,?,?,?)";
        try {
            connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, p.getTitle());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getAddress());
            ps.setString(4, p.getArea());
            ps.setInt(5, p.getNumber_room());
            ps.setString(6, p.getDescription());
            ps.setInt(7, p.getLandlord_id());
            ps.setString(8, p.getStatus());
            ps.setString(9, p.getPost_date());
            ps.setInt(10, p.getLocation_id());

            ps.executeUpdate();
            //System.out.println("Thanh cong roi");
        } catch (SQLException e) {
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    @Override
    public List<Post> ListAllPosts() {
        List<Post> post = new ArrayList<>();
        String sql = "SELECT * FROM post ORDER BY post_date DESC;";
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            resultSet = ps.executeQuery(); // Thực thi truy vấn và lấy kết quả

            while (resultSet.next()) {
                Post posts = new Post();
                Integer post_id = resultSet.getInt("post_id");
                String title = resultSet.getString("title");
                Double price = resultSet.getDouble("price");
                String address = resultSet.getString("address");
                String area = resultSet.getString("area");
                Integer number_room = resultSet.getInt("number_room");
                String description = resultSet.getString("description");
                String status = resultSet.getString("status");
                String post_date = resultSet.getString("post_date");
                Integer landlord_id = resultSet.getInt("landlord_id");
                Integer location_id = resultSet.getInt("location_id");
                List<String> img = this.getImgPost(post_id);
                Profile landlord = this.getLandLordProfile(landlord_id);
                String avatarLandlord = this.getAvatarLandlord(landlord_id);
                posts.setAvatarLandlord(avatarLandlord);
                posts.setImg(img);
                posts.setLanlord(landlord);
                posts.setPost_id(post_id);
                posts.setTitle(title);
                posts.setPrice(price);
                posts.setAddress(address);
                posts.setArea(area);
                posts.setNumber_room(number_room);
                posts.setDescription(description);
                posts.setStatus(status);
                posts.setPost_date(post_date);
                posts.setLandlord_id(landlord_id);
                posts.setLocation_id(location_id);
                post.add(posts);
            }
        } catch (SQLException ex) {
            //System.out.println("Error " + ex.getMessage() + "at DBContext");
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResultSet(resultSet);
            closeStatement(ps);
            closeConnection(connection);
        }
        return post;
    }

    @Override
    public boolean deletePost(int post_id) {
        String sql = "DELETE FROM post WHERE post_id = ?";
        PreparedStatement ps = null;
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, post_id); // Sử dụng ps thay vì statement ở đây
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
        return false;
    }

    @Override
    public void deleteImagePost(int post_id) {
        String sql = "DELETE FROM image WHERE post_id = ?";
        PreparedStatement ps = null;
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, post_id); // Sử dụng ps thay vì statement ở đây
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Post deleted successfully!");
            } else {
                System.out.println("No post found with ID " + post_id);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    @Override
    public void editPost(Post p) {
        String query = "UPDATE [dbo].[Post]\n"
                + "   SET [title] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[area] = ?\n"
                + "      ,[number_room] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[landlord_id] = ?\n"
                + "      ,[status] = ?\n"
                + "      ,[post_date] = ?\n"
                + "      ,[location_id] = ?\n"
                + " WHERE post_id = ?";
        PreparedStatement ps = null;
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, p.getTitle());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getAddress());
            ps.setString(4, p.getArea());
            ps.setInt(5, p.getNumber_room());
            ps.setString(6, p.getDescription());
            ps.setInt(7, p.getLandlord_id());
            ps.setString(8, p.getStatus());
            ps.setString(9, p.getPost_date());
            ps.setInt(10, p.getLocation_id());
            ps.setInt(11, p.getPost_id()); // Di chuyển lên phía trước

            ps.executeUpdate();
            System.out.println("Edit successfully!");
        } catch (SQLException e) {
//            System.out.println("Error");
//            System.out.println(e);
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    @Override
    public Post getById(int id) {
        String sql = "select * from post where post_id = ?";
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            resultSet = ps.executeQuery(); // Thực thi truy vấn và lấy kết quả

            while (resultSet.next()) {
                Post posts = new Post();
                Integer post_id = resultSet.getInt("post_id");
                String title = resultSet.getString("title");
                Double price = resultSet.getDouble("price");
                String address = resultSet.getString("address");
                String area = resultSet.getString("area");
                Integer number_room = resultSet.getInt("number_room");
                String description = resultSet.getString("description");
                String status = resultSet.getString("status");
                String post_date = resultSet.getString("post_date");
                Integer landlord_id = resultSet.getInt("landlord_id");
                Integer location_id = resultSet.getInt("location_id");

                posts.setPost_id(post_id);
                posts.setTitle(title);
                posts.setPrice(price);
                posts.setAddress(address);
                posts.setArea(area);
                posts.setNumber_room(number_room);
                posts.setDescription(description);
                posts.setStatus(status);
                posts.setPost_date(post_date);
                posts.setLandlord_id(landlord_id);
                posts.setLocation_id(location_id);
                return posts;
            }
        } catch (SQLException ex) {
            //System.out.println("Error " + ex.getMessage() + "at DBContext");
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResultSet(resultSet);
            closeStatement(ps);
            closeConnection(connection);
        }
        return null;
    }

    @Override
    public List<String> getImgPost(int idPost) {
        List<String> img = new ArrayList<>();
        String sql = "select * from Image where post_id = ?";
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, idPost);
            resultSet = ps.executeQuery(); // Thực thi truy vấn và lấy kết quả

            while (resultSet.next()) {
                img.add(resultSet.getString("image_url"));
            }
        } catch (SQLException ex) {
            //System.out.println("Error " + ex.getMessage() + "at DBContext");
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResultSet(resultSet);
            closeStatement(ps);
            closeConnection(connection);
        }
        return img;
    }

    @Override
    public String getAvatarLandlord(int id) {
        String sql = "select * from avatar where user_id = ?";
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            resultSet = ps.executeQuery(); // Thực thi truy vấn và lấy kết quả
            while (resultSet.next()) {
                String url = resultSet.getString("avatar_url");
                return url;
            }
        } catch (SQLException ex) {
            //System.out.println("Error " + ex.getMessage() + "at DBContext");
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResultSet(resultSet);
            closeStatement(ps);
            closeConnection(connection);
        }
        return null;
    }

    @Override
    public Profile getLandLordProfile(int landlordId) {
        String sql = "select * from Landlord where user_id = ?";
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, landlordId);
            resultSet = ps.executeQuery(); // Thực thi truy vấn và lấy kết quả
            while (resultSet.next()) {
                Profile profile = new Profile(landlordId,
                        resultSet.getString("first_name"),
                        resultSet.getString("last_name"),
                        resultSet.getString("address"),
                        resultSet.getString("phone"),
                        2,
                        resultSet.getInt("user_id"));
                return profile;
            }
        } catch (SQLException ex) {
            //System.out.println("Error " + ex.getMessage() + "at DBContext");
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResultSet(resultSet);
            closeStatement(ps);
            closeConnection(connection);
        }
        return null;
    }

    @Override
    public void addImagePost(int postId, String imageUrl) {
        PreparedStatement ps = null;
        String query = "INSERT INTO Image (post_id,image_url)VALUES (?,?)";
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, postId);
            ps.setString(2, imageUrl);

            ps.executeUpdate();
            //System.out.println("Thanh cong roi");
        } catch (SQLException e) {
            //System.out.println("Error");
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    @Override
    public int getIdNewPost() {
        String sql = "SELECT MAX(post_id) AS post_id FROM Post";
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        Connection connection = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            resultSet = ps.executeQuery(); // Thực thi truy vấn và lấy kết quả
            while (resultSet.next()) {
                return resultSet.getInt("post_id");
            }
        } catch (SQLException ex) {
            //System.out.println("Error " + ex.getMessage() + "at DBContext");
            Logger.getLogger(Post.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResultSet(resultSet);
            closeStatement(ps);
            closeConnection(connection);
        }
        return 0;
    }

    public static void main(String[] args) {
        PostDAO dao = new PostDAO();
        System.out.println(dao.getIdNewPost());
//        Post p = new Post(7,"1",1,"a","a",1,"a,","a","2023-02-02",2,1);
//        dao.editPost(p);
//dao.deletePost(9););
//        List<Post> ls = dao.ListAllPosts();
//        for (Post l : ls) {
//            System.out.println(l.getAddress());
//            System.out.println(l.getLanlord().getLastName());
//        }

    }
}
