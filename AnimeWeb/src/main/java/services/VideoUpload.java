package services;

import net.coobird.thumbnailator.Thumbnails;

import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class VideoUpload {
    public static final String SAVE_PATH_CHAPTER_MOVIE = "anime-main" + File.separator + "storage" + File.separator + "chapters" + File.separator;
    public static final String SAVE_FOLDER_CHAPTER_MOVIE = "/anime-main/" + "/storage"  + "/chapters/";
    public String createSavePathChapterMovie(String realPath,String idMovie,String index,String moreExtension,String extension) {
        return realPath + SAVE_PATH_CHAPTER_MOVIE + idMovie+index+moreExtension + extension;
    }
    public String createSaveChapterMovieData(Part file,String idMovie,String index,String moreExtension) {
        ImageUpload img = new ImageUpload();
        return SAVE_FOLDER_CHAPTER_MOVIE + idMovie+index+moreExtension + img.getExtensionFile(file.getSubmittedFileName());
    }
    public String fullPathChapter(Part file, String idMovie,String index, String realPath, String moreExtension){
        ImageUpload img = new ImageUpload();


        String extension = img.getExtensionFile(file.getSubmittedFileName());
        return createSavePathChapterMovie(realPath, idMovie,index, moreExtension, extension);
    }
    public boolean writeFile(Part file,String fullPath) throws IOException {
        file.write(fullPath);
        File f = new File(fullPath);
        return f.length()==file.getSize();
    }
}
