package model;

import java.util.HashMap;
import java.util.Map;

public class Status {
    static Map<Integer, String> statusMapping = new HashMap<>();
    static {
        statusMapping.put(0, "Bị ẩn");
        statusMapping.put(1, "Hiển thị");
    }
    public static String hidden(){
        return statusMapping.get(0);
    }
    public static String display(){
        return statusMapping.get(1);
    }

}
