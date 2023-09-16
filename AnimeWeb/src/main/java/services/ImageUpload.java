package services;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Part;

import model.AvartarMovie;
import net.coobird.thumbnailator.Thumbnails;
import org.jdbi.v3.core.Jdbi;

import database.JDBiConnector;

public class ImageUpload {
	public static final String SAVE_PATH_AVT_USER = "anime-main" + File.separator + "storage" + File.separator + "avatarUser" + File.separator;
	public static final String SAVE_FOLDER_AVT_USER = "/anime-main/" + "/storage"  + "/avatarUser/";
	public static final String SAVE_PATH_AVT_MOVIE = "anime-main" + File.separator + "storage" + File.separator + "avatarMovie" + File.separator;
	public static final String SAVE_FOLDER_AVT_MOVIE = "/anime-main/" + "/storage"  + "/avatarMovie/";

	public ImageUpload() {

	}
	public String findImageUser(int idUser,int typeID) {
		Jdbi me = JDBiConnector.me();
		String query="select avatar from accounts where id=:idUser and typeId=:typeId";
		return me.withHandle(handle->{
			return handle.createQuery(query).bind("idUser", idUser).bind("typeId", typeID).mapTo(String.class).findOne().orElse("/anime-main/storage/avatarUser/defaultavatar.jpg");
		});
	}
	public String getExtensionFile(String fileName) {
		int index = fileName.lastIndexOf('.');
		return fileName.substring(index);
	}
	public String createSavePathAvatarUser(String realPath,int idUser,String moreExtension,String extension) {
		return realPath + SAVE_PATH_AVT_USER + idUser+moreExtension + extension;
	}
	public String createSaveAvatarUserData(int idUser,String moreExtension,String extension) {
		return SAVE_FOLDER_AVT_USER + idUser+moreExtension + extension;
	}
	public boolean saveAvatarUser(Part file, int idUser, String realPath,String moreExtension) throws IOException {
		Path tempPath = Paths.get(System.getProperty("java.io.tmpdir"),
				file.getSubmittedFileName());
		try (InputStream inputStream = file.getInputStream()) {
			Files.copy(inputStream, tempPath);
		}
		String extension = getExtensionFile(file.getSubmittedFileName());
		String fullPath = createSavePathAvatarUser(realPath, idUser, moreExtension, extension);

		Thumbnails.of(tempPath.toFile())
				.size(200, 200)
				.outputQuality(1)
				.toFile(fullPath);
		Files.delete(tempPath);
		File f = new File(fullPath);
		return f.exists() && f.length() == file.getSize();

	}
	public String createSavePathAvatarMovie(String realPath,int idMovie,String moreExtension,String extension) {
		return realPath + SAVE_PATH_AVT_MOVIE + idMovie+moreExtension + extension;
	}
	public String createSaveAvatarMovieData(int idMovie,String moreExtension,String extension) {
		return SAVE_FOLDER_AVT_MOVIE + idMovie+moreExtension + extension;
	}
	public List<String> saveAvatarMovie(List<Part> files, int idMovie, String realPath,String moreExtension) throws IOException {
		List<String> result = new ArrayList<>();
		int i=0;
		Path tempPath;
		String extension;
		String fullPath;
		for(Part file : files){
			i++;
			tempPath = Paths.get(System.getProperty("java.io.tmpdir"),
					file.getSubmittedFileName());
			extension = getExtensionFile(file.getSubmittedFileName());
			fullPath = createSavePathAvatarMovie(realPath, idMovie, moreExtension+i, extension);
			try (InputStream inputStream = file.getInputStream()) {
				Files.copy(inputStream, tempPath);
				result.add(createSaveAvatarMovieData(idMovie,moreExtension+i,extension));
				Thumbnails.of(tempPath.toFile())
						.size(800, 600)
						.outputQuality(1)
						.toFile(fullPath);
				Files.delete(tempPath);
			}catch (Exception e){
				e.printStackTrace();
			}

		}
		return result;


	}

	public List<String> saveEditAvatarMovie(List<AvartarMovie> listOldImage, List<Part> files, int idMovie, String realPath, String moreExtension) throws IOException {
		List<String> result = new ArrayList<>();
		int i=0;
		Path tempPath;
		String extension;
		String fullPath;
		File oldImage;
		for(Part file : files){
			 i++;
			 tempPath = Paths.get(System.getProperty("java.io.tmpdir"),file.getSubmittedFileName());
			 extension = getExtensionFile(file.getSubmittedFileName());
			 fullPath = createSavePathAvatarMovie(realPath, idMovie, moreExtension+i, extension);
			try (InputStream inputStream = file.getInputStream()) {
				Files.copy(inputStream, tempPath);
				result.add(createSaveAvatarMovieData(idMovie,moreExtension+i,extension));
				oldImage = new File( realPath+File.separator+listOldImage.get(i-1).getName());

				Thumbnails.of(tempPath.toFile())
						.size(800, 600)
						.outputQuality(1)
						.toFile(fullPath);
				Files.delete(tempPath);
				oldImage.delete();
			}catch (Exception e){
				e.printStackTrace();
			}
		}
		return result;
	}
}
