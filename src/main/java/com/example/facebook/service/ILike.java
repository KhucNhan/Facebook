package com.example.facebook.service;

import com.example.facebook.model.PostEmotion;

public interface ILike {
    boolean checkLikePost(int userId,int postId);

    boolean deleteLikePost(int userId, int postId);

    void addLikeToPost(int postId,int userId);

    int getTotalLikePost(int postId);


    boolean checkLikeComment(int userId,int commentId);

    boolean deleteLikeComment(int userId, int commentId);
    void addLikeToComment(int commentId,int userId);


}
