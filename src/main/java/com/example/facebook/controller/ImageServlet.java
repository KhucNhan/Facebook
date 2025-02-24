package com.example.facebook.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {
    private static final String AVATAR_DIR = "C:\\uploads\\avatars";
    private static final String POSTMEDIA_DIR = "C:\\uploads\\postMedias";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Lấy toàn bộ phần path sau "/uploads/"
        String pathInfo = request.getPathInfo(); // Ví dụ: "/avatars/user123.jpg"
        if (pathInfo == null || pathInfo.length() <= 1) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file path");
            return;
        }

        // Tách thư mục và tên file
        String[] parts = pathInfo.substring(1).split("/", 2); // Loại bỏ dấu "/"
        if (parts.length < 2) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file path");
            return;
        }

        String directory = parts[0];  // "avatars" hoặc "postMedias"
        String filename = parts[1];   // Tên file, ví dụ: "user123.jpg"

        // Xác định thư mục gốc
        String baseDir;
        if ("avatars".equals(directory)) {
            baseDir = AVATAR_DIR;
        } else if ("postMedias".equals(directory)) {
            baseDir = POSTMEDIA_DIR;
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Định vị file
        File file = new File(baseDir, filename);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Thiết lập kiểu dữ liệu trả về (MIME Type)
        response.setContentType(getServletContext().getMimeType(filename));
        response.setContentLength((int) file.length());

        // Đọc file và gửi về client
        Files.copy(file.toPath(), response.getOutputStream());
    }
}


