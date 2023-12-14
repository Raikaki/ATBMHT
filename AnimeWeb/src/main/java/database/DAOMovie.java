package database;


import model.*;
import org.jdbi.v3.core.Jdbi;

import java.util.*;


public class DAOMovie {
    public DAOMovie() {

    }

    public static double getPercentBonus(int idMovie) {
        String query = "SELECT bn.percent from movies m join movies_bonus mb on m.id = mb.idMovie join bonus bn on mb.idBonus = bn.id where m.id=:idMovie and now() BETWEEN  bn.dayBegin and bn.dayEnd and bn.status =1;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapTo(Double.class).findFirst().orElse(0.0);
        });
    }

    public static void updateView(String idAccount,String idMovie) {

        Jdbi me = JDBiConnector.me();
        me.useHandle(handle -> {
            String query;
            query= "UPDATE `movies` SET `views` = `views`+1  WHERE (`id` = :idMovie);";
            handle.createUpdate(query).bind("idMovie", idMovie).execute();
            if(idAccount.equalsIgnoreCase("null")){
                query="insert into user_views (`idMovie`) values(:idMovie)";
                    handle.createUpdate(query).bind("idMovie",idMovie).execute();
            } else {
                query = "insert into user_views (`idAccount`, `idMovie`) values(:idAccount,:idMovie)";
                    handle.createUpdate(query).bind("idAccount",idAccount).bind("idMovie",idMovie).execute();
            }
        });


    }


    public static boolean removeChapter(String idMovie,String idChapter) {
        String query = "delete from chapters_movie where id=:id";
        String update = "UPDATE `movies` SET `currentEpisode` = `currentEpisode`-1  WHERE (`id` = :idMovie);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            handle.createUpdate(update).bind("idMovie",idMovie).execute();
            return handle.createUpdate(query).bind("id", idChapter).execute();
        }) == 1;
    }

    public static ChapterMovie updateChapter(String id, String index, String opening, String name) {

        String query = "UPDATE `chapters_movie` SET `index` =:index,opening=:opening,name=:name WHERE id=:id;";
        Jdbi me = JDBiConnector.me();
        me.useHandle(handle -> {
            handle.createUpdate(query).bind("index", index).bind("opening", opening).bind("name", name).bind("id", id).execute();
        });
        return findChapter(Integer.parseInt(id));
    }

    public static ChapterMovie updateChapter(String id, String index, String opening) {

        String query = "UPDATE `chapters_movie` SET `index` =:index,opening=:opening WHERE id=:id;";
        Jdbi me = JDBiConnector.me();
        me.useHandle(handle -> {
            handle.createUpdate(query).bind("index", index).bind("opening", opening).bind("id", id).execute();
        });
        return findChapter(Integer.parseInt(id));
    }

    public static ChapterMovie addChapter(String idMovie, String index, String opening, String name) {
        String query = "INSERT INTO `chapters_movie` (`idMovie`, `index`, `opening`, `name`) VALUES (:idMovie, :index, :opening,:name);";
        Jdbi me = JDBiConnector.me();
        String update = "UPDATE `movies` SET `currentEpisode` = `currentEpisode`+1  WHERE (`id` = :idMovie);";

         return me.withHandle(handle -> {
            handle.begin();
            try{
                int idChapter= handle.createUpdate(query).bind("idMovie", idMovie).bind("index", index).bind("opening", opening).bind("name", name).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one();
                handle.createUpdate(update).bind("idMovie", idMovie).execute();
                handle.commit();
                return findChapter(idChapter);
            }catch (Exception e ){
                handle.rollback();
                e.printStackTrace();
                return null;

            }
          });


    }

    public static ChapterMovie findChapter(int id) {
        String query = "select id,idMovie,`index`,opening,name from chapters_movie where id=:id";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("id", id).mapToBean(ChapterMovie.class).one();
        });
    }

    public static boolean isValidChapter(String idMovie, String index) {
        String query = "SELECT EXISTS(SELECT 1 FROM chapters_movie WHERE idMovie = :idMovie AND `index` = :index) as exist;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).bind("index", index).mapTo(Boolean.class).one();
        });
    }

    public static List<ChapterMovie> getListChapter(String idMovie) {
        String query = "select id,idMovie,`index`,opening,name from chapters_movie where idMovie= :idMovie order by `index`";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapToBean(ChapterMovie.class).list();
        });
    }
    public static List<Movie> listMovieAdmin() {
        List<Movie> result ;
        String query = "select id,name,currentEpisode,totalEpisode,views,typeId,price,createAt from movies where status=1";
        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Movie.class).list();
        });
        for (Movie m : result) {
            m.setPercent(getPercentBonus(m.getId()));
            m.setType(getTypeMovie(m.getId()));
            m.setAvgRate(DAORate.getAVGRate(m.getId()));
        }
        return result;
    }

    public static List<TypeMovie> getListTypeMovie() {
        String query = "select id,description from types_movie where status=1";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(TypeMovie.class).list();
        });
    }

    public static void updateAvatarMovie(List<String> avatars, int idMovie) {
        String query = "INSERT INTO `avatars_movie` (`name`,`idMovie`) values(:name,:idMovie);";
        String removeOldAvt = "DELETE FROM `avatars_movie` WHERE (`idMovie` = :idMovie);";
        Jdbi me = JDBiConnector.me();
        me.useHandle(handle -> {
            handle.createUpdate(removeOldAvt).bind("idMovie", idMovie).execute();
            for (String nameAvt : avatars) {
                handle.createUpdate(query).bind("name", nameAvt).bind("idMovie", idMovie).execute();
            }
        });
    }


    public static int addMovie(String name,String totalEpisode,String descriptionVN,String descriptionEN,String typeID,String price,String[] idGenres,String[] producersValue,String supplier,String priceImport){

        Jdbi me = JDBiConnector.me();
        final int[] idMovieFinal = {-1};
        me.useHandle(handle -> {
            handle.begin();
            try {
                String query;
                int idMovie;
                query="INSERT INTO `movies` (`name`, `totalEpisode`, `descriptionVN`, `descriptionEN`, `typeID`, `price`) VALUES (:name,:totalEpisode,:descriptionVN,:descriptionEN,:typeID,:price);";
                idMovie= handle.createUpdate(query).bind("name",name).bind("totalEpisode",totalEpisode).bind("descriptionVN",descriptionVN).bind("descriptionEN",descriptionEN).bind("typeID",typeID).bind("price",price).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one();
                query ="INSERT INTO `movie_genres` (`idMovie`,`idGenre`) values(:idMovie,:idGenre)";
                for(String idGenre : idGenres){
                    System.out.println("genre "+idGenre);
                    handle.createUpdate(query).bind("idMovie",idMovie).bind("idGenre",idGenre).execute();

                }
                query = "INSERT INTO `movie_producers` (`idMovie`,`idProducer`) values(:idMovie,:idProducer)";
                for (String idProducer : producersValue) {
                    handle.createUpdate(query).bind("idMovie", idMovie).bind("idProducer", idProducer).execute();
                }
                query = "INSERT INTO `import_coupons` (`idMovie`,`idSupplier`,`price`) values(:idMovie,:idSupplier,:price)";
                handle.createUpdate(query).bind("idMovie", idMovie).bind("idSupplier", supplier).bind("price", priceImport).execute();
                handle.commit();
                idMovieFinal[0] = idMovie;
            } catch (Exception e) {
                e.printStackTrace();
                handle.rollback();
            }
        });
        return idMovieFinal[0];
    }

    public static void editMovie(int idMovie, String name, String totalEpisode, String descriptionVN, String descriptionEN, String typeID, String price, String[] idGenres, String[] producersValue) {
        Jdbi me = JDBiConnector.me();
        me.useHandle(handle -> {
            handle.begin();
            try {
                String query;
                query = "update `movies` set `name`=:name, `totalEpisode`=:totalEpisode, `descriptionVN`=:descriptionVN, `descriptionEN`=:descriptionEN, `typeID`=:typeID, `price`=:price,`updateAt`=now() where id=:idMovie;";
                handle.createUpdate(query).bind("idMovie", idMovie).bind("name", name).bind("totalEpisode", totalEpisode).bind("descriptionVN", descriptionVN).bind("descriptionEN", descriptionEN).bind("typeID", typeID).bind("price", price).execute();
                query = "delete from `movie_genres` where idMovie=:idMovie";
                handle.createUpdate(query).bind("idMovie", idMovie).execute();
                query = "INSERT INTO `movie_genres` (`idMovie`,`idGenre`) values(:idMovie,:idGenre)";
                for (String idGenre : idGenres) {
                    handle.createUpdate(query).bind("idMovie", idMovie).bind("idGenre", idGenre).execute();
                }
                query = "delete from `movie_producers` where idMovie=:idMovie";
                handle.createUpdate(query).bind("idMovie", idMovie).execute();
                query = "INSERT INTO `movie_producers` (`idMovie`,`idProducer`) values(:idMovie,:idProducer)";
                for (String idProducer : producersValue) {
                    handle.createUpdate(query).bind("idMovie", idMovie).bind("idProducer", idProducer).execute();
                }
                handle.commit();

            } catch (Exception e) {
                e.printStackTrace();
                handle.rollback();
            }

        });
    }

    public static List<Genre> listGenreHeader() {
        String query = "select id,description from genres where status=1";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Genre.class).list();
        });
    }

    public static List<Producer> getProducers(int idMovie) {
        String query = "SELECT distinct pr.id,pr.name,pr.description FROM movies m join movie_producers p on m.id = p.idMovie join producers pr on p.idproducer = pr.id where pr.status=1 and m.id=:idMovie;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapToBean(Producer.class).list();
        });
    }


    public static int getViewsMovie(int idMovie) {
        String query = "select count(*) from user_views where idMovie =:idMovie;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapTo(Integer.class).findOne().orElse(0);
        });
    }

    public static Movie watchingMovie(String idMovie) {
        String query = "select id,name from movies where id=:idMovie and status=1;";
        Jdbi me = JDBiConnector.me();
        Movie result;
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapToBean(Movie.class).one();
        });
        result.setType(getTypeMovie(Integer.parseInt(idMovie)));
        result.setListChapter(getListChapter(idMovie));

        return result;

    }

    public static List<Producer> getMovieProducerNotHave(List<Producer> movieProducer) {
        String query = " select id,name from producers";
        List<Producer> result;
        Jdbi me = JDBiConnector.me();
        String finalQuery;
        if (!movieProducer.isEmpty()) {
            String idProducerList = " where id not in (" + movieProducer.get(0).getId();
            for (int i = 1; i < movieProducer.size(); i++) {
                idProducerList += "," + movieProducer.get(i).getId();
            }
            idProducerList += ") and status=1";
            query += idProducerList;
            finalQuery = query;
        } else {
            finalQuery = "select id,name from producers where status =1";
        }
        result = me.withHandle(handle -> {
            return handle.createQuery(finalQuery).mapToBean(Producer.class).list();
        });
        return result;
    }

    public static List<Genre> getMovieGenreNotHave(List<Genre> movieGenre) {
        String query = " select id,description from genres";
        List<Genre> result;
        Jdbi me = JDBiConnector.me();
        String finalQuery;
        if (!movieGenre.isEmpty()) {
            String idGenreList = " where id not in (" + movieGenre.get(0).getId();
            for (int i = 1; i < movieGenre.size(); i++) {
                idGenreList += "," + movieGenre.get(i).getId();
            }
            idGenreList += ") and status=1";
            query += idGenreList;
            finalQuery = query;
        } else {
            finalQuery = "select id,description from genres where status =1";
        }
        result = me.withHandle(handle -> {
            return handle.createQuery(finalQuery).mapToBean(Genre.class).list();
        });
        return result;
    }

    public static Movie getMovieEditById(int idMovie) {
        String query = "select id,name,price,descriptionVN,descriptionEN from movies where id=:idMovie and status=1;";
        Jdbi me = JDBiConnector.me();
        Movie result;
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapToBean(Movie.class).findFirst().orElse(new Movie());
        });
        result.setListProducer(getProducers(idMovie));
        result.setAvatars(getFirstAvt(result.getId()));
        result.setGenres(getListGenre(result.getId()));
        result.setPercent(getPercentBonus(result.getId()));
        result.setAvgRate(DAORate.getAVGRate(result.getId()));
        return result;
    }

    public static Movie getMoviebyId(int idMovie) {
        String query = "select id,name,price from movies where id=:idMovie and status=1;";
        Jdbi me = JDBiConnector.me();
        Movie result;
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapToBean(Movie.class).findFirst().orElse(new Movie());
        });
        result.setAvatars(getFirstAvt(result.getId()));
        result.setGenres(getListGenre(result.getId()));
        result.setPercent(getPercentBonus(result.getId()));
        result.setAvgRate(DAORate.getAVGRate(result.getId()));
        result.setListProducer(getProducers(idMovie));
        return result;
    }

    public static Movie getMovieDetail(int idMovie, String lang) {

        String query;
        boolean isEN;
        if (!lang.equalsIgnoreCase("en_US")) {
            isEN = false;
            query = "select m.id,m.name,m.currentEpisode,m.totalEpisode,m.descriptionVN,m.views,t.id as typeId,t.description as typeDescription,m.price \n" +
                    "from movies m join types_movie t on m.typeID = t.id\n" +
                    " where m.id=:idMovie and m.status=1;";
        } else {
            query = "select m.id,m.name,m.currentEpisode,m.totalEpisode,m.descriptionEN,m.views,t.id as typeId,t.description as typeDescription,m.price \n" +
                    "from movies m join types_movie t on m.typeID = t.id\n" +
                    " where m.id=:idMovie and m.status=1;";
            isEN = true;
        }

        Jdbi me = JDBiConnector.me();
        Movie result;
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).map((rs, ctx) -> {
                Movie movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setName(rs.getString("name"));
                movie.setCurrentEpisode(rs.getInt("currentEpisode"));
                movie.setTotalEpisode(rs.getInt("totalEpisode"));
                movie.setViews(rs.getInt("views"));
                movie.setPrice(rs.getDouble("price"));
                movie.setAvatars(getAvatarMovie(movie.getId()));
                movie.setGenres(getListGenre(movie.getId()));
                movie.setListProducer(getProducers(movie.getId()));
                movie.setAvgRate(DAORate.getAVGRate(movie.getId()));
                TypeMovie typeMovie = new TypeMovie();
                typeMovie.setId(rs.getInt("typeId"));
                typeMovie.setDescription(rs.getString("typeDescription"));
                movie.setType(typeMovie);
                if (!movie.isFree()) {
                    movie.setPercent(getPercentBonus(movie.getId()));

                }
                if (isEN) {
                    movie.setDescriptionEN(rs.getString("descriptionEN"));
                } else {
                    movie.setDescriptionVN(rs.getString("descriptionVN"));
                }
                return movie;
            }).findFirst().orElse(new Movie());
        });


        return result;
    }

    public static List<Genre> getListGenre(int idMovie) {
        String query = "select distinct g.id,g.description from movie_genres mvg join genres g on mvg.idGenre = g.id and mvg.idMovie =:idMovie and g.status=1;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapToBean(Genre.class).list();
        });
    }

    public static List<Movie> getPurchasedMovie(int idUser) {
        String query = "SELECT m.id,m.name,totalEpisode,m.currentEpisode,pc.purchaseAt,pc.purchasePrice FROM movies_purchased pc join movies m on pc.idMovie= m.id where idAccount=:idUser and m.status=1;";
        Jdbi me = JDBiConnector.me();
        List<Movie> result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("idUser", idUser).mapToBean(Movie.class).list();
        });
        for (Movie m : result) {
            m.setAvatars(getAvatarMovie(m.getId()));
            m.setGenres(getListGenre(m.getId()));
            m.setAvgRate(DAORate.getAVGRate(m.getId()));
            m.setViews(getViewsMovie(m.getId()));
        }
        return result;
    }

    public static int totalMovie() {
        String query = "select count(id) from movies where status=1;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).mapTo(Integer.class).one();
        });
    }

    public static List<Movie> renderMovie(int index, int totalItem, String param) {
        List<Movie> result;
        Map<String, String> nameOrder = new HashMap<>();
        nameOrder.put("isAtoZ", "name");
        nameOrder.put("notAtoZ", "name");
        nameOrder.put("isDescPrice", "price");
        nameOrder.put("notDescPrice", "price");
        nameOrder.put("isDescDate", "createAt");
        nameOrder.put("notDescDate", "createAt");
        Map<String, String> sort = new HashMap<>();
        sort.put("isAtoZ", "asc");
        sort.put("notAtoZ", "desc");
        sort.put("isDescPrice", "desc");
        sort.put("notDescPrice", "asc");
        sort.put("isDescDate", "asc");
        sort.put("notDescDate", "desc");
        String order = "order by m." + nameOrder.get(param) + " " + sort.get(param);
        String query = "select m.id,m.name,m.currentEpisode,m.totalEpisode,m.views,t.id as typeId, t.description as typeDescription,m.price \n" +
                "from movies m join types_movie t on m.typeID = t.id\n" +
                "where m.status=1\n" +
                order +
                " limit :totalItem offset :index\n" +
                ";";

        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("totalItem", totalItem).bind("index", index).map((rs, ctx) -> {
                Movie movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setName(rs.getString("name"));
                movie.setCurrentEpisode(rs.getInt("currentEpisode"));
                movie.setTotalEpisode(rs.getInt("totalEpisode"));
                movie.setViews(rs.getInt("views"));
                movie.setPrice(rs.getDouble("price"));
                movie.setAvatars(getFirstAvt(movie.getId()));
                movie.setAvgRate(DAORate.getAVGRate(movie.getId()));
                movie.setGenres(getListGenre(movie.getId()));
                TypeMovie typeMovie = new TypeMovie();
                typeMovie.setId(rs.getInt("typeId"));
                typeMovie.setDescription(rs.getString("typeDescription"));

                movie.setType(typeMovie);
                if (!movie.isFree()) {
                    movie.setPercent(getPercentBonus(movie.getId()));

                }
                return movie;
            }).list();
        });

        return result;
    }

    public static List<Movie> renderBonusMovie(int index, int totalItem, String param, String idBonus) {
        List<Movie> result;
        Map<String, String> nameOrder = new HashMap<>();
        nameOrder.put("isAtoZ", "name");
        nameOrder.put("notAtoZ", "name");
        nameOrder.put("isDescPrice", "price");
        nameOrder.put("notDescPrice", "price");
        nameOrder.put("isDescDate", "createAt");
        nameOrder.put("notDescDate", "createAt");
        Map<String, String> sort = new HashMap<>();
        sort.put("isAtoZ", "asc");
        sort.put("notAtoZ", "desc");
        sort.put("isDescPrice", "desc");
        sort.put("notDescPrice", "asc");
        sort.put("isDescDate", "asc");
        sort.put("notDescDate", "desc");
        String order = "order by m." + nameOrder.get(param) + " " + sort.get(param);
        String query = "select m.id,m.name,m.currentEpisode,m.totalEpisode,m.views,t.id as typeId, t.description as typeDescription,m.price \n" +
                "from movies m join types_movie t on m.typeID = t.id join movies_bonus mb on m.id=mb.idMovie\n" +
                "where m.status=1 and m.typeId=2 and mb.idBonus=:idBonus\n" +
                order +
                " limit :totalItem offset :index\n" +
                ";";

        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("totalItem", totalItem).bind("index", index).bind("idBonus", idBonus).map((rs, ctx) -> {
                Movie movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setName(rs.getString("name"));
                movie.setCurrentEpisode(rs.getInt("currentEpisode"));
                movie.setTotalEpisode(rs.getInt("totalEpisode"));
                movie.setViews(rs.getInt("views"));
                movie.setPrice(rs.getDouble("price"));
                movie.setAvatars(getFirstAvt(movie.getId()));
                movie.setAvgRate(DAORate.getAVGRate(movie.getId()));
                movie.setGenres(getListGenre(movie.getId()));
                TypeMovie typeMovie = new TypeMovie();
                typeMovie.setId(rs.getInt("typeId"));
                typeMovie.setDescription(rs.getString("typeDescription"));

                movie.setType(typeMovie);
                if (!movie.isFree()) {
                    movie.setPercent(getPercentBonus(movie.getId()));

                }
                return movie;
            }).list();
        });

        return result;
    }

    public static List<Movie> getMoviesFollow(int idUser) {
        String query = "SELECT m.id,m.name,totalEpisode,m.currentEpisode,m.price,f.followAt FROM follows f join movies m on f.idMovie= m.id where idAccount=:idUser and m.status=1";
        Jdbi me = JDBiConnector.me();

        List<Movie> result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("idUser", idUser).mapToBean(Movie.class).list();
        });
        for (Movie m : result) {
            m.setAvatars(getAvatarMovie(m.getId()));
            m.setGenres(getListGenre(m.getId()));
            m.setType(getTypeMovie(m.getId()));
            m.setViews(getViewsMovie(m.getId()));
            m.setPercent(getPercentBonus(m.getId()));
            m.setAvgRate(DAORate.getAVGRate(m.getId()));
        }
        return result;
    }

    public static List<AvartarMovie> getAvatarMovie(int idMovie) {
        String query = "SELECT name FROM avatars_movie where idMovie=:idMovie;";
        Jdbi me = JDBiConnector.me();
        List<AvartarMovie> result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapToBean(AvartarMovie.class).list();
        });
        return result;
    }

    public static TypeMovie getTypeMovie(int idMovie) {
        String query = "select t.id,t.description from movies m join types_movie t on m.typeID = t.id where m.id=:idMovie;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapToBean(TypeMovie.class).one();
        });
    }

    public static int getDetailMoviePurchased(int idAccount, int idMovie) {
        int check;

        String query = "select  idMovie FROM movies_purchased where idMovie=:idMovie and idAccount=:idAccount and status=1;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).bind("idAccount", idAccount).mapTo(Integer.class).findOne().orElse(0);
        });

    }

    public static boolean removeMovie(String idMovie) {
        String query = "UPDATE `movies` SET `status` = '0' WHERE (`id` =:idMovie);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createUpdate(query).bind("idMovie", idMovie).execute();
        }) == 1;
    }

    public static List<Movie> renderMovieFindGenre(int index, int totalItem, String param, String idGenre) {
        List<Movie> result;
        Map<String, String> nameOrder = new HashMap<>();
        nameOrder.put("isAtoZ", "name");
        nameOrder.put("notAtoZ", "name");
        nameOrder.put("isDescPrice", "price");
        nameOrder.put("notDescPrice", "price");
        nameOrder.put("isDescDate", "createAt");
        nameOrder.put("notDescDate", "createAt");
        Map<String, String> sort = new HashMap<>();
        sort.put("isAtoZ", "asc");
        sort.put("notAtoZ", "desc");
        sort.put("isDescPrice", "desc");
        sort.put("notDescPrice", "asc");
        sort.put("isDescDate", "asc");
        sort.put("notDescDate", "desc");
        String order = "order by " + nameOrder.get(param) + " " + sort.get(param);
        String query = "select id,name,currentEpisode,totalEpisode,descriptionVN,descriptionEN,typeID,price,status\n" +
                "from movies m join  movie_genres g  ON m.id = g.idMovie  \n" +
                "where m.status=1 and  g.idGenre = :idGenre  \n" +
                order +
                " limit :totalItem offset :index\n" +
                ";";

        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("totalItem", totalItem).bind("index", index).bind("idGenre", idGenre).mapToBean(Movie.class).list();
        });
        for (Movie m : result) {
            m.setAvatars(getAvatarMovie(m.getId()));
            m.setGenres(getListGenre(m.getId()));
            m.setType(getTypeMovie(m.getId()));
            m.setViews(getViewsMovie(m.getId()));
            m.setPercent(getPercentBonus(m.getId()));
            m.setAvgRate(DAORate.getAVGRate(m.getId()));

        }
        return result;
    }

    public static Genre insertGenre(String genreDescription) {
        String query = "INSERT INTO `genres` (`description`) VALUES (:description);";
        Jdbi me = JDBiConnector.me();
        final int[] idMovieFinal = {-1};

        me.useHandle(handle -> {
            idMovieFinal[0] = handle.createUpdate(query).bind("description", genreDescription).executeAndReturnGeneratedKeys("id").mapTo(Integer.class).one();
        });

        return findGenreById(idMovieFinal[0]);
    }

    public static Genre findGenreById(int idGenre) {
        String query = "select id,description from genres where id=:id and status=1;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("id", idGenre).mapToBean(Genre.class).findOne().orElse(null);
        });
    }

    public static boolean removeGenre(String idGenre) {
        String query = "UPDATE `genres` SET `status` = '0' WHERE (`id` = :id);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createUpdate(query).bind("id", idGenre).execute();
        }) == 1;
    }

    public static Genre settingGenre(String idGenre, String genreDescription) {
        String query = "UPDATE `genres` SET `description` = :description,`updateAt`=now() WHERE (`id` = :id);";
        Jdbi me = JDBiConnector.me();
        boolean isSuccess;
        isSuccess = me.withHandle(handle -> {
            return handle.createUpdate(query).bind("id", idGenre).bind("description", genreDescription).execute();
        }) == 1;
        if (isSuccess) {
            return findGenreById(Integer.parseInt(idGenre));
        } else {
            return null;
        }
    }


    public void insertPurchasedMovie(int idUser, int idMovie, double price,int idBill) {
        String query = "INSERT INTO movies_purchased (idAccount,idBill, idMovie, purchasePrice) VALUES (:idUser,:idBill, :idMovie, :priceVar)";
        Jdbi me = JDBiConnector.me();
        me.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind("idUser", idUser)
                    .bind("idBill",idBill)
                    .bind("idMovie", idMovie)
                    .bind("priceVar", price)
                    .execute();
        });
    }


    public static List<AvartarMovie> getFirstAvt(int idMovie) {
        Jdbi me = JDBiConnector.me();
        String query = "SELECT name,id FROM avatars_movie where idMovie=:idMovie LIMIT 1";
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).mapToBean(AvartarMovie.class).list();
        });
    }

    public static List<Movie> searchMovie(String name) {
        Jdbi me = JDBiConnector.me();
        String query = "SELECT id, name,views FROM movies where status=1 and name LIKE :name GROUP BY id, name ORDER BY views DESC LIMIT 10";

        List<Movie> res = me.withHandle(handle -> {
            return handle.createQuery(query).bind("name", "%" + name + "%")
                    .mapToBean(Movie.class)
                    .list();
        });
        for (Movie mv : res) {
            mv.setAvatars(getFirstAvt(mv.getId()));
        }
        return res;

    }

    public static int getFollow(int idAccount, int idMovie) {
        int check;
        String query = "select  idMovie FROM follows where idMovie=:idMovie and idAccount=:idAccount;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idMovie", idMovie).bind("idAccount", idAccount).mapTo(Integer.class).findOne().orElse(0);
        });
    }

    public static void addFollow(int idAccount, int idMovie) {
        Jdbi me = JDBiConnector.me();
        me.useHandle(handle -> {
            handle.begin();
            try {
                String query = "insert into follows(idAccount,idMovie) values(:idAccount,:idMovie)";
                handle.createUpdate(query).bind("idMovie", idMovie).bind("idAccount", idAccount).execute();
                handle.commit();
            } catch (Exception e) {
                e.printStackTrace();
                handle.rollback();

            }
        });

    }

    public static void removeFollow(int idAccount, int idMovie) {
        Jdbi me = JDBiConnector.me();
        me.useHandle(handle -> {
            handle.begin();
            try {
                String query = "delete  from follows where idMovie=:idMovie and idAccount =:idAccount";
                handle.createUpdate(query).bind("idMovie", idMovie).bind("idAccount", idAccount).execute();
                handle.commit();
            } catch (Exception e) {
                e.printStackTrace();
                handle.rollback();

            }
        });

    }

    public static List<Integer> getDetailMoviePurchaseds(int idAccount) {
        String query = "SELECT idMovie FROM movies_purchased WHERE idAccount = :idAccount and status=1;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind("idAccount", idAccount)
                    .mapTo(Integer.class)
                    .list();
        });
    }

    public static void updateMoviePurchasedStatus(int idAccount, int idMovie,int idBill) {
        String updateQuery = "UPDATE movies_purchased SET status = 0 WHERE idAccount = :idAccount AND idMovie = :idMovie AND idBill=:idBill;";

        Jdbi jdbi = JDBiConnector.me();

        jdbi.useHandle(handle -> {
            handle.createUpdate(updateQuery)
                    .bind("idAccount", idAccount)
                    .bind("idMovie", idMovie).bind("idBill",idBill)
                    .execute();
        });
    }

    public static String getGenre(String idGenre) {
        String query = "SELECT DISTINCT g.description FROM movie_genres mvg JOIN genres g ON mvg.idGenre = g.id WHERE mvg.idGenre = :idGenre AND g.status = 1";
        Jdbi jdbi = JDBiConnector.me();
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind("idGenre", idGenre)
                    .mapTo(String.class)
                    .findOne()
                    .orElse(null);
        });
    }

    public static int totalMovieFindGenre(String idGenre) {
        String query = "select  count(*) from movies m join movie_genres g ON m.id = g.idMovie where g.idGenre = :idGenre and m.status = 1;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).bind("idGenre", idGenre).mapTo(Integer.class).one();
        });
    }

    public static List<Movie> renderMovieFindGenre(int index, int totalItem, String param, String type, String idGenre) {
        List<Movie> result;
        Map<String, String> nameOrder = new HashMap<>();
        String query;
        nameOrder.put("isAtoZ", "name");
        nameOrder.put("notAtoZ", "name");
        nameOrder.put("isDescPrice", "price");
        nameOrder.put("notDescPrice", "price");
        nameOrder.put("isDescDate", "createAt");
        nameOrder.put("notDescDate", "createAt");
        Map<String, String> sort = new HashMap<>();
        sort.put("isAtoZ", "asc");
        sort.put("notAtoZ", "desc");
        sort.put("isDescPrice", "desc");
        sort.put("notDescPrice", "asc");
        sort.put("isDescDate", "asc");
        sort.put("notDescDate", "desc");
        Map<String, String> types = new HashMap<>();
        types.put("all", " ");
        types.put("free", "1");
        types.put("pay", "2");
        String sortType = " and typeID = " + types.get(type);
        String order = "order by " + nameOrder.get(param) + " " + sort.get(param);
        if (type.equalsIgnoreCase("all")) {
            query = "select id,name,currentEpisode,totalEpisode,descriptionVN,descriptionEN,typeID,price,status\n" +
                    "from movies m join  movie_genres g  ON m.id = g.idMovie  \n" +
                    "where m.status=1 and  g.idGenre = :idGenre  \n" +
                    order +
                    " limit :totalItem offset :index\n" +
                    ";";
        } else {
            query = "select id,name,currentEpisode,totalEpisode,descriptionVN,descriptionEN,typeID,price,status\n" +
                    "from movies m join  movie_genres g  ON m.id = g.idMovie  \n" +
                    "where m.status=1 and  g.idGenre = :idGenre  \n" + sortType + "\n" +
                    order +
                    " limit :totalItem offset :index\n" +
                    ";";
        }


        Jdbi me = JDBiConnector.me();
        result = me.withHandle(handle -> {
            return handle.createQuery(query).bind("totalItem", totalItem).bind("index", index).bind("idGenre", idGenre).mapToBean(Movie.class).list();
        });
        for (Movie m : result) {
            m.setAvatars(getAvatarMovie(m.getId()));
            m.setGenres(getListGenre(m.getId()));
            m.setType(getTypeMovie(m.getId()));
            m.setViews(getViewsMovie(m.getId()));
            m.setAvgRate(DAORate.getAVGRate(m.getId()));
            m.setPercent(getPercentBonus(m.getId()));
        }
        return result;
    }

    public static List<Movie> getTopViewMovieDay() {

        String query = "SELECT m.id, m.name,m.currentEpisode,m.totalEpisode, COUNT(*) AS total_views, (\n" +
                "    SELECT name \n" +
                "    FROM avatars_movie \n" +
                "    WHERE idMovie = m.id \n" +
                "    LIMIT 1\n" +
                ") AS avatar\n" +
                "FROM user_views uv\n" +
                "JOIN movies m ON uv.idMovie = m.id\n" +

                "WHERE DATE(uv.watchAt) = CURDATE() and m.status =1 \n" +
                "GROUP BY m.id\n" +
                "ORDER BY total_views DESC\n" +
                "LIMIT 5;";
        Jdbi me = JDBiConnector.me();
        List<Movie> result = me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Movie.class).list();
        });
        for (Movie m : result) {
            m.setAvatars(getAvatarMovie(m.getId()));
            m.setGenres(getListGenre(m.getId()));
            m.setType(getTypeMovie(m.getId()));
            m.setViews(getViewsMovie(m.getId()));
            m.setAvgRate(DAORate.getAVGRate(m.getId()));
        }

        return result;
    }

    public static List<Movie> getTopViewMovieMonth() {

        String query = "SELECT m.id, m.name, m.currentEpisode, m.totalEpisode, COUNT(*) AS total_views, (\n" +
                "    SELECT name \n" +
                "    FROM avatars_movie \n" +
                "    WHERE idMovie = m.id \n" +
                "    LIMIT 1\n" +
                ") AS avatar\n" +
                "FROM user_views uv\n" +
                "JOIN movies m ON uv.idMovie = m.id\n" +

                "WHERE YEAR(uv.watchAt) = YEAR(CURDATE()) AND MONTH(uv.watchAt) = MONTH(CURDATE())\n and m.status =1 " +
                "GROUP BY m.id\n" +
                "ORDER BY total_views DESC\n" +
                "LIMIT 5;";
        Jdbi me = JDBiConnector.me();
        List<Movie> result = me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Movie.class).list();
        });
        for (Movie m : result) {
            m.setAvatars(getAvatarMovie(m.getId()));
            m.setGenres(getListGenre(m.getId()));
            m.setType(getTypeMovie(m.getId()));
            m.setViews(getViewsMovie(m.getId()));
            m.setAvgRate(DAORate.getAVGRate(m.getId()));
        }

        return result;
    }

    public static List<Movie> getTopViewMovieYear() {

        String query = "SELECT m.id, m.name, m.currentEpisode, m.totalEpisode, COUNT(*) AS total_views, (\n" +
                "    SELECT name \n" +
                "    FROM avatars_movie \n" +
                "    WHERE idMovie = m.id \n" +
                "    LIMIT 1\n" +
                ") AS avatar\n" +
                "FROM user_views uv\n" +
                "JOIN movies m ON uv.idMovie = m.id\n" +

                "WHERE YEAR(uv.watchAt) = YEAR(CURDATE()) and m.status =1\n" +
                "GROUP BY m.id\n" +
                "ORDER BY total_views DESC\n" +
                "LIMIT 5;\n";
        Jdbi me = JDBiConnector.me();
        List<Movie> result = me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Movie.class).list();
        });
        for (Movie m : result) {
            m.setTotalEpisode(m.getTotalEpisode());
            m.setAvatars(getAvatarMovie(m.getId()));
            m.setGenres(getListGenre(m.getId()));
            m.setType(getTypeMovie(m.getId()));
            m.setViews(getViewsMovie(m.getId()));
            m.setAvgRate(DAORate.getAVGRate(m.getId()));
        }

        return result;
    }

    public static void main(String[] args) {

    }


}