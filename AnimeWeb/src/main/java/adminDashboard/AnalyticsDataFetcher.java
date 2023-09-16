package adminDashboard;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.analytics.Analytics;
import com.google.api.services.analytics.AnalyticsScopes;
import com.google.api.services.analytics.model.GaData;
import com.google.api.services.analytics.model.GaData.ColumnHeaders;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

public class AnalyticsDataFetcher {
    private static final String APPLICATION_NAME = "Your Application Name";
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
    private static final String KEY_FILE_LOCATION = "C:/Users/Admin/OneDrive/Documents/GitHub/LTWEB/LTWEB/AnimeWeb/src/main/webapp/admin/projectnhom8-371706-c149724a2618.jso";
    private static final String VIEW_ID = "ga:380852987";

    public static void main(String[] args) {
        try {
            // Khởi tạo dịch vụ Analytics
            Analytics analytics = initializeAnalytics();

            // Truy vấn dữ liệu từ Google Analytics API
            GaData data = queryAnalyticsData(analytics);

            // Lấy các thông tin cần thiết từ kết quả truy vấn
            List<ColumnHeaders> headers = data.getColumnHeaders();
            List<List<String>> rows = data.getRows();

            // In kết quả
            printData(headers, rows);
        } catch (IOException | GeneralSecurityException e) {
            e.printStackTrace();
        }
    }

    private static Analytics initializeAnalytics() throws GeneralSecurityException, IOException {
        // Tạo đối tượng Credential từ tệp JSON
        GoogleCredential credential = GoogleCredential.fromStream(new FileInputStream(KEY_FILE_LOCATION))
                .createScoped(AnalyticsScopes.all());

        // Khởi tạo transport HTTP và dịch vụ Analytics
        HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
        return new Analytics.Builder(httpTransport, JSON_FACTORY, credential)
                .setApplicationName(APPLICATION_NAME)
                .build();
    }

    private static GaData queryAnalyticsData(Analytics analytics) throws IOException {
        // Tạo truy vấn để lấy dữ liệu từ Analytics API
        GaData data = analytics.data().ga().get(VIEW_ID, "2023-01-01", "2023-12-31", "ga:users,ga:sessions")
                .setDimensions("ga:date,ga:country")
                .setMaxResults(1000)
                .execute();

        return data;
    }

    private static void printData(List<ColumnHeaders> headers, List<List<String>> rows) {
        // In các tiêu đề cột
        for (ColumnHeaders header : headers) {
            System.out.print(header.getName() + "\t");
        }
        System.out.println();

        // In dữ liệu từng hàng
        for (List<String> row : rows) {
            for (String value : row) {
                System.out.print(value + "\t");
            }
            System.out.println();
        }
    }
}
