package socket;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import javax.websocket.OnClose;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@ServerEndpoint(value = "/observer")
public class UserUpdateEndpoint {
    private static Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session) throws IOException {
        sessions.add(session);
    }

    @OnClose
    public void onClose(Session session) throws IOException {
        sessions.remove(session);
    }

    public static void notifyUserUpdate(int idUser,String type) throws IOException {
        Gson gson = new Gson();
        JsonObject main = new JsonObject();
        main.addProperty("idUser",idUser);
        main.addProperty("type",type);
        for (Session session : sessions) {
            if (session.isOpen()) {
                session.getBasicRemote().sendText(gson.toJson(main));
            }
        }
    }
    public static void notifyUserUpdateRole(List<String> idUsers) throws IOException {
        Gson gson = new Gson();
        JsonObject object = new JsonObject();
        object.addProperty("listId",gson.toJson(idUsers));
        for (Session session : sessions) {
            if (session.isOpen()) {
                session.getBasicRemote().sendText(gson.toJson(object));
            }
        }
    }


}
