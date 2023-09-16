package database;

import Log.Log;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class DAOLog {
    public static List<Log> logList(){
        String query="SELECT id,`level`,`user` as userId,`ip`,`src`,`content`,`createAt`,`status` FROM logs where status=1 order by createAt desc;";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> {
            return handle.createQuery(query).mapToBean(Log.class).list();
        });
    }
    public static boolean remove500Log(){
        String query="              UPDATE logs SET status = '0' WHERE id IN (SELECT id FROM (\n" +
                "                   SELECT id\n" +
                "                   FROM logs where status=1" +
                "                   ORDER BY createAt ASC\n" +
                "                   LIMIT 500\n" +
                "                ) AS subquery);";
        Jdbi me = JDBiConnector.me();
        return me.withHandle(handle -> handle.createUpdate(query).execute())>0;
    }

}
