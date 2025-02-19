package com.example.facebook.service;

import com.example.facebook.model.MessageMedia;
import com.example.facebook.model.PostMedia;

import java.sql.SQLException;
import java.util.List;

public interface IMediaDAO {
    List<PostMedia> selectAllPostMedia(int postId) throws SQLException;

}
