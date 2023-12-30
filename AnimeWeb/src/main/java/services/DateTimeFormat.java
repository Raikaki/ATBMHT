package services;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateTimeFormat {
    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss | dd-MM-yyyy");
    public String format(LocalDateTime dateTime){

            return dateTime!=null?dateTime.format(formatter):"";

    }

}
