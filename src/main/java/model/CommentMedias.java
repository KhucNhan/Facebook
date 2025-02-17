package model;

public class CommentMedias {
    private int commentMediaId;
    private int commentId;
    private String url;
    private String type;

    public CommentMedias(){

    }
    public CommentMedias(int commentMediaId, int commentId, String url, String type){
        this.commentMediaId = commentMediaId;
        this.commentId = commentId;
        this.url = url;
        this.type = type;
    }

    public int getCommentMediaId() {
        return commentMediaId;
    }

    public void setCommentMediaId(int commentMediaId) {
        this.commentMediaId = commentMediaId;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
